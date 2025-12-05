// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Order _$OrderFromJson(Map<String, dynamic> json) {
  return _Order.fromJson(json);
}

/// @nodoc
mixin _$Order {
  /// Unique identifier
  String get id => throw _privateConstructorUsedError;

  /// ID of the user who placed the order
  String get userId => throw _privateConstructorUsedError;

  /// Optional associated reservation ID
  String? get reservationId => throw _privateConstructorUsedError;

  /// List of items in the order
  List<OrderItem> get items => throw _privateConstructorUsedError;

  /// Subtotal before any fees
  double get subtotal => throw _privateConstructorUsedError;

  /// Service/booking fee
  double get serviceFee => throw _privateConstructorUsedError;

  /// Total amount to pay
  double get totalAmount => throw _privateConstructorUsedError;

  /// Current payment status
  PaymentStatus get paymentStatus => throw _privateConstructorUsedError;

  /// Payment method used (for display)
  String? get paymentMethod => throw _privateConstructorUsedError;

  /// Mock payment transaction ID
  String? get transactionId => throw _privateConstructorUsedError;

  /// When the order was created
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// When payment was completed
  DateTime? get paidAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OrderCopyWith<Order> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderCopyWith<$Res> {
  factory $OrderCopyWith(Order value, $Res Function(Order) then) =
      _$OrderCopyWithImpl<$Res, Order>;
  @useResult
  $Res call(
      {String id,
      String userId,
      String? reservationId,
      List<OrderItem> items,
      double subtotal,
      double serviceFee,
      double totalAmount,
      PaymentStatus paymentStatus,
      String? paymentMethod,
      String? transactionId,
      DateTime? createdAt,
      DateTime? paidAt});
}

/// @nodoc
class _$OrderCopyWithImpl<$Res, $Val extends Order>
    implements $OrderCopyWith<$Res> {
  _$OrderCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? reservationId = freezed,
    Object? items = null,
    Object? subtotal = null,
    Object? serviceFee = null,
    Object? totalAmount = null,
    Object? paymentStatus = null,
    Object? paymentMethod = freezed,
    Object? transactionId = freezed,
    Object? createdAt = freezed,
    Object? paidAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      reservationId: freezed == reservationId
          ? _value.reservationId
          : reservationId // ignore: cast_nullable_to_non_nullable
              as String?,
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<OrderItem>,
      subtotal: null == subtotal
          ? _value.subtotal
          : subtotal // ignore: cast_nullable_to_non_nullable
              as double,
      serviceFee: null == serviceFee
          ? _value.serviceFee
          : serviceFee // ignore: cast_nullable_to_non_nullable
              as double,
      totalAmount: null == totalAmount
          ? _value.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as double,
      paymentStatus: null == paymentStatus
          ? _value.paymentStatus
          : paymentStatus // ignore: cast_nullable_to_non_nullable
              as PaymentStatus,
      paymentMethod: freezed == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as String?,
      transactionId: freezed == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      paidAt: freezed == paidAt
          ? _value.paidAt
          : paidAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OrderImplCopyWith<$Res> implements $OrderCopyWith<$Res> {
  factory _$$OrderImplCopyWith(
          _$OrderImpl value, $Res Function(_$OrderImpl) then) =
      __$$OrderImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String? reservationId,
      List<OrderItem> items,
      double subtotal,
      double serviceFee,
      double totalAmount,
      PaymentStatus paymentStatus,
      String? paymentMethod,
      String? transactionId,
      DateTime? createdAt,
      DateTime? paidAt});
}

