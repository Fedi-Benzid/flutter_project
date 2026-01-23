import 'package:dio/dio.dart';
import '../../../core/config/app_config.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/api_exception.dart';

/// API service for camping center operations
class CentersApiService {
  final Dio _dio = ApiClient().dio;

  /// Get all camping centers with optional filters
  Future<List<Map<String, dynamic>>> getCenters({
    String? name,
    String? location,
    double? minPrice,
    double? maxPrice,
    List<String>? tags,
  }) async {
    try {
      final queryParams = <String, dynamic>{};
      if (name != null && name.isNotEmpty) queryParams['name'] = name;
      if (location != null && location.isNotEmpty)
        queryParams['location'] = location;
      if (minPrice != null) queryParams['minPrice'] = minPrice;
      if (maxPrice != null) queryParams['maxPrice'] = maxPrice;
      if (tags != null && tags.isNotEmpty) queryParams['tags'] = tags;

      final response = await _dio.get(
        AppConfig.centersPath,
        queryParameters: queryParams.isNotEmpty ? queryParams : null,
      );
      final apiResponse = response.data as Map<String, dynamic>;

      if (apiResponse['success'] == true && apiResponse['data'] != null) {
        return List<Map<String, dynamic>>.from(apiResponse['data']);
      }

      throw ApiException(apiResponse['message'] ?? 'Failed to get centers');
    } on DioException catch (e) {
      if (e.error is ApiException) rethrow;
      throw ApiException('Failed to get centers: ${e.message}');
    }
  }

  /// Get center by ID
  Future<Map<String, dynamic>> getCenter(String id) async {
    try {
      final response = await _dio.get('${AppConfig.centersPath}/$id');
      final apiResponse = response.data as Map<String, dynamic>;

      if (apiResponse['success'] == true && apiResponse['data'] != null) {
        return apiResponse['data'] as Map<String, dynamic>;
      }

      throw ApiException(apiResponse['message'] ?? 'Center not found');
    } on DioException catch (e) {
      if (e.error is ApiException) rethrow;
      throw ApiException('Failed to get center: ${e.message}');
    }
  }

  /// Get centers owned by current user
  Future<List<Map<String, dynamic>>> getOwnedCenters() async {
    try {
      final response = await _dio.get('${AppConfig.centersPath}/owned');
      final apiResponse = response.data as Map<String, dynamic>;

      if (apiResponse['success'] == true && apiResponse['data'] != null) {
        return List<Map<String, dynamic>>.from(apiResponse['data']);
      }

      throw ApiException(
          apiResponse['message'] ?? 'Failed to get owned centers');
    } on DioException catch (e) {
      if (e.error is ApiException) rethrow;
      throw ApiException('Failed to get owned centers: ${e.message}');
    }
  }

  /// Get center reviews
  Future<List<Map<String, dynamic>>> getCenterReviews(String centerId) async {
    try {
      final response =
          await _dio.get('${AppConfig.centersPath}/$centerId/reviews');
      final apiResponse = response.data as Map<String, dynamic>;

      if (apiResponse['success'] == true && apiResponse['data'] != null) {
        return List<Map<String, dynamic>>.from(apiResponse['data']);
      }

      return [];
    } on DioException catch (e) {
      if (e.error is ApiException) rethrow;
      throw ApiException('Failed to get reviews: ${e.message}');
    }
  }

  /// Create a review
  Future<Map<String, dynamic>> createReview(
      String centerId, int rating, String comment) async {
    try {
      final response = await _dio.post(
        '${AppConfig.centersPath}/$centerId/reviews',
        data: {'rating': rating, 'comment': comment},
      );
      final apiResponse = response.data as Map<String, dynamic>;

      if (apiResponse['success'] == true && apiResponse['data'] != null) {
        return apiResponse['data'] as Map<String, dynamic>;
      }

      throw ApiException(apiResponse['message'] ?? 'Failed to create review');
    } on DioException catch (e) {
      if (e.error is ApiException) rethrow;
      throw ApiException('Failed to create review: ${e.message}');
    }
  }

  /// Update a review (only by the author)
  Future<Map<String, dynamic>> updateReview(
      String reviewId, int rating, String comment) async {
    try {
      final response = await _dio.put(
        '${AppConfig.centersPath}/reviews/$reviewId',
        data: {'rating': rating, 'comment': comment},
      );
      final apiResponse = response.data as Map<String, dynamic>;

      if (apiResponse['success'] == true && apiResponse['data'] != null) {
        return apiResponse['data'] as Map<String, dynamic>;
      }

      throw ApiException(apiResponse['message'] ?? 'Failed to update review');
    } on DioException catch (e) {
      if (e.response?.statusCode == 403) {
        throw ApiException('Only the review author can update this review');
      }
      if (e.error is ApiException) rethrow;
      throw ApiException('Failed to update review: ${e.message}');
    }
  }

  /// Delete a review (only by the author)
  Future<void> deleteReview(String reviewId) async {
    try {
      final response = await _dio.delete(
        '${AppConfig.centersPath}/reviews/$reviewId',
      );
      final apiResponse = response.data as Map<String, dynamic>;

      if (apiResponse['success'] != true) {
        throw ApiException(apiResponse['message'] ?? 'Failed to delete review');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 403) {
        throw ApiException('Only the review author can delete this review');
      }
      if (e.error is ApiException) rethrow;
      throw ApiException('Failed to delete review: ${e.message}');
    }
  }

  /// Create a new camping center
  Future<Map<String, dynamic>> createCenter(
      Map<String, dynamic> centerData) async {
    try {
      final response = await _dio.post(
        AppConfig.centersPath,
        data: centerData,
        options: Options(
          contentType: Headers.jsonContentType,
        ),
      );
      final apiResponse = response.data as Map<String, dynamic>;

      if (apiResponse['success'] == true && apiResponse['data'] != null) {
        return apiResponse['data'] as Map<String, dynamic>;
      }

      throw ApiException(apiResponse['message'] ?? 'Failed to create center');
    } on DioException catch (e) {
      if (e.error is ApiException) rethrow;
      throw ApiException('Failed to create center: ${e.message}');
    }
  }

  /// Update a camping center
  Future<Map<String, dynamic>> updateCenter(
      String id, Map<String, dynamic> centerData) async {
    try {
      final response = await _dio.put(
        '${AppConfig.centersPath}/$id',
        data: centerData,
        options: Options(
          contentType: Headers.jsonContentType,
        ),
      );
      final apiResponse = response.data as Map<String, dynamic>;

      if (apiResponse['success'] == true && apiResponse['data'] != null) {
        return apiResponse['data'] as Map<String, dynamic>;
      }

      throw ApiException(apiResponse['message'] ?? 'Failed to update center');
    } on DioException catch (e) {
      if (e.error is ApiException) rethrow;
      throw ApiException('Failed to update center: ${e.message}');
    }
  }

  /// Delete a camping center
  Future<void> deleteCenter(String id) async {
    try {
      final response = await _dio.delete('${AppConfig.centersPath}/$id');
      final apiResponse = response.data as Map<String, dynamic>;

      if (apiResponse['success'] != true) {
        throw ApiException(apiResponse['message'] ?? 'Failed to delete center');
      }
    } on DioException catch (e) {
      if (e.error is ApiException) rethrow;
      throw ApiException('Failed to delete center: ${e.message}');
    }
  }
}
