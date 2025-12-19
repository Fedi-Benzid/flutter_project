import 'package:dio/dio.dart';
import '../../../core/config/app_config.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/api_exception.dart';

/// API service for marketplace operations
class MarketplaceApiService {
  final Dio _dio = ApiClient().dio;

  Future<List<Map<String, dynamic>>> getItems(
      {String? centerId, String? category}) async {
    try {
      final queryParams = <String, dynamic>{};
      if (centerId != null) queryParams['centerId'] = centerId;
      if (category != null) queryParams['category'] = category;

      final response = await _dio.get(
        '${AppConfig.marketplacePath}/items',
        queryParameters: queryParams.isNotEmpty ? queryParams : null,
      );
      final apiResponse = response.data as Map<String, dynamic>;

      if (apiResponse['success'] == true && apiResponse['data'] != null) {
        return List<Map<String, dynamic>>.from(apiResponse['data']);
      }
      return [];
    } on DioException catch (e) {
      if (e.error is ApiException) rethrow;
      throw ApiException('Failed to get items: ${e.message}');
    }
  }

  Future<Map<String, dynamic>> getItem(String id) async {
    try {
      final response = await _dio.get('${AppConfig.marketplacePath}/items/$id');
      final apiResponse = response.data as Map<String, dynamic>;

      if (apiResponse['success'] == true && apiResponse['data'] != null) {
        return apiResponse['data'] as Map<String, dynamic>;
      }
      throw ApiException('Item not found');
    } on DioException catch (e) {
      if (e.error is ApiException) rethrow;
      throw ApiException('Failed to get item: ${e.message}');
    }
  }

  Future<List<Map<String, dynamic>>> getCart() async {
    try {
      final response = await _dio.get('${AppConfig.marketplacePath}/cart');
      final apiResponse = response.data as Map<String, dynamic>;

      if (apiResponse['success'] == true && apiResponse['data'] != null) {
        return List<Map<String, dynamic>>.from(apiResponse['data']);
      }
      return [];
    } on DioException catch (e) {
      if (e.error is ApiException) rethrow;
      throw ApiException('Failed to get cart: ${e.message}');
    }
  }

  Future<void> addToCart(String itemId, int quantity) async {
    try {
      await _dio.post(
        '${AppConfig.marketplacePath}/cart',
        data: {'itemId': int.parse(itemId), 'quantity': quantity},
      );
    } on DioException catch (e) {
      if (e.error is ApiException) rethrow;
      throw ApiException('Failed to add to cart: ${e.message}');
    }
  }

  Future<void> updateCartItem(String itemId, int quantity) async {
    try {
      await _dio.put(
        '${AppConfig.marketplacePath}/cart/$itemId',
        data: {'quantity': quantity},
      );
    } on DioException catch (e) {
      if (e.error is ApiException) rethrow;
      throw ApiException('Failed to update cart: ${e.message}');
    }
  }

  Future<void> removeFromCart(String itemId) async {
    try {
      await _dio.delete('${AppConfig.marketplacePath}/cart/$itemId');
    } on DioException catch (e) {
      if (e.error is ApiException) rethrow;
      throw ApiException('Failed to remove from cart: ${e.message}');
    }
  }

  Future<void> clearCart() async {
    try {
      await _dio.delete('${AppConfig.marketplacePath}/cart');
    } on DioException catch (e) {
      if (e.error is ApiException) rethrow;
      throw ApiException('Failed to clear cart: ${e.message}');
    }
  }

  Future<Map<String, dynamic>> checkout({String? reservationId}) async {
    try {
      final response = await _dio.post(
        '${AppConfig.marketplacePath}/checkout',
        data: reservationId != null
            ? {'reservationId': int.parse(reservationId)}
            : null,
      );
      final apiResponse = response.data as Map<String, dynamic>;

      if (apiResponse['success'] == true && apiResponse['data'] != null) {
        return apiResponse['data'] as Map<String, dynamic>;
      }
      throw ApiException('Checkout failed');
    } on DioException catch (e) {
      if (e.error is ApiException) rethrow;
      throw ApiException('Checkout failed: ${e.message}');
    }
  }

  Future<List<Map<String, dynamic>>> getOrders() async {
    try {
      final response = await _dio.get('${AppConfig.marketplacePath}/orders');
      final apiResponse = response.data as Map<String, dynamic>;

      if (apiResponse['success'] == true && apiResponse['data'] != null) {
        return List<Map<String, dynamic>>.from(apiResponse['data']);
      }
      return [];
    } on DioException catch (e) {
      if (e.error is ApiException) rethrow;
      throw ApiException('Failed to get orders: ${e.message}');
    }
  }
}
