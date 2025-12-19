import '../../../core/domain/entities/entities.dart';

/// Abstract repository interface for reservations.
abstract class ReservationsRepository {
  /// Get user's reservations.
  Future<List<Reservation>> getReservations();

  /// Get reservations for owner's centers.
  Future<List<Reservation>> getOwnerReservations();

  /// Get a single reservation by ID.
  Future<Reservation> getReservation(String id);

  /// Create a new reservation.
  Future<Reservation> createReservation(Reservation reservation);

  /// Update reservation status (owner only).
  Future<Reservation> updateStatus(String id, ReservationStatus status);

  /// Cancel a reservation.
  Future<void> cancelReservation(String id);
}
