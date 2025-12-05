import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/domain/entities/entities.dart';
import '../../data/mock_marketplace_repository.dart';
import '../../domain/marketplace_repository.dart';

/// Provider for the marketplace repository.
final marketplaceRepositoryProvider = Provider<MarketplaceRepository>((ref) {
  return MockMarketplaceRepository();
});

/// Provider for all marketplace items.
final allItemsProvider = FutureProvider<List<MarketplaceItem>>((ref) async {
  final repository = ref.watch(marketplaceRepositoryProvider);
  return repository.getItems();
});

/// Provider for items filtered by category.
final itemsByCategoryProvider =
    FutureProvider.family<List<MarketplaceItem>, ItemCategory?>((
      ref,
      category,
    ) async {
      final repository = ref.watch(marketplaceRepositoryProvider);
      return repository.getItems(category: category);
    });

/// Provider for items of a specific center.
final itemsByCenterProvider =
    FutureProvider.family<List<MarketplaceItem>, String>((ref, centerId) async {
      final repository = ref.watch(marketplaceRepositoryProvider);
      return repository.getItems(centerId: centerId);
    });

/// Provider for a single item by ID.
final itemByIdProvider = FutureProvider.family<MarketplaceItem, String>((
  ref,
  id,
) async {
  final repository = ref.watch(marketplaceRepositoryProvider);
  return repository.getItem(id);
});

/// State provider for selected category filter.
final selectedCategoryProvider = StateProvider<ItemCategory?>((ref) => null);

/// Provider for the cart items.
final cartProvider =
    StateNotifierProvider<CartNotifier, AsyncValue<List<CartItem>>>((ref) {
      final repository = ref.watch(marketplaceRepositoryProvider);
      return CartNotifier(repository);
    });

/// Provider for cart item count.
final cartItemCountProvider = Provider<int>((ref) {
  return ref
      .watch(cartProvider)
      .maybeWhen(
        data: (items) => items.fold(0, (sum, item) => sum + item.quantity),
        orElse: () => 0,
      );
});

/// Provider for cart total.
final cartTotalProvider = Provider<double>((ref) {
  return ref
      .watch(cartProvider)
      .maybeWhen(
        data: (items) => items.fold(0.0, (sum, item) => sum + item.totalPrice),
        orElse: () => 0.0,
      );
});

/// Notifier for managing cart state.
class CartNotifier extends StateNotifier<AsyncValue<List<CartItem>>> {
  final MarketplaceRepository _repository;

  CartNotifier(this._repository) : super(const AsyncValue.loading()) {
    _loadCart();
  }

  Future<void> _loadCart() async {
    state = const AsyncValue.loading();
    try {
      final cart = await _repository.getCart();
      state = AsyncValue.data(cart);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> addToCart(
    MarketplaceItem item, {
    int quantity = 1,
    bool isRenting = true,
    int rentalDays = 1,
  }) async {
    try {
      final cartItem = CartItem(
        item: item,
        quantity: quantity,
        isRenting: isRenting,
        rentalDays: rentalDays,
      );
      final updatedCart = await _repository.addToCart(cartItem);
      state = AsyncValue.data(updatedCart);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateItem(
    String itemId, {
    int? quantity,
    bool? isRenting,
    int? rentalDays,
  }) async {
    try {
      final currentCart = state.valueOrNull ?? [];
      final index = currentCart.indexWhere((c) => c.item.id == itemId);
      if (index < 0) return;

      final current = currentCart[index];
      final updated = current.copyWith(
        quantity: quantity ?? current.quantity,
        isRenting: isRenting ?? current.isRenting,
        rentalDays: rentalDays ?? current.rentalDays,
      );

      final updatedCart = await _repository.updateCartItem(itemId, updated);
      state = AsyncValue.data(updatedCart);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> removeItem(String itemId) async {
    try {
      final updatedCart = await _repository.removeFromCart(itemId);
      state = AsyncValue.data(updatedCart);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> clearCart() async {
    try {
      await _repository.clearCart();
      state = const AsyncValue.data([]);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<Order?> checkout({String? reservationId}) async {
    try {
      final order = await _repository.checkout(reservationId: reservationId);
      state = const AsyncValue.data([]);
      return order;
    } catch (e) {
      return null;
    }
  }
}
