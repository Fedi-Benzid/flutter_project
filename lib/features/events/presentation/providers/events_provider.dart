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

/// Provider for current user's participations across all events.
final myParticipationsProvider =
    FutureProvider<List<EventParticipation>>((ref) async {
  final repository = ref.watch(eventsRepositoryProvider);
  return repository.getMyParticipations();
});

/// Provider for current user's participation for a specific event.
/// Returns null if the user has not requested to participate.
final myParticipationForEventProvider =
    FutureProvider.family<EventParticipation?, String>((ref, eventId) async {
  final participations = await ref.watch(myParticipationsProvider.future);
  try {
    return participations.firstWhere((p) => p.eventId == eventId);
  } catch (_) {
    return null;
  }
});

/// Provider for event ratings.
final eventRatingsProvider =
    FutureProvider.family<List<EventRating>, String>((ref, eventId) async {
  final repository = ref.watch(eventsRepositoryProvider);
  return repository.getEventRatings(eventId);
});

/// Provider for average event rating.
final eventAverageRatingProvider =
    FutureProvider.family<double?, String>((ref, eventId) async {
  final repository = ref.watch(eventsRepositoryProvider);
  return repository.getAverageRating(eventId);
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
      // Invalidate all related caches
      _ref.invalidate(allEventsProvider);
      _ref.invalidate(eventByIdProvider(id));
      _ref.invalidate(eventParticipationsProvider(id));
      // Also invalidate center-specific events in case center changed
      _ref.invalidateSelf();
      return updated;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return null;
    }
  }

  Future<Event?> closeEvent(String id) async {
    state = const AsyncValue.loading();
    try {
      final closed = await _repository.closeEvent(id);
      state = const AsyncValue.data(null);
      _ref.invalidate(allEventsProvider);
      _ref.invalidate(eventByIdProvider(id));
      return closed;
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

  Future<EventParticipation?> requestParticipation(String eventId, {int numberOfPersons = 1}) async {
    state = const AsyncValue.loading();
    try {
      final participation = await _repository.requestParticipation(eventId, numberOfPersons: numberOfPersons);
      state = const AsyncValue.data(null);
      // Invalidate all related caches
      _ref.invalidate(eventParticipationsProvider(eventId));
      _ref.invalidate(eventByIdProvider(eventId));
      _ref.invalidate(myParticipationsProvider);
      _ref.invalidate(myParticipationForEventProvider(eventId));
      _ref.invalidate(allEventsProvider);
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
      // Invalidate all related participation caches
      _ref.invalidate(eventParticipationsProvider(eventId));
      _ref.invalidate(eventByIdProvider(eventId));
      _ref.invalidate(myParticipationsProvider);
      _ref.invalidate(myParticipationForEventProvider(eventId));
      return true;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return false;
    }
  }

  Future<EventParticipation?> updateMyParticipation(
    String participationId,
    String eventId,
    int numberOfPersons,
  ) async {
    state = const AsyncValue.loading();
    try {
      final participation = await _repository.updateMyParticipation(
          participationId, eventId, numberOfPersons);
      state = const AsyncValue.data(null);
      // Invalidate all related caches
      _ref.invalidate(eventParticipationsProvider(eventId));
      _ref.invalidate(eventByIdProvider(eventId));
      _ref.invalidate(myParticipationsProvider);
      _ref.invalidate(myParticipationForEventProvider(eventId));
      _ref.invalidate(allEventsProvider);
      return participation;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return null;
    }
  }

  Future<bool> cancelParticipation(String participationId, String eventId) async {
    state = const AsyncValue.loading();
    try {
      await _repository.cancelParticipation(participationId, eventId);
      state = const AsyncValue.data(null);
      // Invalidate all related caches
      _ref.invalidate(eventParticipationsProvider(eventId));
      _ref.invalidate(eventByIdProvider(eventId));
      _ref.invalidate(myParticipationsProvider);
      _ref.invalidate(myParticipationForEventProvider(eventId));
      _ref.invalidate(allEventsProvider);
      return true;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return false;
    }
  }

  Future<EventRating?> rateEvent(String eventId, int rating, String? comment) async {
    state = const AsyncValue.loading();
    try {
      final eventRating = await _repository.rateEvent(eventId, rating, comment);
      state = const AsyncValue.data(null);
      _ref.invalidate(eventRatingsProvider(eventId));
      _ref.invalidate(eventAverageRatingProvider(eventId));
      return eventRating;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return null;
    }
  }
}

/// Provider for the events notifier.
final eventsNotifierProvider =
    StateNotifierProvider<EventsNotifier, AsyncValue<void>>((ref) {
  final repository = ref.watch(eventsRepositoryProvider);
  return EventsNotifier(repository, ref);
});
