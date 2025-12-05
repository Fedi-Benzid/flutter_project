// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reservation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Reservation _$ReservationFromJson(Map<String, dynamic> json) {
  return _Reservation.fromJson(json);
}

/// @nodoc
mixin _$Reservation {
  /// Unique identifier
  String get id => throw _privateConstructorUsedError;

  /// ID of the user making the reservation
  String get userId => throw _privateConstructorUsedError;

  /// ID of the camping center
  String get centerId => throw _privateConstructorUsedError;

  /// Check-in date
  DateTime get startDate => throw _privateConstructorUsedError;

  /// Check-out date
  DateTime get endDate => throw _privateConstructorUsedError;

  /// Number of guests
  int get guestCount => throw _privateConstructorUsedError;

  /// Optional items rented with the reservation
  List<ReservationItem> get items => throw _privateConstructorUsedError;

  /// Current status
  ReservationStatus get status => throw _privateConstructorUsedError;

  /// Base price for the stay (center price * nights)
  double get basePrice => throw _privateConstructorUsedError;

  /// Total price including items
  double get totalPrice => throw _privateConstructorUsedError;

  /// Special requests or notes
  String? get notes => throw _privateConstructorUsedError;

  /// Associated order ID after payment
  String? get orderId => throw _privateConstructorUsedError;

  /// When the reservation was created
  DateTime? get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReservationCopyWith<Reservation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReservationCopyWith<$Res> {
  factory $ReservationCopyWith(
          Reservation value, $Res Function(Reservation) then) =
      _$ReservationCopyWithImpl<$Res, Reservation>;
  @useResult
  $Res call(
      {String id,
      String userId,
      String centerId,
      DateTime startDate,
      DateTime endDate,
      int guestCount,
      List<ReservationItem> items,
      ReservationStatus status,
      double basePrice,
      double totalPrice,
      String? notes,
      String? orderId,
      DateTime? createdAt});
}

/// @nodoc
class _$ReservationCopyWithImpl<$Res, $Val extends Reservation>
    implements $ReservationCopyWith<$Res> {
  _$ReservationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? centerId = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? guestCount = null,
    Object? items = null,
    Object? status = null,
    Object? basePrice = null,
    Object? totalPrice = null,
    Object? notes = freezed,
    Object? orderId = freezed,
    Object? createdAt = freezed,
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
      centerId: null == centerId
          ? _value.centerId
          : centerId // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      guestCount: null == guestCount
          ? _value.guestCount
          : guestCount // ignore: cast_nullable_to_non_nullable
              as int,
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<ReservationItem>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ReservationStatus,
      basePrice: null == basePrice
          ? _value.basePrice
          : basePrice // ignore: cast_nullable_to_non_nullable
              as double,
      totalPrice: null == totalPrice
          ? _value.totalPrice
          : totalPrice // ignore: cast_nullable_to_non_nullable
              as double,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      orderId: freezed == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReservationImplCopyWith<$Res>
    implements $ReservationCopyWith<$Res> {
  factory _$$ReservationImplCopyWith(
          _$ReservationImpl value, $Res Function(_$ReservationImpl) then) =
      __$$ReservationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String centerId,
      DateTime startDate,
      DateTime endDate,
      int guestCount,
      List<ReservationItem> items,
      ReservationStatus status,
      double basePrice,
      double totalPrice,
      String? notes,
      String? orderId,
      DateTime? createdAt});
}

