import '../../../core/domain/entities/entities.dart';

/// Abstract repository interface for marketplace operations.
abstract class MarketplaceRepository {
  /// Get all items with optional filtering.
  Future<List<MarketplaceItem>> getItems({
    String? centerId,
    ItemCategory? category,
  });

  /// Get a single item by ID.
  Future<MarketplaceItem> getItem(String id);

  /// Get the current user's cart.
  Future<List<CartItem>> getCart();

  /// Add an item to cart.
  Future<List<CartItem>> addToCart(CartItem cartItem);

  /// Update a cart item.
  Future<List<CartItem>> updateCartItem(String itemId, CartItem cartItem);

  /// Remove an item from cart.
  Future<List<CartItem>> removeFromCart(String itemId);

  /// Clear the entire cart.
  Future<void> clearCart();

  /// Process checkout and create an order.
  Future<Order> checkout({String? reservationId});
}
