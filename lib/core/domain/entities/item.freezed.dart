// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MarketplaceItem _$MarketplaceItemFromJson(Map<String, dynamic> json) {
  return _MarketplaceItem.fromJson(json);
}

/// @nodoc
mixin _$MarketplaceItem {
  /// Unique identifier for the item
  String get id => throw _privateConstructorUsedError;

  /// ID of the center this item belongs to
  String get centerId => throw _privateConstructorUsedError;

  /// Name of the item
  String get name => throw _privateConstructorUsedError;

  /// Detailed description
  String get description => throw _privateConstructorUsedError;

  /// URL to item image
  String? get imageUrl => throw _privateConstructorUsedError;

  /// Category of the item
  ItemCategory get category => throw _privateConstructorUsedError;

  /// Price per day for renting
  double get rentPricePerDay => throw _privateConstructorUsedError;

  /// Price to buy outright (null if not for sale)
  double? get buyPrice => throw _privateConstructorUsedError;

  /// Available quantity for rent/sale
  int get quantity => throw _privateConstructorUsedError;

  /// Whether the item is currently available
  bool get isAvailable => throw _privateConstructorUsedError;

  /// When the item was added
  DateTime? get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MarketplaceItemCopyWith<MarketplaceItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MarketplaceItemCopyWith<$Res> {
  factory $MarketplaceItemCopyWith(
          MarketplaceItem value, $Res Function(MarketplaceItem) then) =
      _$MarketplaceItemCopyWithImpl<$Res, MarketplaceItem>;
  @useResult
  $Res call(
      {String id,
      String centerId,
      String name,
      String description,
      String? imageUrl,
      ItemCategory category,
      double rentPricePerDay,
      double? buyPrice,
      int quantity,
      bool isAvailable,
      DateTime? createdAt});
}

/// @nodoc
class _$MarketplaceItemCopyWithImpl<$Res, $Val extends MarketplaceItem>
    implements $MarketplaceItemCopyWith<$Res> {
  _$MarketplaceItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? centerId = null,
    Object? name = null,
    Object? description = null,
    Object? imageUrl = freezed,
    Object? category = null,
    Object? rentPricePerDay = null,
    Object? buyPrice = freezed,
    Object? quantity = null,
    Object? isAvailable = null,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      centerId: null == centerId
          ? _value.centerId
          : centerId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as ItemCategory,
      rentPricePerDay: null == rentPricePerDay
          ? _value.rentPricePerDay
          : rentPricePerDay // ignore: cast_nullable_to_non_nullable
              as double,
      buyPrice: freezed == buyPrice
          ? _value.buyPrice
          : buyPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      isAvailable: null == isAvailable
          ? _value.isAvailable
          : isAvailable // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MarketplaceItemImplCopyWith<$Res>
    implements $MarketplaceItemCopyWith<$Res> {
  factory _$$MarketplaceItemImplCopyWith(_$MarketplaceItemImpl value,
          $Res Function(_$MarketplaceItemImpl) then) =
      __$$MarketplaceItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String centerId,
      String name,
      String description,
      String? imageUrl,
      ItemCategory category,
      double rentPricePerDay,
      double? buyPrice,
      int quantity,
      bool isAvailable,
      DateTime? createdAt});
}