/// @nodoc
class __$$ReservationImplCopyWithImpl<$Res>
    extends _$ReservationCopyWithImpl<$Res, _$ReservationImpl>
    implements _$$ReservationImplCopyWith<$Res> {
  __$$ReservationImplCopyWithImpl(
      _$ReservationImpl _value, $Res Function(_$ReservationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? centerId = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? guestCount = null,
    Object? items = null,
    Object? status = null,
    Object? basePrice = null,
    Object? totalPrice = null,
    Object? notes = freezed,
    Object? orderId = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$ReservationImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      centerId: null == centerId
          ? _value.centerId
          : centerId // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      guestCount: null == guestCount
          ? _value.guestCount
          : guestCount // ignore: cast_nullable_to_non_nullable
              as int,
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<ReservationItem>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ReservationStatus,
      basePrice: null == basePrice
          ? _value.basePrice
          : basePrice // ignore: cast_nullable_to_non_nullable
              as double,
      totalPrice: null == totalPrice
          ? _value.totalPrice
          : totalPrice // ignore: cast_nullable_to_non_nullable
              as double,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      orderId: freezed == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReservationImpl implements _Reservation {
  const _$ReservationImpl(
      {required this.id,
      required this.userId,
      required this.centerId,
      required this.startDate,
      required this.endDate,
      this.guestCount = 1,
      final List<ReservationItem> items = const [],
      this.status = ReservationStatus.pending,
      required this.basePrice,
      required this.totalPrice,
      this.notes,
      this.orderId,
      this.createdAt})
      : _items = items;

  factory _$ReservationImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReservationImplFromJson(json);

  /// Unique identifier
  @override
  final String id;

  /// ID of the user making the reservation
  @override
  final String userId;

  /// ID of the camping center
  @override
  final String centerId;

  /// Check-in date
  @override
  final DateTime startDate;

  /// Check-out date
  @override
  final DateTime endDate;

  /// Number of guests
  @override
  @JsonKey()
  final int guestCount;

  /// Optional items rented with the reservation
  final List<ReservationItem> _items;

  /// Optional items rented with the reservation
  @override
  @JsonKey()
  List<ReservationItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  /// Current status
  @override
  @JsonKey()
  final ReservationStatus status;

  /// Base price for the stay (center price * nights)
  @override
  final double basePrice;

  /// Total price including items
  @override
  final double totalPrice;

  /// Special requests or notes
  @override
  final String? notes;

  /// Associated order ID after payment
  @override
  final String? orderId;

  /// When the reservation was created
  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'Reservation(id: $id, userId: $userId, centerId: $centerId, startDate: $startDate, endDate: $endDate, guestCount: $guestCount, items: $items, status: $status, basePrice: $basePrice, totalPrice: $totalPrice, notes: $notes, orderId: $orderId, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReservationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.centerId, centerId) ||
                other.centerId == centerId) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.guestCount, guestCount) ||
                other.guestCount == guestCount) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.basePrice, basePrice) ||
                other.basePrice == basePrice) &&
            (identical(other.totalPrice, totalPrice) ||
                other.totalPrice == totalPrice) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      centerId,
      startDate,
      endDate,
      guestCount,
      const DeepCollectionEquality().hash(_items),
      status,
      basePrice,
      totalPrice,
      notes,
      orderId,
      createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ReservationImplCopyWith<_$ReservationImpl> get copyWith =>
      __$$ReservationImplCopyWithImpl<_$ReservationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReservationImplToJson(
      this,
    );
  }
}

abstract class _Reservation implements Reservation {
  const factory _Reservation(
      {required final String id,
      required final String userId,
      required final String centerId,
      required final DateTime startDate,
      required final DateTime endDate,
      final int guestCount,
      final List<ReservationItem> items,
      final ReservationStatus status,
      required final double basePrice,
      required final double totalPrice,
      final String? notes,
      final String? orderId,
      final DateTime? createdAt}) = _$ReservationImpl;

  factory _Reservation.fromJson(Map<String, dynamic> json) =
      _$ReservationImpl.fromJson;

  @override

  /// Unique identifier
  String get id;
  @override

  /// ID of the user making the reservation
  String get userId;
  @override

  /// ID of the camping center
  String get centerId;
  @override

  /// Check-in date
  DateTime get startDate;
  @override

  /// Check-out date
  DateTime get endDate;
  @override

  /// Number of guests
  int get guestCount;
  @override

  /// Optional items rented with the reservation
  List<ReservationItem> get items;
  @override

  /// Current status
  ReservationStatus get status;
  @override

  /// Base price for the stay (center price * nights)
  double get basePrice;
  @override

  /// Total price including items
  double get totalPrice;
  @override

  /// Special requests or notes
  String? get notes;
  @override

  /// Associated order ID after payment
  String? get orderId;
  @override

