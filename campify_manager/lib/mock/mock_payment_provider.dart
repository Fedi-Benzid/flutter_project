import 'dart:math';

/// Mock payment provider simulating Stripe-like payment processing.
///
/// This class provides a mocked payment flow for demo purposes.
/// It simulates:
/// - Card validation
/// - Payment processing with success/failure scenarios
/// - Transaction ID generation
///
/// NO REAL PAYMENTS ARE PROCESSED. This is purely for demonstration.
class MockPaymentProvider {
  MockPaymentProvider._();
  static final MockPaymentProvider instance = MockPaymentProvider._();

  final _random = Random();

  /// Whether to simulate payment failures (for testing error handling).
  /// Set to true to make approximately 20% of payments fail.
  bool simulateRandomFailures = false;

  /// Force the next payment to fail (for testing).
  bool forceNextPaymentToFail = false;

  /// Process a mock payment.
  ///
  /// [amount] - The amount to charge in the currency's smallest unit (e.g., cents)
  /// [currency] - Currency code (default: USD)
  /// [cardNumber] - Mock card number (4242424242424242 always succeeds)
  /// [expiryMonth] - Card expiry month
  /// [expiryYear] - Card expiry year
  /// [cvc] - Card CVC
  ///
  /// Returns a [PaymentResult] with success/failure status.
  Future<PaymentResult> processPayment({
    required double amount,
    String currency = 'USD',
    required String cardNumber,
    required int expiryMonth,
    required int expiryYear,
    required String cvc,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 1500));

    // Check for forced failure
    if (forceNextPaymentToFail) {
      forceNextPaymentToFail = false;
      return PaymentResult.failure(
        errorCode: 'card_declined',
        errorMessage: 'Your card was declined. Please try a different card.',
      );
    }

    // Validate card number format
    final cleanCardNumber = cardNumber.replaceAll(RegExp(r'\s+'), '');
    if (cleanCardNumber.length < 13 || cleanCardNumber.length > 19) {
      return PaymentResult.failure(
        errorCode: 'invalid_card_number',
        errorMessage: 'Invalid card number.',
      );
    }

    // Validate expiry
    final now = DateTime.now();
    if (expiryYear < now.year ||
        (expiryYear == now.year && expiryMonth < now.month)) {
      return PaymentResult.failure(
        errorCode: 'expired_card',
        errorMessage: 'Your card has expired.',
      );
    }

    // Validate CVC
    if (cvc.length < 3 || cvc.length > 4) {
      return PaymentResult.failure(
        errorCode: 'invalid_cvc',
        errorMessage: 'Invalid security code.',
      );
    }

    // Test card numbers that trigger specific behaviors
    // 4242424242424242 - Always succeeds
    // 4000000000000002 - Always declines
    // 4000000000009995 - Insufficient funds
    if (cleanCardNumber == '4000000000000002') {
      return PaymentResult.failure(
        errorCode: 'card_declined',
        errorMessage: 'Your card was declined.',
      );
    }

    if (cleanCardNumber == '4000000000009995') {
      return PaymentResult.failure(
        errorCode: 'insufficient_funds',
        errorMessage: 'Your card has insufficient funds.',
      );
    }

    // Random failure simulation
    if (simulateRandomFailures && _random.nextDouble() < 0.2) {
      return PaymentResult.failure(
        errorCode: 'processing_error',
        errorMessage:
            'An error occurred while processing your payment. Please try again.',
      );
    }

    // Success!
    return PaymentResult.success(
      transactionId: _generateTransactionId(),
      amount: amount,
      currency: currency,
      last4: cleanCardNumber.substring(cleanCardNumber.length - 4),
      cardBrand: _detectCardBrand(cleanCardNumber),
    );
  }

  /// Generate a mock transaction ID.
  String _generateTransactionId() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final random = _random.nextInt(999999).toString().padLeft(6, '0');
    return 'txn_mock_${timestamp}_$random';
  }

  /// Detect card brand from card number.
  String _detectCardBrand(String cardNumber) {
    if (cardNumber.startsWith('4')) {
      return 'Visa';
    } else if (cardNumber.startsWith('5') || cardNumber.startsWith('2')) {
      return 'Mastercard';
    } else if (cardNumber.startsWith('34') || cardNumber.startsWith('37')) {
      return 'American Express';
    } else if (cardNumber.startsWith('6')) {
      return 'Discover';
    }
    return 'Card';
  }

  /// Get a masked display string for the card.
  String getMaskedCard(String cardNumber, String brand) {
    final last4 = cardNumber.replaceAll(RegExp(r'\s+'), '');
    return '$brand •••• ${last4.substring(last4.length - 4)}';
  }

  /// Demo card numbers for testing.
  static const demoCards = {
    'success': '4242 4242 4242 4242',
    'decline': '4000 0000 0000 0002',
    'insufficient_funds': '4000 0000 0000 9995',
  };
}

/// Result of a payment processing attempt.
class PaymentResult {
  final bool isSuccess;
  final String? transactionId;
  final double? amount;
  final String? currency;
  final String? last4;
  final String? cardBrand;
  final String? errorCode;
  final String? errorMessage;

  const PaymentResult._({
    required this.isSuccess,
    this.transactionId,
    this.amount,
    this.currency,
    this.last4,
    this.cardBrand,
    this.errorCode,
    this.errorMessage,
  });

  factory PaymentResult.success({
    required String transactionId,
    required double amount,
    required String currency,
    required String last4,
    required String cardBrand,
  }) {
    return PaymentResult._(
      isSuccess: true,
      transactionId: transactionId,
      amount: amount,
      currency: currency,
      last4: last4,
      cardBrand: cardBrand,
    );
  }

  factory PaymentResult.failure({
    required String errorCode,
    required String errorMessage,
  }) {
    return PaymentResult._(
      isSuccess: false,
      errorCode: errorCode,
      errorMessage: errorMessage,
    );
  }

  /// Get a display-friendly payment method string.
  String get displayPaymentMethod {
    if (isSuccess && cardBrand != null && last4 != null) {
      return '$cardBrand •••• $last4';
    }
    return '';
  }
}