/// @nodoc
class __$$OrderImplCopyWithImpl<$Res>
    extends _$OrderCopyWithImpl<$Res, _$OrderImpl>
    implements _$$OrderImplCopyWith<$Res> {
  __$$OrderImplCopyWithImpl(
      _$OrderImpl _value, $Res Function(_$OrderImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? reservationId = freezed,
    Object? items = null,
    Object? subtotal = null,
    Object? serviceFee = null,
    Object? totalAmount = null,
    Object? paymentStatus = null,
    Object? paymentMethod = freezed,
    Object? transactionId = freezed,
    Object? createdAt = freezed,
    Object? paidAt = freezed,
  }) {
    return _then(_$OrderImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      reservationId: freezed == reservationId
          ? _value.reservationId
          : reservationId // ignore: cast_nullable_to_non_nullable
              as String?,
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<OrderItem>,
      subtotal: null == subtotal
          ? _value.subtotal
          : subtotal // ignore: cast_nullable_to_non_nullable
              as double,
      serviceFee: null == serviceFee
          ? _value.serviceFee
          : serviceFee // ignore: cast_nullable_to_non_nullable
              as double,
      totalAmount: null == totalAmount
          ? _value.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as double,
      paymentStatus: null == paymentStatus
          ? _value.paymentStatus
          : paymentStatus // ignore: cast_nullable_to_non_nullable
              as PaymentStatus,
      paymentMethod: freezed == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as String?,
      transactionId: freezed == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      paidAt: freezed == paidAt
          ? _value.paidAt
          : paidAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderImpl implements _Order {
  const _$OrderImpl(
      {required this.id,
      required this.userId,
      this.reservationId,
      final List<OrderItem> items = const [],
      required this.subtotal,
      this.serviceFee = 0,
      required this.totalAmount,
      this.paymentStatus = PaymentStatus.pending,
      this.paymentMethod,
      this.transactionId,
      this.createdAt,
      this.paidAt})
      : _items = items;

  factory _$OrderImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderImplFromJson(json);

  /// Unique identifier
  @override
  final String id;

  /// ID of the user who placed the order
  @override
  final String userId;

  /// Optional associated reservation ID
  @override
  final String? reservationId;

  /// List of items in the order
  final List<OrderItem> _items;

  /// List of items in the order
  @override
  @JsonKey()
  List<OrderItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  /// Subtotal before any fees
  @override
  final double subtotal;

  /// Service/booking fee
  @override
  @JsonKey()
  final double serviceFee;

  /// Total amount to pay
  @override
  final double totalAmount;

  /// Current payment status
  @override
  @JsonKey()
  final PaymentStatus paymentStatus;

  /// Payment method used (for display)
  @override
  final String? paymentMethod;

  /// Mock payment transaction ID
  @override
  final String? transactionId;

  /// When the order was created
  @override
  final DateTime? createdAt;

  /// When payment was completed
  @override
  final DateTime? paidAt;

  @override
  String toString() {
    return 'Order(id: $id, userId: $userId, reservationId: $reservationId, items: $items, subtotal: $subtotal, serviceFee: $serviceFee, totalAmount: $totalAmount, paymentStatus: $paymentStatus, paymentMethod: $paymentMethod, transactionId: $transactionId, createdAt: $createdAt, paidAt: $paidAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.reservationId, reservationId) ||
                other.reservationId == reservationId) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.subtotal, subtotal) ||
                other.subtotal == subtotal) &&
            (identical(other.serviceFee, serviceFee) ||
                other.serviceFee == serviceFee) &&
            (identical(other.totalAmount, totalAmount) ||
                other.totalAmount == totalAmount) &&
            (identical(other.paymentStatus, paymentStatus) ||
                other.paymentStatus == paymentStatus) &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod) &&
            (identical(other.transactionId, transactionId) ||
                other.transactionId == transactionId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.paidAt, paidAt) || other.paidAt == paidAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      reservationId,
      const DeepCollectionEquality().hash(_items),
      subtotal,
      serviceFee,
      totalAmount,
      paymentStatus,
      paymentMethod,
      transactionId,
      createdAt,
      paidAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderImplCopyWith<_$OrderImpl> get copyWith =>
      __$$OrderImplCopyWithImpl<_$OrderImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderImplToJson(
      this,
    );
  }
}

