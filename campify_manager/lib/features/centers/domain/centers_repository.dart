import '../../../core/domain/entities/entities.dart';

/// Abstract repository interface for centers operations.
///
/// This interface defines the contract for center management services.
abstract class CentersRepository {
  /// Get all centers with optional filtering.
  Future<List<CampingCenter>> getCenters({
    String? search,
    List<String>? tags,
    bool? isInteresting,
  });

  /// Get a single center by ID.
  Future<CampingCenter> getCenter(String id);

  /// Create a new center (owner only).
  Future<CampingCenter> createCenter(CampingCenter center);

  /// Update an existing center (owner only).
  Future<CampingCenter> updateCenter(String id, CampingCenter center);

  /// Delete a center (owner only).
  Future<void> deleteCenter(String id);

  /// Get reviews for a center.
  Future<List<Review>> getCenterReviews(String centerId);

  /// Create a review for a center.
  Future<Review> createReview(Review review);

  /// Update a review.
  Future<Review> updateReview(String id, Review review);

  /// Delete a review.
  Future<void> deleteReview(String id);

  /// Get centers owned by the current user.
  Future<List<CampingCenter>> getOwnedCenters();
}
