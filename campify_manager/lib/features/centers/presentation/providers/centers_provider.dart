import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/domain/entities/entities.dart';
import '../../data/mock_centers_repository.dart';
import '../../domain/centers_repository.dart';

/// Provider for the centers repository.
final centersRepositoryProvider = Provider<CentersRepository>((ref) {
  return MockCentersRepository();
});

/// Provider for all centers with optional filters.
final centersProvider =
    FutureProvider.family<List<CampingCenter>, CentersFilter>((
      ref,
      filter,
    ) async {
      final repository = ref.watch(centersRepositoryProvider);
      return repository.getCenters(
        search: filter.search,
        tags: filter.tags,
        isInteresting: filter.isInteresting,
      );
    });

/// Provider for featured/interesting centers.
final featuredCentersProvider = FutureProvider<List<CampingCenter>>((
  ref,
) async {
  final repository = ref.watch(centersRepositoryProvider);
  return repository.getCenters(isInteresting: true);
});

/// Provider for a single center by ID.
final centerByIdProvider = FutureProvider.family<CampingCenter, String>((
  ref,
  id,
) async {
  final repository = ref.watch(centersRepositoryProvider);
  return repository.getCenter(id);
});

/// Provider for reviews of a specific center.
final centerReviewsProvider = FutureProvider.family<List<Review>, String>((
  ref,
  centerId,
) async {
  final repository = ref.watch(centersRepositoryProvider);
  return repository.getCenterReviews(centerId);
});

/// Provider for centers owned by the current user.
final ownedCentersProvider = FutureProvider<List<CampingCenter>>((ref) async {
  final repository = ref.watch(centersRepositoryProvider);
  return repository.getOwnedCenters();
});

/// State provider for search query.
final centersSearchQueryProvider = StateProvider<String>((ref) => '');

/// State provider for selected tags.
final centersSelectedTagsProvider = StateProvider<List<String>>((ref) => []);

/// Combined filter for centers list.
class CentersFilter {
  final String? search;
  final List<String>? tags;
  final bool? isInteresting;

  const CentersFilter({this.search, this.tags, this.isInteresting});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CentersFilter &&
        other.search == search &&
        _listEquals(other.tags, tags) &&
        other.isInteresting == isInteresting;
  }

  @override
  int get hashCode => Object.hash(search, tags, isInteresting);

  static bool _listEquals<T>(List<T>? a, List<T>? b) {
    if (a == null) return b == null;
    if (b == null || a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}

/// Provider for the current centers filter based on search and tags.
final currentCentersFilterProvider = Provider<CentersFilter>((ref) {
  final search = ref.watch(centersSearchQueryProvider);
  final tags = ref.watch(centersSelectedTagsProvider);

  return CentersFilter(
    search: search.isEmpty ? null : search,
    tags: tags.isEmpty ? null : tags,
  );
});

/// Provider for filtered centers list.
final filteredCentersProvider = FutureProvider<List<CampingCenter>>((
  ref,
) async {
  final filter = ref.watch(currentCentersFilterProvider);
  final repository = ref.watch(centersRepositoryProvider);
  return repository.getCenters(
    search: filter.search,
    tags: filter.tags,
    isInteresting: filter.isInteresting,
  );
});

/// Notifier for managing center operations.
class CentersNotifier extends StateNotifier<AsyncValue<void>> {
  final CentersRepository _repository;
  final Ref _ref;

  CentersNotifier(this._repository, this._ref)
    : super(const AsyncValue.data(null));

  Future<CampingCenter?> createCenter(CampingCenter center) async {
    state = const AsyncValue.loading();
    try {
      final created = await _repository.createCenter(center);
      state = const AsyncValue.data(null);
      // Invalidate providers to refresh data
      _ref.invalidate(ownedCentersProvider);
      _ref.invalidate(filteredCentersProvider);
      return created;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return null;
    }
  }

  Future<CampingCenter?> updateCenter(String id, CampingCenter center) async {
    state = const AsyncValue.loading();
    try {
      final updated = await _repository.updateCenter(id, center);
      state = const AsyncValue.data(null);
      _ref.invalidate(centerByIdProvider(id));
      _ref.invalidate(ownedCentersProvider);
      _ref.invalidate(filteredCentersProvider);
      return updated;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return null;
    }
  }

  Future<bool> deleteCenter(String id) async {
    state = const AsyncValue.loading();
    try {
      await _repository.deleteCenter(id);
      state = const AsyncValue.data(null);
      _ref.invalidate(ownedCentersProvider);
      _ref.invalidate(filteredCentersProvider);
      return true;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return false;
    }
  }

  Future<Review?> createReview(Review review) async {
    state = const AsyncValue.loading();
    try {
      final created = await _repository.createReview(review);
      state = const AsyncValue.data(null);
      _ref.invalidate(centerReviewsProvider(review.centerId));
      _ref.invalidate(centerByIdProvider(review.centerId));
      return created;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return null;
    }
  }

  Future<bool> deleteReview(String id, String centerId) async {
    state = const AsyncValue.loading();
    try {
      await _repository.deleteReview(id);
      state = const AsyncValue.data(null);
      _ref.invalidate(centerReviewsProvider(centerId));
      _ref.invalidate(centerByIdProvider(centerId));
      return true;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return false;
    }
  }
}

/// Provider for the centers notifier.
final centersNotifierProvider =
    StateNotifierProvider<CentersNotifier, AsyncValue<void>>((ref) {
      final repository = ref.watch(centersRepositoryProvider);
      return CentersNotifier(repository, ref);
    });
