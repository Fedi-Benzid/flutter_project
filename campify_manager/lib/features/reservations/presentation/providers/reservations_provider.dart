import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/domain/entities/entities.dart';
import '../../data/mock_reservations_repository.dart';
import '../../domain/reservations_repository.dart';

/// Provider for the reservations repository.
final reservationsRepositoryProvider = Provider<ReservationsRepository>((ref) {
  return MockReservationsRepository();
});

/// Provider for user's reservations.
final userReservationsProvider = FutureProvider<List<Reservation>>((ref) async {
  final repository = ref.watch(reservationsRepositoryProvider);
  return repository.getReservations();
});

/// Provider for owner's center reservations.
final ownerReservationsProvider = FutureProvider<List<Reservation>>((
  ref,
) async {
  final repository = ref.watch(reservationsRepositoryProvider);
  return repository.getOwnerReservations();
});

/// Provider for a single reservation.
final reservationByIdProvider = FutureProvider.family<Reservation, String>((
  ref,
  id,
) async {
  final repository = ref.watch(reservationsRepositoryProvider);
  return repository.getReservation(id);
});

/// Notifier for managing reservation operations.
class ReservationsNotifier extends StateNotifier<AsyncValue<void>> {
  final ReservationsRepository _repository;
  final Ref _ref;

  ReservationsNotifier(this._repository, this._ref)
    : super(const AsyncValue.data(null));

  Future<Reservation?> createReservation(Reservation reservation) async {
    state = const AsyncValue.loading();
    try {
      final created = await _repository.createReservation(reservation);
      state = const AsyncValue.data(null);
      _ref.invalidate(userReservationsProvider);
      _ref.invalidate(ownerReservationsProvider);
      return created;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return null;
    }
  }

  Future<bool> updateStatus(String id, ReservationStatus status) async {
    state = const AsyncValue.loading();
    try {
      await _repository.updateStatus(id, status);
      state = const AsyncValue.data(null);
      _ref.invalidate(userReservationsProvider);
      _ref.invalidate(ownerReservationsProvider);
      _ref.invalidate(reservationByIdProvider(id));
      return true;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return false;
    }
  }

  Future<bool> cancelReservation(String id) async {
    state = const AsyncValue.loading();
    try {
      await _repository.cancelReservation(id);
      state = const AsyncValue.data(null);
      _ref.invalidate(userReservationsProvider);
      _ref.invalidate(ownerReservationsProvider);
      return true;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return false;
    }
  }
}

/// Provider for the reservations notifier.
final reservationsNotifierProvider =
    StateNotifierProvider<ReservationsNotifier, AsyncValue<void>>((ref) {
      final repository = ref.watch(reservationsRepositoryProvider);
      return ReservationsNotifier(repository, ref);
    });
