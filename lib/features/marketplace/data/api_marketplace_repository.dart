import 'marketplace_api_service.dart';
import '../domain/marketplace_repository.dart';
import '../../../core/domain/entities/entities.dart';

/// Real API implementation of [MarketplaceRepository]
class ApiMarketplaceRepository implements MarketplaceRepository {
  final MarketplaceApiService _apiService;

  ApiMarketplaceRepository({MarketplaceApiService? apiService})
      : _apiService = apiService ?? MarketplaceApiService();

  @override
  Future<List<MarketplaceItem>> getItems({
    String? centerId,
    ItemCategory? category,
  }) async {
    final categoryStr = category != null ? _categoryToBackend(category) : null;
    final data =
        await _apiService.getItems(centerId: centerId, category: categoryStr);
    return data.map((json) => _transformItem(json)).toList();
  }

  @override
  Future<MarketplaceItem> getItem(String id) async {
    final data = await _apiService.getItem(id);
    return _transformItem(data);
  }

  @override
  Future<List<CartItem>> getCart() async {
    final data = await _apiService.getCart();
    return data.map((json) => _transformCartItem(json)).toList();
  }

  @override
  Future<List<CartItem>> addToCart(CartItem cartItem) async {
    await _apiService.addToCart(cartItem.item.id, cartItem.quantity);
    return getCart();
  }

  @override
  Future<List<CartItem>> updateCartItem(
      String itemId, CartItem cartItem) async {
    await _apiService.updateCartItem(itemId, cartItem.quantity);
    return getCart();
  }

  @override
  Future<List<CartItem>> removeFromCart(String itemId) async {
    await _apiService.removeFromCart(itemId);
    return getCart();
  }

  @override
  Future<void> clearCart() async {
    await _apiService.clearCart();
  }

  @override
  Future<Order> checkout({String? reservationId}) async {
    final data = await _apiService.checkout(reservationId: reservationId);
    return _transformOrder(data);
  }

  String _categoryToBackend(ItemCategory category) {
    switch (category) {
      case ItemCategory.tent:
      case ItemCategory.sleeping:
      case ItemCategory.lighting:
        return 'CAMPING_GEAR';
      case ItemCategory.cooking:
        return 'FOOD_BEVERAGES';
      case ItemCategory.furniture:
        return 'OUTDOOR_EQUIPMENT';
      case ItemCategory.accessories:
        return 'ACCESSORIES';
    }
  }

  ItemCategory _backendToCategory(String? category) {
    switch (category) {
      case 'CAMPING_GEAR':
        return ItemCategory.tent;
      case 'FOOD_BEVERAGES':
        return ItemCategory.cooking;
      case 'OUTDOOR_EQUIPMENT':
        return ItemCategory.furniture;
      case 'ACCESSORIES':
        return ItemCategory.accessories;
      default:
        return ItemCategory.accessories;
    }
  }

  MarketplaceItem _transformItem(Map<String, dynamic> json) {
    final imageUrls = json['imageUrls'] as List<dynamic>? ?? [];

    return MarketplaceItem(
      id: json['id'].toString(),
      centerId: json['centerId']?.toString() ?? '',
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      imageUrl: imageUrls.isNotEmpty ? imageUrls.first.toString() : null,
      category: _backendToCategory(json['category'] as String?),
      rentPricePerDay: (json['price'] as num?)?.toDouble() ?? 0,
      buyPrice: (json['price'] as num?)?.toDouble(),
      quantity: json['stock'] as int? ?? 1,
      isAvailable: (json['stock'] as int? ?? 0) > 0,
    );
  }

  CartItem _transformCartItem(Map<String, dynamic> json) {
    final itemJson = json['item'] as Map<String, dynamic>? ?? json;
    return CartItem(
      item: _transformItem(itemJson),
      quantity: json['quantity'] as int? ?? 1,
    );
  }

  Order _transformOrder(Map<String, dynamic> json) {
    final itemsJson = json['items'] as List<dynamic>? ?? [];
    final totalAmount = (json['totalAmount'] as num?)?.toDouble() ?? 0;

    return Order(
      id: json['id'].toString(),
      userId: json['userId'].toString(),
      items: itemsJson.map((item) {
        final itemMap = item as Map<String, dynamic>;
        final price = (itemMap['price'] as num?)?.toDouble() ?? 0;
        final qty = itemMap['quantity'] as int? ?? 1;
        return OrderItem(
          itemId: itemMap['itemId'].toString(),
          name: itemMap['itemName'] as String? ?? '',
          quantity: qty,
          unitPrice: price,
          totalPrice: price * qty,
        );
      }).toList(),
      subtotal: totalAmount,
      totalAmount: totalAmount,
      paymentStatus: _parsePaymentStatus(json['status'] as String?),
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      reservationId: json['reservationId']?.toString(),
    );
  }

  PaymentStatus _parsePaymentStatus(String? status) {
    switch (status) {
      case 'PROCESSING':
        return PaymentStatus.processing;
      case 'COMPLETED':
        return PaymentStatus.completed;
      case 'CANCELLED':
        return PaymentStatus.failed;
      default:
        return PaymentStatus.pending;
    }
  }
}
