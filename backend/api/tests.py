import json
from unittest.mock import MagicMock, patch

from django.contrib.auth import get_user_model
from django.test import TestCase, override_settings
from rest_framework.test import APIRequestFactory, force_authenticate

from .views import assistant_chat


class AssistantChatTests(TestCase):
    def setUp(self):
        self.user = get_user_model().objects.create_user(
            username='assistant-test-user',
            password='not-a-real-password',
        )
        self.factory = APIRequestFactory()

    def post_chat(self, payload):
        request = self.factory.post('/api/assistant/chat/', payload, format='json')
        force_authenticate(request, user=self.user)
        return assistant_chat(request)

    @override_settings(AI_API_KEY='')
    def test_missing_provider_key_returns_fallback_response(self):
        response = self.post_chat({'message': 'How am I doing with savings?'})

        self.assertEqual(response.status_code, 200)
        self.assertIn('savings', response.data['reply'].lower())
        self.assertIn('balance', response.data['reply'].lower())

    @override_settings(
        AI_API_KEY='test-key',
        AI_API_BASE_URL='https://provider.example/v1',
        AI_MODEL='test-model',
    )
    @patch('api.views.urlopen')
    def test_general_question_does_not_attach_account_snapshot(self, mocked_urlopen):
        provider_response = MagicMock()
        provider_response.__enter__.return_value.read.return_value = json.dumps({
            'choices': [{'message': {'content': 'Here is a general answer.'}}]
        }).encode()
        mocked_urlopen.return_value = provider_response

        response = self.post_chat({'message': 'Why is the sky blue?'})

        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.data['reply'], 'Here is a general answer.')
        request = mocked_urlopen.call_args.args[0]
        payload = json.loads(request.data.decode())
        self.assertNotIn('Account snapshot', payload['messages'][0]['content'])
        self.assertEqual(payload['model'], 'test-model')

    @override_settings(
        AI_API_KEY='test-key',
        AI_API_BASE_URL='https://provider.example/v1',
        AI_MODEL='test-model',
    )
    @patch('api.views.urlopen')
    def test_financial_question_adds_authenticated_account_snapshot(self, mocked_urlopen):
        provider_response = MagicMock()
        provider_response.__enter__.return_value.read.return_value = json.dumps({
            'choices': [{'message': {'content': 'Your account answer.'}}]
        }).encode()
        mocked_urlopen.return_value = provider_response

        response = self.post_chat({'message': 'How are my savings?'})

        self.assertEqual(response.status_code, 200)
        request = mocked_urlopen.call_args.args[0]
        payload = json.loads(request.data.decode())
        prompt = payload['messages'][0]['content']
        self.assertIn('Account snapshot', prompt)
        self.assertNotIn(self.user.username, prompt)