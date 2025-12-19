import 'centers_api_service.dart';
import '../domain/centers_repository.dart';
import '../../../core/domain/entities/entities.dart';

/// Real API implementation of [CentersRepository]
class ApiCentersRepository implements CentersRepository {
  final CentersApiService _apiService;

  ApiCentersRepository({CentersApiService? apiService})
      : _apiService = apiService ?? CentersApiService();

  @override
  Future<List<CampingCenter>> getCenters({
    String? search,
    List<String>? tags,
    bool? isInteresting,
  }) async {
    final data = await _apiService.getCenters();
    var centers = data.map((json) => _transformCenter(json)).toList();

    // Apply local filtering
    if (search != null && search.isNotEmpty) {
      centers = centers
          .where((c) =>
              c.name.toLowerCase().contains(search.toLowerCase()) ||
              c.description.toLowerCase().contains(search.toLowerCase()) ||
              c.location.toLowerCase().contains(search.toLowerCase()))
          .toList();
    }

    return centers;
  }

  @override
  Future<CampingCenter> getCenter(String id) async {
    final data = await _apiService.getCenter(id);
    return _transformCenter(data);
  }

  @override
  Future<CampingCenter> createCenter(CampingCenter center) async {
    throw UnimplementedError('Create center not yet implemented');
  }

  @override
  Future<CampingCenter> updateCenter(String id, CampingCenter center) async {
    throw UnimplementedError('Update center not yet implemented');
  }

  @override
  Future<void> deleteCenter(String id) async {
    throw UnimplementedError('Delete center not yet implemented');
  }

  @override
  Future<List<Review>> getCenterReviews(String centerId) async {
    final data = await _apiService.getCenterReviews(centerId);
    return data.map((json) => _transformReview(json)).toList();
  }

  @override
  Future<Review> createReview(Review review) async {
    final data = await _apiService.createReview(
      review.centerId,
      review.rating,
      review.comment ?? '',
    );
    return _transformReview(data);
  }

  @override
  Future<Review> updateReview(String id, Review review) async {
    throw UnimplementedError('Update review not yet implemented');
  }

  @override
  Future<void> deleteReview(String id) async {
    throw UnimplementedError('Delete review not yet implemented');
  }

  @override
  Future<List<CampingCenter>> getOwnedCenters() async {
    final data = await _apiService.getOwnedCenters();
    return data.map((json) => _transformCenter(json)).toList();
  }

  /// Transform backend center data to Flutter format
  CampingCenter _transformCenter(Map<String, dynamic> json) {
    final images = json['images'] as List<dynamic>? ?? [];
    final priceStr = json['price'] as String? ?? '0';

    // Parse price from string like "45 TND/nuit"
    double priceValue = 0;
    try {
      final priceMatch = RegExp(r'(\d+)').firstMatch(priceStr);
      if (priceMatch != null) {
        priceValue = double.parse(priceMatch.group(1)!);
      }
    } catch (_) {}

    return CampingCenter(
      id: json['id'].toString(),
      ownerId: json['ownerId']?.toString() ?? '',
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      location: json['location'] as String? ?? '',
      photos: images.map((e) => e.toString()).toList(),
      priceMin: priceValue,
      priceMax: priceValue,
      isInteresting: true, // Default to true for display
    );
  }

  /// Transform backend review data to Flutter format
  Review _transformReview(Map<String, dynamic> json) {
    final userJson = json['user'] as Map<String, dynamic>?;

    return Review(
      id: json['id'].toString(),
      centerId: json['centerId'].toString(),
      userId: json['userId'].toString(),
      userName: userJson != null
          ? '${userJson['firstName'] ?? ''} ${userJson['lastName'] ?? ''}'
              .trim()
          : 'Anonymous',
      rating: json['rating'] as int? ?? 0,
      comment: json['comment'] as String?,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
    );
  }
}
