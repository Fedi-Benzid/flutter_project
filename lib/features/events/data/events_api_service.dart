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

  Future<Map<String, dynamic>> joinEvent(String eventId, {int numberOfPersons = 1}) async {
    try {
      final response = await _dio.post(
        '${AppConfig.eventsPath}/$eventId/participate',
        data: {'numberOfPersons': numberOfPersons},
      );
      final apiResponse = response.data as Map<String, dynamic>;

      if (apiResponse['success'] == true && apiResponse['data'] != null) {
        return apiResponse['data'] as Map<String, dynamic>;
      }
      throw ApiException(apiResponse['message'] ?? 'Failed to join event');
    } on DioException catch (e) {
      if (e.error is ApiException) rethrow;
      throw ApiException('Failed to join event: ${e.message}');
    }
  }

  Future<Map<String, dynamic>> createEvent(Map<String, dynamic> eventData) async {
    try {
      final response = await _dio.post(
        AppConfig.eventsPath,
        data: eventData,
      );
      final apiResponse = response.data as Map<String, dynamic>;

      if (apiResponse['success'] == true && apiResponse['data'] != null) {
        return apiResponse['data'] as Map<String, dynamic>;
      }
      throw ApiException(apiResponse['message'] ?? 'Failed to create event');
    } on DioException catch (e) {
      if (e.error is ApiException) rethrow;
      throw ApiException('Failed to create event: ${e.message}');
    }
  }

  Future<Map<String, dynamic>> updateEvent(String id, Map<String, dynamic> eventData) async {
    try {
      final response = await _dio.put(
        '${AppConfig.eventsPath}/$id',
        data: eventData,
      );
      final apiResponse = response.data as Map<String, dynamic>;

      if (apiResponse['success'] == true && apiResponse['data'] != null) {
        return apiResponse['data'] as Map<String, dynamic>;
      }
      throw ApiException(apiResponse['message'] ?? 'Failed to update event');
    } on DioException catch (e) {
      if (e.error is ApiException) rethrow;
      throw ApiException('Failed to update event: ${e.message}');
    }
  }

  Future<Map<String, dynamic>> closeEvent(String id) async {
    try {
      final response = await _dio.put('${AppConfig.eventsPath}/$id/close');
      final apiResponse = response.data as Map<String, dynamic>;

      if (apiResponse['success'] == true && apiResponse['data'] != null) {
        return apiResponse['data'] as Map<String, dynamic>;
      }
      throw ApiException(apiResponse['message'] ?? 'Failed to close event');
    } on DioException catch (e) {
      if (e.error is ApiException) rethrow;
      throw ApiException('Failed to close event: ${e.message}');
    }
  }

  Future<void> deleteEvent(String id) async {
    try {
      final response = await _dio.delete('${AppConfig.eventsPath}/$id');
      final apiResponse = response.data as Map<String, dynamic>;

      if (apiResponse['success'] != true) {
        throw ApiException(apiResponse['message'] ?? 'Failed to delete event');
      }
    } on DioException catch (e) {
      if (e.error is ApiException) rethrow;
      throw ApiException('Failed to delete event: ${e.message}');
    }
  }

  Future<List<Map<String, dynamic>>> getEventParticipations(String eventId) async {
    try {
      final response = await _dio.get('${AppConfig.eventsPath}/$eventId/participations');
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

  Future<Map<String, dynamic>> updateParticipationStatus(
      String eventId, String participationId, String status) async {
    try {
      final response = await _dio.put(
        '${AppConfig.eventsPath}/$eventId/participations/$participationId',
        data: {'status': status},
      );
      final apiResponse = response.data as Map<String, dynamic>;

      if (apiResponse['success'] == true && apiResponse['data'] != null) {
        return apiResponse['data'] as Map<String, dynamic>;
      }
      throw ApiException(apiResponse['message'] ?? 'Failed to update status');
    } on DioException catch (e) {
      if (e.error is ApiException) rethrow;
      throw ApiException('Failed to update participation status: ${e.message}');
    }
  }

  Future<Map<String, dynamic>> updateMyParticipation(
      String eventId, String participationId, int numberOfPersons) async {
    try {
      final response = await _dio.put(
        '${AppConfig.eventsPath}/$eventId/participations/$participationId/update',
        data: {'numberOfPersons': numberOfPersons},
      );
      final apiResponse = response.data as Map<String, dynamic>;

      if (apiResponse['success'] == true && apiResponse['data'] != null) {
        return apiResponse['data'] as Map<String, dynamic>;
      }
      throw ApiException(apiResponse['message'] ?? 'Failed to update participation');
    } on DioException catch (e) {
      if (e.error is ApiException) rethrow;
      throw ApiException('Failed to update participation: ${e.message}');
    }
  }

  Future<void> cancelParticipation(String eventId, String participationId) async {
    try {
      final response = await _dio.delete(
        '${AppConfig.eventsPath}/$eventId/participations/$participationId',
      );
      final apiResponse = response.data as Map<String, dynamic>;

      if (apiResponse['success'] != true) {
        throw ApiException(apiResponse['message'] ?? 'Failed to cancel participation');
      }
    } on DioException catch (e) {
      if (e.error is ApiException) rethrow;
      throw ApiException('Failed to cancel participation: ${e.message}');
    }
  }

  Future<List<Map<String, dynamic>>> getUserParticipations() async {
    try {
      final response = await _dio.get('${AppConfig.eventsPath}/my-participations');
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

  // Rating methods
  Future<Map<String, dynamic>> rateEvent(String eventId, int rating, String? comment) async {
    try {
      final response = await _dio.post(
        '${AppConfig.eventsPath}/$eventId/rate',
        data: {
          'rating': rating,
          if (comment != null) 'comment': comment,
        },
      );
      final apiResponse = response.data as Map<String, dynamic>;

      if (apiResponse['success'] == true && apiResponse['data'] != null) {
        return apiResponse['data'] as Map<String, dynamic>;
      }
      throw ApiException(apiResponse['message'] ?? 'Failed to rate event');
    } on DioException catch (e) {
      if (e.error is ApiException) rethrow;
      throw ApiException('Failed to rate event: ${e.message}');
    }
  }

  Future<List<Map<String, dynamic>>> getEventRatings(String eventId) async {
    try {
      final response = await _dio.get('${AppConfig.eventsPath}/$eventId/ratings');
      final apiResponse = response.data as Map<String, dynamic>;

      if (apiResponse['success'] == true && apiResponse['data'] != null) {
        return List<Map<String, dynamic>>.from(apiResponse['data']);
      }
      return [];
    } on DioException catch (e) {
      if (e.error is ApiException) rethrow;
      throw ApiException('Failed to get ratings: ${e.message}');
    }
  }

  Future<double?> getAverageRating(String eventId) async {
    try {
      final response = await _dio.get('${AppConfig.eventsPath}/$eventId/average-rating');
      final apiResponse = response.data as Map<String, dynamic>;

      if (apiResponse['success'] == true) {
        return (apiResponse['data'] as num?)?.toDouble();
      }
      return null;
    } on DioException catch (e) {
      if (e.error is ApiException) rethrow;
      throw ApiException('Failed to get average rating: ${e.message}');
    }
  }
}
