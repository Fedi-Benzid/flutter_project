import 'reservations_api_service.dart';
import '../domain/reservations_repository.dart';
import '../../../core/domain/entities/entities.dart';

/// Real API implementation of [ReservationsRepository]
class ApiReservationsRepository implements ReservationsRepository {
  final ReservationsApiService _apiService;

  ApiReservationsRepository({ReservationsApiService? apiService})
      : _apiService = apiService ?? ReservationsApiService();

  @override
  Future<List<Reservation>> getReservations() async {
    final data = await _apiService.getUserReservations();
    return data.map((json) => _transformReservation(json)).toList();
  }

  @override
  Future<List<Reservation>> getOwnerReservations() async {
    final data = await _apiService.getOwnerReservations();
    return data.map((json) => _transformReservation(json)).toList();
  }

  @override
  Future<Reservation> getReservation(String id) async {
    final data = await _apiService.getReservation(id);
    return _transformReservation(data);
  }

  @override
  Future<Reservation> createReservation(Reservation reservation) async {
    final data = await _apiService.createReservation(
      centerId: reservation.centerId,
      checkInDate: reservation.startDate,
      checkOutDate: reservation.endDate,
      guests: reservation.guestCount,
    );
    return _transformReservation(data);
  }

  @override
  Future<Reservation> updateStatus(String id, ReservationStatus status) async {
    throw UnimplementedError('Update status not yet implemented');
  }

  @override
  Future<void> cancelReservation(String id) async {
    await _apiService.cancelReservation(id);
  }

  Reservation _transformReservation(Map<String, dynamic> json) {
    final centerJson = json['center'] as Map<String, dynamic>?;
    final checkIn = json['checkInDate'] as String?;
    final checkOut = json['checkOutDate'] as String?;
    final totalPrice = (json['totalPrice'] as num?)?.toDouble() ?? 0;

    return Reservation(
      id: json['id'].toString(),
      userId: (json['user'] as Map<String, dynamic>?)?['id']?.toString() ?? '',
      centerId: centerJson?['id']?.toString() ?? '',
      startDate: checkIn != null ? DateTime.parse(checkIn) : DateTime.now(),
      endDate: checkOut != null ? DateTime.parse(checkOut) : DateTime.now(),
      guestCount: json['guests'] as int? ?? 1,
      status: _parseStatus(json['status'] as String?),
      basePrice: totalPrice,
      totalPrice: totalPrice,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
    );
  }

  ReservationStatus _parseStatus(String? status) {
    switch (status) {
      case 'CONFIRMED':
        return ReservationStatus.approved;
      case 'CANCELLED':
        return ReservationStatus.cancelled;
      case 'COMPLETED':
        return ReservationStatus.completed;
      default:
        return ReservationStatus.pending;
    }
  }
}