abstract class _Order implements Order {
  const factory _Order(
      {required final String id,
      required final String userId,
      final String? reservationId,
      final List<OrderItem> items,
      required final double subtotal,
      final double serviceFee,
      required final double totalAmount,
      final PaymentStatus paymentStatus,
      final String? paymentMethod,
      final String? transactionId,
      final DateTime? createdAt,
      final DateTime? paidAt}) = _$OrderImpl;

  factory _Order.fromJson(Map<String, dynamic> json) = _$OrderImpl.fromJson;

  @override

  /// Unique identifier
  String get id;
  @override

  /// ID of the user who placed the order
  String get userId;
  @override

  /// Optional associated reservation ID
  String? get reservationId;
  @override

  /// List of items in the order
  List<OrderItem> get items;
  @override

  /// Subtotal before any fees
  double get subtotal;
  @override

  /// Service/booking fee
  double get serviceFee;
  @override

  /// Total amount to pay
  double get totalAmount;
  @override

  /// Current payment status
  PaymentStatus get paymentStatus;
  @override

  /// Payment method used (for display)
  String? get paymentMethod;
  @override

  /// Mock payment transaction ID
  String? get transactionId;
  @override

  /// When the order was created
  DateTime? get createdAt;
  @override

  /// When payment was completed
  DateTime? get paidAt;
  @override
  @JsonKey(ignore: true)
  _$$OrderImplCopyWith<_$OrderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OrderItem _$OrderItemFromJson(Map<String, dynamic> json) {
  return _OrderItem.fromJson(json);
}

/// @nodoc
mixin _$OrderItem {
  /// ID of the marketplace item
  String get itemId => throw _privateConstructorUsedError;

  /// Name of the item
  String get name => throw _privateConstructorUsedError;

  /// Quantity ordered
  int get quantity => throw _privateConstructorUsedError;

  /// Unit price
  double get unitPrice => throw _privateConstructorUsedError;

  /// Total for this line item
  double get totalPrice => throw _privateConstructorUsedError;

  /// Whether this is a rental or purchase
  bool get isRental => throw _privateConstructorUsedError;

  /// Number of rental days (if rental)
  int? get rentalDays => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OrderItemCopyWith<OrderItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderItemCopyWith<$Res> {
  factory $OrderItemCopyWith(OrderItem value, $Res Function(OrderItem) then) =
      _$OrderItemCopyWithImpl<$Res, OrderItem>;
  @useResult
  $Res call(
      {String itemId,
      String name,
      int quantity,
      double unitPrice,
      double totalPrice,
      bool isRental,
      int? rentalDays});
}

/// @nodoc
class _$OrderItemCopyWithImpl<$Res, $Val extends OrderItem>
    implements $OrderItemCopyWith<$Res> {
  _$OrderItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? itemId = null,
    Object? name = null,
    Object? quantity = null,
    Object? unitPrice = null,
    Object? totalPrice = null,
    Object? isRental = null,
    Object? rentalDays = freezed,
  }) {
    return _then(_value.copyWith(
      itemId: null == itemId
          ? _value.itemId
          : itemId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      unitPrice: null == unitPrice
          ? _value.unitPrice
          : unitPrice // ignore: cast_nullable_to_non_nullable
              as double,
      totalPrice: null == totalPrice
          ? _value.totalPrice
          : totalPrice // ignore: cast_nullable_to_non_nullable
              as double,
      isRental: null == isRental
          ? _value.isRental
          : isRental // ignore: cast_nullable_to_non_nullable
              as bool,
      rentalDays: freezed == rentalDays
          ? _value.rentalDays
          : rentalDays // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OrderItemImplCopyWith<$Res>
    implements $OrderItemCopyWith<$Res> {
  factory _$$OrderItemImplCopyWith(
          _$OrderItemImpl value, $Res Function(_$OrderItemImpl) then) =
      __$$OrderItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String itemId,
      String name,
      int quantity,
      double unitPrice,
      double totalPrice,
      bool isRental,
      int? rentalDays});
}

/// @nodoc
class __$$OrderItemImplCopyWithImpl<$Res>
    extends _$OrderItemCopyWithImpl<$Res, _$OrderItemImpl>
    implements _$$OrderItemImplCopyWith<$Res> {
  __$$OrderItemImplCopyWithImpl(
      _$OrderItemImpl _value, $Res Function(_$OrderItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? itemId = null,
    Object? name = null,
    Object? quantity = null,
    Object? unitPrice = null,
    Object? totalPrice = null,
    Object? isRental = null,
    Object? rentalDays = freezed,
  }) {
    return _then(_$OrderItemImpl(
      itemId: null == itemId
          ? _value.itemId
          : itemId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      unitPrice: null == unitPrice
          ? _value.unitPrice
          : unitPrice // ignore: cast_nullable_to_non_nullable
              as double,
      totalPrice: null == totalPrice
          ? _value.totalPrice
          : totalPrice // ignore: cast_nullable_to_non_nullable
              as double,
      isRental: null == isRental
          ? _value.isRental
          : isRental // ignore: cast_nullable_to_non_nullable
              as bool,
      rentalDays: freezed == rentalDays
          ? _value.rentalDays
          : rentalDays // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderItemImpl implements _OrderItem {
  const _$OrderItemImpl(
      {required this.itemId,
      required this.name,
      this.quantity = 1,
      required this.unitPrice,
      required this.totalPrice,
      this.isRental = false,
      this.rentalDays});

  factory _$OrderItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderItemImplFromJson(json);

  /// ID of the marketplace item
  @override
  final String itemId;

  /// Name of the item
  @override
  final String name;

  /// Quantity ordered
  @override
  @JsonKey()
  final int quantity;

  /// Unit price
  @override
  final double unitPrice;

  /// Total for this line item
  @override
  final double totalPrice;

  /// Whether this is a rental or purchase
  @override
  @JsonKey()
  final bool isRental;

  /// Number of rental days (if rental)
  @override
  final int? rentalDays;

  @override
  String toString() {
    return 'OrderItem(itemId: $itemId, name: $name, quantity: $quantity, unitPrice: $unitPrice, totalPrice: $totalPrice, isRental: $isRental, rentalDays: $rentalDays)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderItemImpl &&
            (identical(other.itemId, itemId) || other.itemId == itemId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.unitPrice, unitPrice) ||
                other.unitPrice == unitPrice) &&
            (identical(other.totalPrice, totalPrice) ||
                other.totalPrice == totalPrice) &&
            (identical(other.isRental, isRental) ||
                other.isRental == isRental) &&
            (identical(other.rentalDays, rentalDays) ||
                other.rentalDays == rentalDays));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, itemId, name, quantity,
      unitPrice, totalPrice, isRental, rentalDays);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderItemImplCopyWith<_$OrderItemImpl> get copyWith =>
      __$$OrderItemImplCopyWithImpl<_$OrderItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderItemImplToJson(
      this,
    );
  }
}

abstract class _OrderItem implements OrderItem {
  const factory _OrderItem(
      {required final String itemId,
      required final String name,
      final int quantity,
      required final double unitPrice,
      required final double totalPrice,
      final bool isRental,
      final int? rentalDays}) = _$OrderItemImpl;

  factory _OrderItem.fromJson(Map<String, dynamic> json) =
      _$OrderItemImpl.fromJson;

  @override

  /// ID of the marketplace item
  String get itemId;
  @override

  /// Name of the item
  String get name;
  @override

  /// Quantity ordered
  int get quantity;
  @override

  /// Unit price
  double get unitPrice;
  @override

  /// Total for this line item
  double get totalPrice;
  @override

  /// Whether this is a rental or purchase
  bool get isRental;
  @override

  /// Number of rental days (if rental)
  int? get rentalDays;
  @override
  @JsonKey(ignore: true)
  _$$OrderItemImplCopyWith<_$OrderItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