/// @nodoc
class __$$MarketplaceItemImplCopyWithImpl<$Res>
    extends _$MarketplaceItemCopyWithImpl<$Res, _$MarketplaceItemImpl>
    implements _$$MarketplaceItemImplCopyWith<$Res> {
  __$$MarketplaceItemImplCopyWithImpl(
      _$MarketplaceItemImpl _value, $Res Function(_$MarketplaceItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? centerId = null,
    Object? name = null,
    Object? description = null,
    Object? imageUrl = freezed,
    Object? category = null,
    Object? rentPricePerDay = null,
    Object? buyPrice = freezed,
    Object? quantity = null,
    Object? isAvailable = null,
    Object? createdAt = freezed,
  }) {
    return _then(_$MarketplaceItemImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      centerId: null == centerId
          ? _value.centerId
          : centerId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as ItemCategory,
      rentPricePerDay: null == rentPricePerDay
          ? _value.rentPricePerDay
          : rentPricePerDay // ignore: cast_nullable_to_non_nullable
              as double,
      buyPrice: freezed == buyPrice
          ? _value.buyPrice
          : buyPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      isAvailable: null == isAvailable
          ? _value.isAvailable
          : isAvailable // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MarketplaceItemImpl implements _MarketplaceItem {
  const _$MarketplaceItemImpl(
      {required this.id,
      required this.centerId,
      required this.name,
      required this.description,
      this.imageUrl,
      required this.category,
      required this.rentPricePerDay,
      this.buyPrice,
      this.quantity = 1,
      this.isAvailable = true,
      this.createdAt});

  factory _$MarketplaceItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$MarketplaceItemImplFromJson(json);

  /// Unique identifier for the item
  @override
  final String id;

  /// ID of the center this item belongs to
  @override
  final String centerId;

  /// Name of the item
  @override
  final String name;

  /// Detailed description
  @override
  final String description;

  /// URL to item image
  @override
  final String? imageUrl;

  /// Category of the item
  @override
  final ItemCategory category;

  /// Price per day for renting
  @override
  final double rentPricePerDay;

  /// Price to buy outright (null if not for sale)
  @override
  final double? buyPrice;

  /// Available quantity for rent/sale
  @override
  @JsonKey()
  final int quantity;

  /// Whether the item is currently available
  @override
  @JsonKey()
  final bool isAvailable;

  /// When the item was added
  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'MarketplaceItem(id: $id, centerId: $centerId, name: $name, description: $description, imageUrl: $imageUrl, category: $category, rentPricePerDay: $rentPricePerDay, buyPrice: $buyPrice, quantity: $quantity, isAvailable: $isAvailable, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MarketplaceItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.centerId, centerId) ||
                other.centerId == centerId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.rentPricePerDay, rentPricePerDay) ||
                other.rentPricePerDay == rentPricePerDay) &&
            (identical(other.buyPrice, buyPrice) ||
                other.buyPrice == buyPrice) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.isAvailable, isAvailable) ||
                other.isAvailable == isAvailable) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      centerId,
      name,
      description,
      imageUrl,
      category,
      rentPricePerDay,
      buyPrice,
      quantity,
      isAvailable,
      createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MarketplaceItemImplCopyWith<_$MarketplaceItemImpl> get copyWith =>
      __$$MarketplaceItemImplCopyWithImpl<_$MarketplaceItemImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MarketplaceItemImplToJson(
      this,
    );
  }
}

abstract class _MarketplaceItem implements MarketplaceItem {
  const factory _MarketplaceItem(
      {required final String id,
      required final String centerId,
      required final String name,
      required final String description,
      final String? imageUrl,
      required final ItemCategory category,
      required final double rentPricePerDay,
      final double? buyPrice,
      final int quantity,
      final bool isAvailable,
      final DateTime? createdAt}) = _$MarketplaceItemImpl;

  factory _MarketplaceItem.fromJson(Map<String, dynamic> json) =
      _$MarketplaceItemImpl.fromJson;

  @override

  /// Unique identifier for the item
  String get id;
  @override

  /// ID of the center this item belongs to
  String get centerId;
  @override

  /// Name of the item
  String get name;
  @override

  /// Detailed description
  String get description;
  @override

  /// URL to item image
  String? get imageUrl;
  @override

  /// Category of the item
  ItemCategory get category;
  @override

  /// Price per day for renting
  double get rentPricePerDay;
  @override

  /// Price to buy outright (null if not for sale)
  double? get buyPrice;
  @override

  /// Available quantity for rent/sale
  int get quantity;
  @override

  /// Whether the item is currently available
  bool get isAvailable;
  @override

