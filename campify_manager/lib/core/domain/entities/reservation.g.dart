// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReservationImpl _$$ReservationImplFromJson(Map<String, dynamic> json) =>
    _$ReservationImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      centerId: json['centerId'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      guestCount: (json['guestCount'] as num?)?.toInt() ?? 1,
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => ReservationItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      status: $enumDecodeNullable(_$ReservationStatusEnumMap, json['status']) ??
          ReservationStatus.pending,
      basePrice: (json['basePrice'] as num).toDouble(),
      totalPrice: (json['totalPrice'] as num).toDouble(),
      notes: json['notes'] as String?,
      orderId: json['orderId'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$ReservationImplToJson(_$ReservationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'centerId': instance.centerId,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'guestCount': instance.guestCount,
      'items': instance.items,
      'status': _$ReservationStatusEnumMap[instance.status]!,
      'basePrice': instance.basePrice,
      'totalPrice': instance.totalPrice,
      'notes': instance.notes,
      'orderId': instance.orderId,
      'createdAt': instance.createdAt?.toIso8601String(),
    };

const _$ReservationStatusEnumMap = {
  ReservationStatus.pending: 'pending',
  ReservationStatus.approved: 'approved',
  ReservationStatus.declined: 'declined',
  ReservationStatus.cancelled: 'cancelled',
  ReservationStatus.completed: 'completed',
};

_$ReservationItemImpl _$$ReservationItemImplFromJson(
        Map<String, dynamic> json) =>
    _$ReservationItemImpl(
      itemId: json['itemId'] as String,
      itemName: json['itemName'] as String,
      quantity: (json['quantity'] as num?)?.toInt() ?? 1,
      pricePerDay: (json['pricePerDay'] as num).toDouble(),
      totalPrice: (json['totalPrice'] as num).toDouble(),
    );

Map<String, dynamic> _$$ReservationItemImplToJson(
        _$ReservationItemImpl instance) =>
    <String, dynamic>{
      'itemId': instance.itemId,
      'itemName': instance.itemName,
      'quantity': instance.quantity,
      'pricePerDay': instance.pricePerDay,
      'totalPrice': instance.totalPrice,
    };