  /// When the reservation was created
  DateTime? get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$ReservationImplCopyWith<_$ReservationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ReservationItem _$ReservationItemFromJson(Map<String, dynamic> json) {
  return _ReservationItem.fromJson(json);
}

/// @nodoc
mixin _$ReservationItem {
  /// ID of the marketplace item
  String get itemId => throw _privateConstructorUsedError;

  /// Name of the item (denormalized for display)
  String get itemName => throw _privateConstructorUsedError;

  /// Quantity reserved
  int get quantity => throw _privateConstructorUsedError;

  /// Price per day
  double get pricePerDay => throw _privateConstructorUsedError;

  /// Total price for this item
  double get totalPrice => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReservationItemCopyWith<ReservationItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReservationItemCopyWith<$Res> {
  factory $ReservationItemCopyWith(
          ReservationItem value, $Res Function(ReservationItem) then) =
      _$ReservationItemCopyWithImpl<$Res, ReservationItem>;
  @useResult
  $Res call(
      {String itemId,
      String itemName,
      int quantity,
      double pricePerDay,
      double totalPrice});
}

/// @nodoc
class _$ReservationItemCopyWithImpl<$Res, $Val extends ReservationItem>
    implements $ReservationItemCopyWith<$Res> {
  _$ReservationItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? itemId = null,
    Object? itemName = null,
    Object? quantity = null,
    Object? pricePerDay = null,
    Object? totalPrice = null,
  }) {
    return _then(_value.copyWith(
      itemId: null == itemId
          ? _value.itemId
          : itemId // ignore: cast_nullable_to_non_nullable
              as String,
      itemName: null == itemName
          ? _value.itemName
          : itemName // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      pricePerDay: null == pricePerDay
          ? _value.pricePerDay
          : pricePerDay // ignore: cast_nullable_to_non_nullable
              as double,
      totalPrice: null == totalPrice
          ? _value.totalPrice
          : totalPrice // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReservationItemImplCopyWith<$Res>
    implements $ReservationItemCopyWith<$Res> {
  factory _$$ReservationItemImplCopyWith(_$ReservationItemImpl value,
          $Res Function(_$ReservationItemImpl) then) =
      __$$ReservationItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String itemId,
      String itemName,
      int quantity,
      double pricePerDay,
      double totalPrice});
}

/// @nodoc
class __$$ReservationItemImplCopyWithImpl<$Res>
    extends _$ReservationItemCopyWithImpl<$Res, _$ReservationItemImpl>
    implements _$$ReservationItemImplCopyWith<$Res> {
  __$$ReservationItemImplCopyWithImpl(
      _$ReservationItemImpl _value, $Res Function(_$ReservationItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? itemId = null,
    Object? itemName = null,
    Object? quantity = null,
    Object? pricePerDay = null,
    Object? totalPrice = null,
  }) {
    return _then(_$ReservationItemImpl(
      itemId: null == itemId
          ? _value.itemId
          : itemId // ignore: cast_nullable_to_non_nullable
              as String,
      itemName: null == itemName
          ? _value.itemName
          : itemName // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      pricePerDay: null == pricePerDay
          ? _value.pricePerDay
          : pricePerDay // ignore: cast_nullable_to_non_nullable
              as double,
      totalPrice: null == totalPrice
          ? _value.totalPrice
          : totalPrice // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReservationItemImpl implements _ReservationItem {
  const _$ReservationItemImpl(
      {required this.itemId,
      required this.itemName,
      this.quantity = 1,
      required this.pricePerDay,
      required this.totalPrice});

  factory _$ReservationItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReservationItemImplFromJson(json);

  /// ID of the marketplace item
  @override
  final String itemId;

  /// Name of the item (denormalized for display)
  @override
  final String itemName;

  /// Quantity reserved
  @override
  @JsonKey()
  final int quantity;

  /// Price per day
  @override
  final double pricePerDay;

  /// Total price for this item
  @override
  final double totalPrice;

  @override
  String toString() {
    return 'ReservationItem(itemId: $itemId, itemName: $itemName, quantity: $quantity, pricePerDay: $pricePerDay, totalPrice: $totalPrice)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReservationItemImpl &&
            (identical(other.itemId, itemId) || other.itemId == itemId) &&
            (identical(other.itemName, itemName) ||
                other.itemName == itemName) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.pricePerDay, pricePerDay) ||
                other.pricePerDay == pricePerDay) &&
            (identical(other.totalPrice, totalPrice) ||
                other.totalPrice == totalPrice));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, itemId, itemName, quantity, pricePerDay, totalPrice);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ReservationItemImplCopyWith<_$ReservationItemImpl> get copyWith =>
      __$$ReservationItemImplCopyWithImpl<_$ReservationItemImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReservationItemImplToJson(
      this,
    );
  }
}

abstract class _ReservationItem implements ReservationItem {
  const factory _ReservationItem(
      {required final String itemId,
      required final String itemName,
      final int quantity,
      required final double pricePerDay,
      required final double totalPrice}) = _$ReservationItemImpl;

  factory _ReservationItem.fromJson(Map<String, dynamic> json) =
      _$ReservationItemImpl.fromJson;

  @override

  /// ID of the marketplace item
  String get itemId;
  @override

  /// Name of the item (denormalized for display)
  String get itemName;
  @override

  /// Quantity reserved
  int get quantity;
  @override

  /// Price per day
  double get pricePerDay;
  @override

  /// Total price for this item
  double get totalPrice;
  @override
  @JsonKey(ignore: true)
  _$$ReservationItemImplCopyWith<_$ReservationItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
