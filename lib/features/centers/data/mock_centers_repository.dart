import '../../../core/domain/entities/entities.dart';
import '../../../mock/mock_server.dart';
import '../domain/centers_repository.dart';

/// Mock implementation of [CentersRepository].
class MockCentersRepository implements CentersRepository {
  final MockServer _mockServer;

  MockCentersRepository({MockServer? mockServer})
    : _mockServer = mockServer ?? MockServer.instance;

  @override
  Future<List<CampingCenter>> getCenters({
    String? search,
    List<String>? tags,
    bool? isInteresting,
  }) async {
    return _mockServer.getCenters(
      search: search,
      tags: tags,
      isInteresting: isInteresting,
    );
  }

  @override
  Future<CampingCenter> getCenter(String id) async {
    return _mockServer.getCenter(id);
  }

  @override
  Future<CampingCenter> createCenter(CampingCenter center) async {
    return _mockServer.createCenter(center);
  }

  @override
  Future<CampingCenter> updateCenter(String id, CampingCenter center) async {
    return _mockServer.updateCenter(id, center);
  }

  @override
  Future<void> deleteCenter(String id) async {
    await _mockServer.deleteCenter(id);
  }

  @override
  Future<List<Review>> getCenterReviews(String centerId) async {
    return _mockServer.getCenterReviews(centerId);
  }

  @override
  Future<Review> createReview(Review review) async {
    return _mockServer.createReview(review);
  }

  @override
  Future<Review> updateReview(String id, Review review) async {
    return _mockServer.updateReview(id, review);
  }

  @override
  Future<void> deleteReview(String id) async {
    await _mockServer.deleteReview(id);
  }

  @override
  Future<List<CampingCenter>> getOwnedCenters() async {
    final allCenters = await _mockServer.getCenters();
    final currentUserId = _mockServer.currentUserId;
    return allCenters.where((c) => c.ownerId == currentUserId).toList();
  }
}
