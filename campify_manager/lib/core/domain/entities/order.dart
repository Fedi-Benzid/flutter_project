import 'package:freezed_annotation/freezed_annotation.dart';

part 'order.freezed.dart';
part 'order.g.dart';

/// Payment status for orders.
enum PaymentStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('processing')
  processing,
  @JsonValue('completed')
  completed,
  @JsonValue('failed')
  failed,
  @JsonValue('refunded')
  refunded,
}

/// Extension for payment status display.
extension PaymentStatusExtension on PaymentStatus {
  String get displayName {
    switch (this) {
      case PaymentStatus.pending:
        return 'Pending Payment';
      case PaymentStatus.processing:
        return 'Processing';
      case PaymentStatus.completed:
        return 'Paid';
      case PaymentStatus.failed:
        return 'Payment Failed';
      case PaymentStatus.refunded:
        return 'Refunded';
    }
  }

  bool get isSuccessful => this == PaymentStatus.completed;
}

/// Order entity for tracking purchases and payments.
///
/// Orders are created when:
/// - A camper completes checkout for marketplace items
/// - A reservation is confirmed and paid
@freezed
class Order with _$Order {
  const factory Order({
    /// Unique identifier
    required String id,

    /// ID of the user who placed the order
    required String userId,

    /// Optional associated reservation ID
    String? reservationId,

    /// List of items in the order
    @Default([]) List<OrderItem> items,

    /// Subtotal before any fees
    required double subtotal,

    /// Service/booking fee
    @Default(0) double serviceFee,

    /// Total amount to pay
    required double totalAmount,

    /// Current payment status
    @Default(PaymentStatus.pending) PaymentStatus paymentStatus,

    /// Payment method used (for display)
    String? paymentMethod,

    /// Mock payment transaction ID
    String? transactionId,

    /// When the order was created
    DateTime? createdAt,

    /// When payment was completed
    DateTime? paidAt,
  }) = _Order;

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
}

/// Individual item in an order.
@freezed
class OrderItem with _$OrderItem {
  const factory OrderItem({
    /// ID of the marketplace item
    required String itemId,

    /// Name of the item
    required String name,

    /// Quantity ordered
    @Default(1) int quantity,

    /// Unit price
    required double unitPrice,

    /// Total for this line item
    required double totalPrice,

    /// Whether this is a rental or purchase
    @Default(false) bool isRental,

    /// Number of rental days (if rental)
    int? rentalDays,
  }) = _OrderItem;

  factory OrderItem.fromJson(Map<String, dynamic> json) =>
      _$OrderItemFromJson(json);
}
