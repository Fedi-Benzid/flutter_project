// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MarketplaceItemImpl _$$MarketplaceItemImplFromJson(
        Map<String, dynamic> json) =>
    _$MarketplaceItemImpl(
      id: json['id'] as String,
      centerId: json['centerId'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String?,
      category: $enumDecode(_$ItemCategoryEnumMap, json['category']),
      rentPricePerDay: (json['rentPricePerDay'] as num).toDouble(),
      buyPrice: (json['buyPrice'] as num?)?.toDouble(),
      quantity: (json['quantity'] as num?)?.toInt() ?? 1,
      isAvailable: json['isAvailable'] as bool? ?? true,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$MarketplaceItemImplToJson(
        _$MarketplaceItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'centerId': instance.centerId,
      'name': instance.name,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'category': _$ItemCategoryEnumMap[instance.category]!,
      'rentPricePerDay': instance.rentPricePerDay,
      'buyPrice': instance.buyPrice,
      'quantity': instance.quantity,
      'isAvailable': instance.isAvailable,
      'createdAt': instance.createdAt?.toIso8601String(),
    };

const _$ItemCategoryEnumMap = {
  ItemCategory.tent: 'tent',
  ItemCategory.sleeping: 'sleeping',
  ItemCategory.cooking: 'cooking',
  ItemCategory.lighting: 'lighting',
  ItemCategory.furniture: 'furniture',
  ItemCategory.accessories: 'accessories',
};

_$CartItemImpl _$$CartItemImplFromJson(Map<String, dynamic> json) =>
    _$CartItemImpl(
      item: MarketplaceItem.fromJson(json['item'] as Map<String, dynamic>),
      quantity: (json['quantity'] as num?)?.toInt() ?? 1,
      isRenting: json['isRenting'] as bool? ?? true,
      rentalDays: (json['rentalDays'] as num?)?.toInt() ?? 1,
    );

Map<String, dynamic> _$$CartItemImplToJson(_$CartItemImpl instance) =>
    <String, dynamic>{
      'item': instance.item,
      'quantity': instance.quantity,
      'isRenting': instance.isRenting,
      'rentalDays': instance.rentalDays,
    };
