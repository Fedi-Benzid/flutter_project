import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/domain/entities/entities.dart';
import '../../data/api_events_repository.dart';
import '../../domain/events_repository.dart';

/// Provider for the events repository.
/// Now uses the real API repository instead of mock
final eventsRepositoryProvider = Provider<EventsRepository>((ref) {
  return ApiEventsRepository();
});

/// Provider for all events.
final allEventsProvider = FutureProvider<List<Event>>((ref) async {
  final repository = ref.watch(eventsRepositoryProvider);
  return repository.getEvents();
});

/// Provider for events of a specific center.
final eventsByCenterProvider = FutureProvider.family<List<Event>, String>((
  ref,
  centerId,
) async {
  final repository = ref.watch(eventsRepositoryProvider);
  return repository.getEvents(centerId: centerId);
});

/// Provider for a single event by ID.
final eventByIdProvider = FutureProvider.family<Event, String>((ref, id) async {
  final repository = ref.watch(eventsRepositoryProvider);
  return repository.getEvent(id);
});

/// Provider for event participations.
final eventParticipationsProvider =
    FutureProvider.family<List<EventParticipation>, String>((
  ref,
  eventId,
) async {
  final repository = ref.watch(eventsRepositoryProvider);
  return repository.getParticipations(eventId);
});

/// Notifier for managing event operations.
class EventsNotifier extends StateNotifier<AsyncValue<void>> {
  final EventsRepository _repository;
  final Ref _ref;

  EventsNotifier(this._repository, this._ref)
      : super(const AsyncValue.data(null));

  Future<Event?> createEvent(Event event) async {
    state = const AsyncValue.loading();
    try {
      final created = await _repository.createEvent(event);
      state = const AsyncValue.data(null);
      _ref.invalidate(allEventsProvider);
      return created;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return null;
    }
  }

  Future<Event?> updateEvent(String id, Event event) async {
    state = const AsyncValue.loading();
    try {
      final updated = await _repository.updateEvent(id, event);
      state = const AsyncValue.data(null);
      _ref.invalidate(allEventsProvider);
      _ref.invalidate(eventByIdProvider(id));
      return updated;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return null;
    }
  }

  Future<bool> deleteEvent(String id) async {
    state = const AsyncValue.loading();
    try {
      await _repository.deleteEvent(id);
      state = const AsyncValue.data(null);
      _ref.invalidate(allEventsProvider);
      return true;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return false;
    }
  }

  Future<EventParticipation?> requestParticipation(String eventId) async {
    state = const AsyncValue.loading();
    try {
      final participation = await _repository.requestParticipation(eventId);
      state = const AsyncValue.data(null);
      _ref.invalidate(eventParticipationsProvider(eventId));
      _ref.invalidate(eventByIdProvider(eventId));
      return participation;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return null;
    }
  }

  Future<bool> updateParticipationStatus(
    String participationId,
    String eventId,
    ParticipationStatus status,
  ) async {
    state = const AsyncValue.loading();
    try {
      await _repository.updateParticipationStatus(
          participationId, eventId, status);
      state = const AsyncValue.data(null);
      _ref.invalidate(eventParticipationsProvider(eventId));
      _ref.invalidate(eventByIdProvider(eventId));
      return true;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return false;
    }
  }
}

/// Provider for the events notifier.
final eventsNotifierProvider =
    StateNotifierProvider<EventsNotifier, AsyncValue<void>>((ref) {
  final repository = ref.watch(eventsRepositoryProvider);
  return EventsNotifier(repository, ref);
});
