import 'package:freezed_annotation/freezed_annotation.dart';
import 'item.dart';

part 'reservation.freezed.dart';
part 'reservation.g.dart';

/// Status of a reservation.
enum ReservationStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('approved')
  approved,
  @JsonValue('declined')
  declined,
  @JsonValue('cancelled')
  cancelled,
  @JsonValue('completed')
  completed,
}

/// Extension for reservation status display.
extension ReservationStatusExtension on ReservationStatus {
  String get displayName {
    switch (this) {
      case ReservationStatus.pending:
        return 'Pending Approval';
      case ReservationStatus.approved:
        return 'Approved';
      case ReservationStatus.declined:
        return 'Declined';
      case ReservationStatus.cancelled:
        return 'Cancelled';
      case ReservationStatus.completed:
        return 'Completed';
    }
  }

  bool get isActive {
    return this == ReservationStatus.pending ||
        this == ReservationStatus.approved;
  }
}

/// Reservation entity for booking a camping center.
///
/// A reservation includes:
/// - Date range for the stay
/// - Optional marketplace items (rentals)
/// - Status tracking (pending -> approved/declined)
/// - Associated payment/order
@freezed
class Reservation with _$Reservation {
  const factory Reservation({
    /// Unique identifier
    required String id,

    /// ID of the user making the reservation
    required String userId,

    /// ID of the camping center
    required String centerId,

    /// Check-in date
    required DateTime startDate,

    /// Check-out date
    required DateTime endDate,

    /// Number of guests
    @Default(1) int guestCount,

    /// Optional items rented with the reservation
    @Default([]) List<ReservationItem> items,

    /// Current status
    @Default(ReservationStatus.pending) ReservationStatus status,

    /// Base price for the stay (center price * nights)
    required double basePrice,

    /// Total price including items
    required double totalPrice,

    /// Special requests or notes
    String? notes,

    /// Associated order ID after payment
    String? orderId,

    /// When the reservation was created
    DateTime? createdAt,
  }) = _Reservation;

  factory Reservation.fromJson(Map<String, dynamic> json) =>
      _$ReservationFromJson(json);
}

/// Item included in a reservation.
@freezed
class ReservationItem with _$ReservationItem {
  const factory ReservationItem({
    /// ID of the marketplace item
    required String itemId,

    /// Name of the item (denormalized for display)
    required String itemName,

    /// Quantity reserved
    @Default(1) int quantity,

    /// Price per day
    required double pricePerDay,

    /// Total price for this item
    required double totalPrice,
  }) = _ReservationItem;

  factory ReservationItem.fromJson(Map<String, dynamic> json) =>
      _$ReservationItemFromJson(json);
}

/// Extension for reservation calculations.
extension ReservationExtension on Reservation {
  int get numberOfNights {
    return endDate.difference(startDate).inDays;
  }
}
