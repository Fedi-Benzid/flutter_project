import '../../../core/domain/entities/entities.dart';
import '../../../mock/mock_server.dart';
import '../domain/reservations_repository.dart';

/// Mock implementation of [ReservationsRepository].
class MockReservationsRepository implements ReservationsRepository {
  final MockServer _mockServer;

  MockReservationsRepository({MockServer? mockServer})
    : _mockServer = mockServer ?? MockServer.instance;

  @override
  Future<List<Reservation>> getReservations() async {
    return _mockServer.getReservations();
  }

  @override
  Future<List<Reservation>> getOwnerReservations() async {
    return _mockServer.getReservations(ownerView: true);
  }

  @override
  Future<Reservation> getReservation(String id) async {
    return _mockServer.getReservation(id);
  }

  @override
  Future<Reservation> createReservation(Reservation reservation) async {
    return _mockServer.createReservation(reservation);
  }

  @override
  Future<Reservation> updateStatus(String id, ReservationStatus status) async {
    return _mockServer.updateReservationStatus(id, status);
  }

  @override
  Future<void> cancelReservation(String id) async {
    await _mockServer.cancelReservation(id);
  }
}
