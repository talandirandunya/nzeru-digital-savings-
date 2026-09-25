import 'package:flutter/material.dart';
import '../models/loan.dart';
import '../models/loan_payment.dart';
import '../models/interest_distribution.dart';
import '../services/api_service.dart';

class LoanProvider with ChangeNotifier {
  final ApiService _api = ApiService();
  List<Loan> _loans = [];
  List<LoanPayment> _payments = [];
  List<InterestDistribution> _distributions = [];
  bool _isLoading = false;
  String? _error;

  List<Loan> get loans => _loans;
  List<LoanPayment> get payments => _payments;
  List<InterestDistribution> get distributions => _distributions;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Loan? get activeLoan => _loans.where(
        (l) => l.status == LoanStatus.active || l.status == LoanStatus.approved,
      ).firstOrNull;

  double get totalRepaid => _payments.fold(0.0, (sum, p) => sum + p.amountPaid);

  double getLoanEligibility(double savingsBalance) => savingsBalance * 0.5;

  Future<void> loadData() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final loansData = await _api.getLoans();
      _loans = loansData.map((json) => Loan.fromJson(
        _normalizeKeys(json as Map<String, dynamic>),
      )).toList();

      final paymentsData = await _api.getLoanPayments();
      _payments = paymentsData.map((json) => LoanPayment.fromJson(
        _normalizeKeys(json as Map<String, dynamic>),
      )).toList();

      final distData = await _api.getInterestDistributions();
      _distributions = distData.map((json) => InterestDistribution.fromJson(
        _normalizeKeys(json as Map<String, dynamic>),
      )).toList();
    } catch (e) {
      _error = 'Failed to load loan data';
      _loans = [];
      _payments = [];
      _distributions = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<Map<String, dynamic>?> checkEligibility() async {
    try {
      return await _api.getLoanEligibility();
    } catch (e) {
      _error = 'Failed to check loan eligibility';
      notifyListeners();
      return null;
    }
  }

  Future<bool> requestLoan(Loan loan) async {
    try {
      await _api.requestLoan({
        'amount': loan.amount,
        'interest_rate': loan.interestRate,
        'duration_months': loan.durationMonths,
        'due_date': loan.dueDate?.toIso8601String(),
      });
      await loadData();
      return true;
    } catch (e) {
      _error = 'Failed to request loan';
      notifyListeners();
      return false;
    }
  }

  Future<bool> makePayment(LoanPayment payment) async {
    try {
      await _api.makeLoanPayment({
        'loan': payment.loanId,
        'amount_paid': payment.amountPaid,
      });
      await loadData();
      return true;
    } catch (e) {
      _error = 'Failed to make payment';
      notifyListeners();
      return false;
    }
  }

  Map<String, dynamic> _normalizeKeys(Map<String, dynamic> json) {
    final normalized = Map<String, dynamic>.from(json);
    if (normalized['id'] != null) {
      normalized['id'] = normalized['id'].toString();
    }
    if (normalized['user'] != null) {
      normalized['user_id'] = normalized['user'].toString();
    }
    if (normalized['loan'] != null) {
      normalized['loan_id'] = normalized['loan'].toString();
    }
    return normalized;
  }
}
