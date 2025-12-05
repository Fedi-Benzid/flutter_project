import '../../../core/domain/entities/entities.dart';
import '../../../mock/mock_server.dart';
import '../domain/marketplace_repository.dart';

/// Mock implementation of [MarketplaceRepository].
class MockMarketplaceRepository implements MarketplaceRepository {
  final MockServer _mockServer;

  MockMarketplaceRepository({MockServer? mockServer})
    : _mockServer = mockServer ?? MockServer.instance;

  @override
  Future<List<MarketplaceItem>> getItems({
    String? centerId,
    ItemCategory? category,
  }) async {
    return _mockServer.getItems(centerId: centerId, category: category);
  }

  @override
  Future<MarketplaceItem> getItem(String id) async {
    return _mockServer.getItem(id);
  }

  @override
  Future<List<CartItem>> getCart() async {
    return _mockServer.getCart();
  }

  @override
  Future<List<CartItem>> addToCart(CartItem cartItem) async {
    return _mockServer.addToCart(cartItem);
  }

  @override
  Future<List<CartItem>> updateCartItem(
    String itemId,
    CartItem cartItem,
  ) async {
    return _mockServer.updateCartItem(itemId, cartItem);
  }

  @override
  Future<List<CartItem>> removeFromCart(String itemId) async {
    return _mockServer.removeFromCart(itemId);
  }

  @override
  Future<void> clearCart() async {
    await _mockServer.clearCart();
  }

  @override
  Future<Order> checkout({String? reservationId}) async {
    return _mockServer.checkout(reservationId: reservationId);
  }
}