  /// When the item was added
  DateTime? get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$MarketplaceItemImplCopyWith<_$MarketplaceItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CartItem _$CartItemFromJson(Map<String, dynamic> json) {
  return _CartItem.fromJson(json);
}

/// @nodoc
mixin _$CartItem {
  /// The marketplace item
  MarketplaceItem get item => throw _privateConstructorUsedError;

  /// Quantity in cart
  int get quantity => throw _privateConstructorUsedError;

  /// Whether renting (true) or buying (false)
  bool get isRenting => throw _privateConstructorUsedError;

  /// Number of rental days (only used if isRenting is true)
  int get rentalDays => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CartItemCopyWith<CartItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CartItemCopyWith<$Res> {
  factory $CartItemCopyWith(CartItem value, $Res Function(CartItem) then) =
      _$CartItemCopyWithImpl<$Res, CartItem>;
  @useResult
  $Res call(
      {MarketplaceItem item, int quantity, bool isRenting, int rentalDays});

  $MarketplaceItemCopyWith<$Res> get item;
}

/// @nodoc
class _$CartItemCopyWithImpl<$Res, $Val extends CartItem>
    implements $CartItemCopyWith<$Res> {
  _$CartItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? item = null,
    Object? quantity = null,
    Object? isRenting = null,
    Object? rentalDays = null,
  }) {
    return _then(_value.copyWith(
      item: null == item
          ? _value.item
          : item // ignore: cast_nullable_to_non_nullable
              as MarketplaceItem,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      isRenting: null == isRenting
          ? _value.isRenting
          : isRenting // ignore: cast_nullable_to_non_nullable
              as bool,
      rentalDays: null == rentalDays
          ? _value.rentalDays
          : rentalDays // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $MarketplaceItemCopyWith<$Res> get item {
    return $MarketplaceItemCopyWith<$Res>(_value.item, (value) {
      return _then(_value.copyWith(item: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CartItemImplCopyWith<$Res>
    implements $CartItemCopyWith<$Res> {
  factory _$$CartItemImplCopyWith(
          _$CartItemImpl value, $Res Function(_$CartItemImpl) then) =
      __$$CartItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {MarketplaceItem item, int quantity, bool isRenting, int rentalDays});

  @override
  $MarketplaceItemCopyWith<$Res> get item;
}

/// @nodoc
class __$$CartItemImplCopyWithImpl<$Res>
    extends _$CartItemCopyWithImpl<$Res, _$CartItemImpl>
    implements _$$CartItemImplCopyWith<$Res> {
  __$$CartItemImplCopyWithImpl(
      _$CartItemImpl _value, $Res Function(_$CartItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? item = null,
    Object? quantity = null,
    Object? isRenting = null,
    Object? rentalDays = null,
  }) {
    return _then(_$CartItemImpl(
      item: null == item
          ? _value.item
          : item // ignore: cast_nullable_to_non_nullable
              as MarketplaceItem,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      isRenting: null == isRenting
          ? _value.isRenting
          : isRenting // ignore: cast_nullable_to_non_nullable
              as bool,
      rentalDays: null == rentalDays
          ? _value.rentalDays
          : rentalDays // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CartItemImpl implements _CartItem {
  const _$CartItemImpl(
      {required this.item,
      this.quantity = 1,
      this.isRenting = true,
      this.rentalDays = 1});

  factory _$CartItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$CartItemImplFromJson(json);

  /// The marketplace item
  @override
  final MarketplaceItem item;

  /// Quantity in cart
  @override
  @JsonKey()
  final int quantity;

  /// Whether renting (true) or buying (false)
  @override
  @JsonKey()
  final bool isRenting;

  /// Number of rental days (only used if isRenting is true)
  @override
  @JsonKey()
  final int rentalDays;

  @override
  String toString() {
    return 'CartItem(item: $item, quantity: $quantity, isRenting: $isRenting, rentalDays: $rentalDays)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CartItemImpl &&
            (identical(other.item, item) || other.item == item) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.isRenting, isRenting) ||
                other.isRenting == isRenting) &&
            (identical(other.rentalDays, rentalDays) ||
                other.rentalDays == rentalDays));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, item, quantity, isRenting, rentalDays);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CartItemImplCopyWith<_$CartItemImpl> get copyWith =>
      __$$CartItemImplCopyWithImpl<_$CartItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CartItemImplToJson(
      this,
    );
  }
}

abstract class _CartItem implements CartItem {
  const factory _CartItem(
      {required final MarketplaceItem item,
      final int quantity,
      final bool isRenting,
      final int rentalDays}) = _$CartItemImpl;

  factory _CartItem.fromJson(Map<String, dynamic> json) =
      _$CartItemImpl.fromJson;

  @override

  /// The marketplace item
  MarketplaceItem get item;
  @override

  /// Quantity in cart
  int get quantity;
  @override

  /// Whether renting (true) or buying (false)
  bool get isRenting;
  @override

  /// Number of rental days (only used if isRenting is true)
  int get rentalDays;
  @override
  @JsonKey(ignore: true)
  _$$CartItemImplCopyWith<_$CartItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
