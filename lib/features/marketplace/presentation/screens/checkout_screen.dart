import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/router.dart';
import '../../../../core/domain/entities/entities.dart';
import '../../../../mock/mock_payment_provider.dart';
import '../providers/marketplace_provider.dart';

/// Checkout screen with payment form.
class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  final _cardNumberController = TextEditingController(
    text: MockPaymentProvider.demoCards['success'],
  );
  final _expiryController = TextEditingController(text: '12/25');
  final _cvcController = TextEditingController(text: '123');

  bool _isProcessing = false;
  bool _paymentComplete = false;
  Order? _completedOrder;

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryController.dispose();
    _cvcController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cartTotal = ref.watch(cartTotalProvider);
    final cartItems = ref.watch(cartProvider).valueOrNull ?? [];

    if (_paymentComplete && _completedOrder != null) {
      return _buildSuccessScreen(theme);
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Demo mode notice
            Card(
              color: theme.colorScheme.tertiaryContainer,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: theme.colorScheme.onTertiaryContainer,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Demo Mode - No Real Charges',
                            style: theme.textTheme.titleSmall?.copyWith(
                              color: theme.colorScheme.onTertiaryContainer,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Use test card: 4242 4242 4242 4242',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onTertiaryContainer,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Order summary
            Text(
              'Order Summary',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    ...cartItems.map(
                      (item) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                '${item.item.name} x${item.quantity}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text('${item.totalPrice.toStringAsFixed(2)} TND'),
                          ],
                        ),
                      ),
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Subtotal'),
                        Text('${cartTotal.toStringAsFixed(2)} TND'),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Service Fee (5%)'),
                        Text('${(cartTotal * 0.05).toStringAsFixed(2)} TND'),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${(cartTotal * 1.05).toStringAsFixed(2)} TND',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Payment form
            Text(
              'Payment Details',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _cardNumberController,
                    decoration: const InputDecoration(
                      labelText: 'Card Number',
                      prefixIcon: Icon(Icons.credit_card),
                      hintText: '4242 4242 4242 4242',
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter card number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _expiryController,
                          decoration: const InputDecoration(
                            labelText: 'MM/YY',
                            hintText: '12/25',
                          ),
                          keyboardType: TextInputType.datetime,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Required';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          controller: _cvcController,
                          decoration: const InputDecoration(
                            labelText: 'CVC',
                            hintText: '123',
                          ),
                          keyboardType: TextInputType.number,
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Required';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Test cards info
            ExpansionTile(
              title: const Text('Test Card Numbers'),
              children: [
                ListTile(
                  dense: true,
                  title: const Text('4242 4242 4242 4242'),
                  subtitle: const Text('Success'),
                  trailing: const Icon(Icons.check_circle, color: Colors.green),
                  onTap: () => _cardNumberController.text =
                      MockPaymentProvider.demoCards['success']!,
                ),
                ListTile(
                  dense: true,
                  title: const Text('4000 0000 0000 0002'),
                  subtitle: const Text('Decline'),
                  trailing: const Icon(Icons.cancel, color: Colors.red),
                  onTap: () => _cardNumberController.text =
                      MockPaymentProvider.demoCards['decline']!,
                ),
                ListTile(
                  dense: true,
                  title: const Text('4000 0000 0000 9995'),
                  subtitle: const Text('Insufficient Funds'),
                  trailing: const Icon(Icons.money_off, color: Colors.orange),
                  onTap: () => _cardNumberController.text =
                      MockPaymentProvider.demoCards['insufficient_funds']!,
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Pay button
            FilledButton(
              onPressed: _isProcessing ? null : _processPayment,
              child: _isProcessing
                  ? const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                        SizedBox(width: 12),
                        Text('Processing...'),
                      ],
                    )
                  : Text('Pay ${(cartTotal * 1.05).toStringAsFixed(2)} TND'),
            ),
            const SizedBox(height: 16),

            // Security notice
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.lock_outline,
                  size: 16,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 8),
                Text(
                  'Secure payment (demo mode)',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccessScreen(ThemeData theme) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check,
                  size: 64,
                  color: Colors.green.shade700,
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'Payment Successful!',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Your order has been placed',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 24),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _buildDetailRow('Order ID', _completedOrder!.id),
                      const SizedBox(height: 8),
                      _buildDetailRow(
                        'Amount',
                        '${_completedOrder!.totalAmount.toStringAsFixed(2)} TND',
                      ),
                      const SizedBox(height: 8),
                      _buildDetailRow(
                        'Status',
                        _completedOrder!.paymentStatus.displayName,
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => context.go(AppRoutes.home),
                  child: const Text('Continue Shopping'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }

  Future<void> _processPayment() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    setState(() => _isProcessing = true);

    // Parse expiry
    final expiryParts = _expiryController.text.split('/');
    final expiryMonth = int.tryParse(expiryParts[0]) ?? 12;
    final expiryYear = int.tryParse('20${expiryParts[1]}') ?? 2025;

    // Process mock payment
    final paymentResult = await MockPaymentProvider.instance.processPayment(
      amount: ref.read(cartTotalProvider) * 1.05,
      cardNumber: _cardNumberController.text,
      expiryMonth: expiryMonth,
      expiryYear: expiryYear,
      cvc: _cvcController.text,
    );

    if (!mounted) return;

    if (paymentResult.isSuccess) {
      // Create order
      final order = await ref.read(cartProvider.notifier).checkout();

      if (order != null) {
        setState(() {
          _isProcessing = false;
          _paymentComplete = true;
          _completedOrder = order.copyWith(
            paymentStatus: PaymentStatus.completed,
            transactionId: paymentResult.transactionId,
            paymentMethod: paymentResult.displayPaymentMethod,
            paidAt: DateTime.now(),
          );
        });
      }
    } else {
      setState(() => _isProcessing = false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(paymentResult.errorMessage ?? 'Payment failed'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    }
  }
}
