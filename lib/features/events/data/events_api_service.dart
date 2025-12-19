import 'package:dio/dio.dart';
import '../../../core/config/app_config.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/api_exception.dart';

/// API service for events operations
class EventsApiService {
  final Dio _dio = ApiClient().dio;

  Future<List<Map<String, dynamic>>> getEvents({String? centerId}) async {
    try {
      final queryParams = <String, dynamic>{};
      if (centerId != null) queryParams['centerId'] = centerId;

      final response = await _dio.get(
        AppConfig.eventsPath,
        queryParameters: queryParams.isNotEmpty ? queryParams : null,
      );
      final apiResponse = response.data as Map<String, dynamic>;

      if (apiResponse['success'] == true && apiResponse['data'] != null) {
        return List<Map<String, dynamic>>.from(apiResponse['data']);
      }
      return [];
    } on DioException catch (e) {
      if (e.error is ApiException) rethrow;
      throw ApiException('Failed to get events: ${e.message}');
    }
  }

  Future<Map<String, dynamic>> getEvent(String id) async {
    try {
      final response = await _dio.get('${AppConfig.eventsPath}/$id');
      final apiResponse = response.data as Map<String, dynamic>;

      if (apiResponse['success'] == true && apiResponse['data'] != null) {
        return apiResponse['data'] as Map<String, dynamic>;
      }
      throw ApiException('Event not found');
    } on DioException catch (e) {
      if (e.error is ApiException) rethrow;
      throw ApiException('Failed to get event: ${e.message}');
    }
  }

  Future<void> joinEvent(String eventId) async {
    try {
      await _dio.post('${AppConfig.eventsPath}/$eventId/participate');
    } on DioException catch (e) {
      if (e.error is ApiException) rethrow;
      throw ApiException('Failed to join event: ${e.message}');
    }
  }

  Future<void> leaveEvent(String eventId) async {
    // API doesn't have leave endpoint, would need to add
    throw UnimplementedError('Leave event not yet implemented');
  }

  Future<List<Map<String, dynamic>>> getUserParticipations() async {
    try {
      final response =
          await _dio.get('${AppConfig.eventsPath}/my-participations');
      final apiResponse = response.data as Map<String, dynamic>;

      if (apiResponse['success'] == true && apiResponse['data'] != null) {
        return List<Map<String, dynamic>>.from(apiResponse['data']);
      }
      return [];
    } on DioException catch (e) {
      if (e.error is ApiException) rethrow;
      throw ApiException('Failed to get participations: ${e.message}');
    }
  }
}
