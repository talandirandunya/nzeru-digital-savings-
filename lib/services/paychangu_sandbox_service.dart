import 'dart:convert';

import 'package:http/http.dart' as http;

class PayChanguSandboxService {
  const PayChanguSandboxService();

  static const String _baseUrl = String.fromEnvironment(
    'PAYCHANGU_SANDBOX_URL',
    defaultValue: 'https://api.paychangu.com/payment',
  );

  static const String _apiKey = String.fromEnvironment(
    'PAYCHANGU_SANDBOX_API_KEY',
    defaultValue: '',
  );

  static const String _merchantCode = String.fromEnvironment(
    'PAYCHANGU_SANDBOX_MERCHANT_CODE',
    defaultValue: '',
  );

  Future<Map<String, dynamic>> initiatePayment({
    required String pocketName,
    required double amount,
    required String currency,
    String? description,
  }) async {
    if (_apiKey.isEmpty) {
      throw Exception(
        'PayChangu sandbox API key is not configured. Set PAYCHANGU_SANDBOX_API_KEY.',
      );
    }

    final reference = 'NZR-${DateTime.now().millisecondsSinceEpoch}';
    final payload = <String, dynamic>{
      'reference': reference,
      'amount': amount.toStringAsFixed(2),
      'currency': currency,
      'description': (description ?? 'Nzeru Pocket funding').trim().isNotEmpty
          ? (description ?? 'Nzeru Pocket funding').trim()
          : 'Nzeru Pocket funding',
      'customer': {
        'name': pocketName,
        'email': 'user@nzeru.app',
      },
      'metadata': {
        'pocket_name': pocketName,
        'source': 'nzeru_mobile_app',
      },
    };

    if (_merchantCode.isNotEmpty) {
      payload['merchant_code'] = _merchantCode;
    }

    final requestUrl = _baseUrl.trim().endsWith('/')
        ? _baseUrl.trim().substring(0, _baseUrl.trim().length - 1)
        : _baseUrl.trim();

    final response = await http.post(
      Uri.parse(requestUrl),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $_apiKey',
      },
      body: jsonEncode(payload),
    ).timeout(const Duration(seconds: 30));

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception(
        'PayChangu checkout failed (${response.statusCode}): ${response.body}',
      );
    }

    final decoded = jsonDecode(response.body);
    final body = decoded is Map<String, dynamic>
        ? decoded
        : Map<String, dynamic>.from(decoded as Map);

    final paymentUrl = body['payment_url']?.toString() ??
        body['checkout_url']?.toString() ??
        body['data'] is Map ? (body['data'] as Map)['payment_url']?.toString() : null;

    return {
      'status': 'sandbox',
      'reference': body['reference']?.toString() ?? reference,
      'paymentUrl': paymentUrl ?? 'https://sandbox.paychangu.com/checkout/$reference',
      'currency': currency,
      'amount': amount,
      'pocketName': pocketName,
      'description': payload['description'],
      'message': body['message']?.toString() ?? 'Sandbox payment generated successfully.',
    };
  }
}
