import 'package:freezed_annotation/freezed_annotation.dart';

part 'item.freezed.dart';
part 'item.g.dart';

/// Category of marketplace items.
enum ItemCategory {
  @JsonValue('tent')
  tent,
  @JsonValue('sleeping')
  sleeping,
  @JsonValue('cooking')
  cooking,
  @JsonValue('lighting')
  lighting,
  @JsonValue('furniture')
  furniture,
  @JsonValue('accessories')
  accessories,
}

/// Extension to get display names for item categories.
extension ItemCategoryExtension on ItemCategory {
  String get displayName {
    switch (this) {
      case ItemCategory.tent:
        return 'Tents';
      case ItemCategory.sleeping:
        return 'Sleeping Gear';
      case ItemCategory.cooking:
        return 'Cooking Equipment';
      case ItemCategory.lighting:
        return 'Lighting';
      case ItemCategory.furniture:
        return 'Camp Furniture';
      case ItemCategory.accessories:
        return 'Accessories';
    }
  }

  String get icon {
    switch (this) {
      case ItemCategory.tent:
        return '⛺';
      case ItemCategory.sleeping:
        return '🛏️';
      case ItemCategory.cooking:
        return '🍳';
      case ItemCategory.lighting:
        return '🔦';
      case ItemCategory.furniture:
        return '🪑';
      case ItemCategory.accessories:
        return '🎒';
    }
  }
}

/// MarketplaceItem entity representing a rentable/buyable item.
///
/// Items belong to a specific camping center and can be:
/// - Rented for a specific duration during a reservation
/// - Purchased outright by campers
@freezed
class MarketplaceItem with _$MarketplaceItem {
  const factory MarketplaceItem({
    /// Unique identifier for the item
    required String id,

    /// ID of the center this item belongs to
    required String centerId,

    /// Name of the item
    required String name,

    /// Detailed description
    required String description,

    /// URL to item image
    String? imageUrl,

    /// Category of the item
    required ItemCategory category,

    /// Price per day for renting
    required double rentPricePerDay,

    /// Price to buy outright (null if not for sale)
    double? buyPrice,

    /// Available quantity for rent/sale
    @Default(1) int quantity,

    /// Whether the item is currently available
    @Default(true) bool isAvailable,

    /// When the item was added
    DateTime? createdAt,
  }) = _MarketplaceItem;

  factory MarketplaceItem.fromJson(Map<String, dynamic> json) =>
      _$MarketplaceItemFromJson(json);
}

/// Cart item representing an item added to shopping cart.
@freezed
class CartItem with _$CartItem {
  const factory CartItem({
    /// The marketplace item
    required MarketplaceItem item,

    /// Quantity in cart
    @Default(1) int quantity,

    /// Whether renting (true) or buying (false)
    @Default(true) bool isRenting,

    /// Number of rental days (only used if isRenting is true)
    @Default(1) int rentalDays,
  }) = _CartItem;

  factory CartItem.fromJson(Map<String, dynamic> json) =>
      _$CartItemFromJson(json);
}

/// Extension for calculating cart item totals.
extension CartItemExtension on CartItem {
  double get totalPrice {
    if (isRenting) {
      return item.rentPricePerDay * rentalDays * quantity;
    } else {
      return (item.buyPrice ?? 0) * quantity;
    }
  }
}
