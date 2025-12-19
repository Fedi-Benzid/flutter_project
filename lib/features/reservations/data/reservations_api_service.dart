import 'package:dio/dio.dart';
import '../../../core/config/app_config.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/api_exception.dart';

/// API service for reservation operations
class ReservationsApiService {
  final Dio _dio = ApiClient().dio;

  Future<List<Map<String, dynamic>>> getUserReservations() async {
    try {
      final response = await _dio.get(AppConfig.reservationsPath);
      final apiResponse = response.data as Map<String, dynamic>;

      if (apiResponse['success'] == true && apiResponse['data'] != null) {
        return List<Map<String, dynamic>>.from(apiResponse['data']);
      }
      return [];
    } on DioException catch (e) {
      if (e.error is ApiException) rethrow;
      throw ApiException('Failed to get reservations: ${e.message}');
    }
  }

  Future<Map<String, dynamic>> getReservation(String id) async {
    try {
      final response = await _dio.get('${AppConfig.reservationsPath}/$id');
      final apiResponse = response.data as Map<String, dynamic>;

      if (apiResponse['success'] == true && apiResponse['data'] != null) {
        return apiResponse['data'] as Map<String, dynamic>;
      }
      throw ApiException('Reservation not found');
    } on DioException catch (e) {
      if (e.error is ApiException) rethrow;
      throw ApiException('Failed to get reservation: ${e.message}');
    }
  }

  Future<Map<String, dynamic>> createReservation({
    required String centerId,
    required DateTime checkInDate,
    required DateTime checkOutDate,
    required int guests,
  }) async {
    try {
      final response = await _dio.post(
        AppConfig.reservationsPath,
        data: {
          'centerId': int.parse(centerId),
          'checkInDate': checkInDate.toIso8601String().split('T').first,
          'checkOutDate': checkOutDate.toIso8601String().split('T').first,
          'guests': guests,
        },
      );
      final apiResponse = response.data as Map<String, dynamic>;

      if (apiResponse['success'] == true && apiResponse['data'] != null) {
        return apiResponse['data'] as Map<String, dynamic>;
      }
      throw ApiException(
          apiResponse['message'] ?? 'Failed to create reservation');
    } on DioException catch (e) {
      if (e.error is ApiException) rethrow;
      throw ApiException('Failed to create reservation: ${e.message}');
    }
  }

  Future<void> cancelReservation(String id) async {
    try {
      await _dio.delete('${AppConfig.reservationsPath}/$id');
    } on DioException catch (e) {
      if (e.error is ApiException) rethrow;
      throw ApiException('Failed to cancel reservation: ${e.message}');
    }
  }

  Future<List<Map<String, dynamic>>> getOwnerReservations() async {
    try {
      final response = await _dio.get('${AppConfig.reservationsPath}/owner');
      final apiResponse = response.data as Map<String, dynamic>;

      if (apiResponse['success'] == true && apiResponse['data'] != null) {
        return List<Map<String, dynamic>>.from(apiResponse['data']);
      }
      return [];
    } on DioException catch (e) {
      if (e.error is ApiException) rethrow;
      throw ApiException('Failed to get owner reservations: ${e.message}');
    }
  }
}
