import 'package:dio/dio.dart';
import '../../../core/config/app_config.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/api_exception.dart';

/// API service for camping center operations
class CentersApiService {
  final Dio _dio = ApiClient().dio;

  /// Get all camping centers
  Future<List<Map<String, dynamic>>> getCenters() async {
    try {
      final response = await _dio.get(AppConfig.centersPath);
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
}
