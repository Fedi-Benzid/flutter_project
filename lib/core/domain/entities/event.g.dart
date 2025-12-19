// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EventImpl _$$EventImplFromJson(Map<String, dynamic> json) => _$EventImpl(
      id: json['id'] as String,
      centerId: json['centerId'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      date: DateTime.parse(json['date'] as String),
      durationHours: (json['durationHours'] as num?)?.toInt() ?? 2,
      maxParticipants: (json['maxParticipants'] as num?)?.toInt() ?? 20,
      currentParticipants: (json['currentParticipants'] as num?)?.toInt() ?? 0,
      imageUrl: json['imageUrl'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$EventImplToJson(_$EventImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'centerId': instance.centerId,
      'title': instance.title,
      'description': instance.description,
      'date': instance.date.toIso8601String(),
      'durationHours': instance.durationHours,
      'maxParticipants': instance.maxParticipants,
      'currentParticipants': instance.currentParticipants,
      'imageUrl': instance.imageUrl,
      'createdAt': instance.createdAt?.toIso8601String(),
    };

_$EventParticipationImpl _$$EventParticipationImplFromJson(
        Map<String, dynamic> json) =>
    _$EventParticipationImpl(
      id: json['id'] as String,
      eventId: json['eventId'] as String,
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      status:
          $enumDecodeNullable(_$ParticipationStatusEnumMap, json['status']) ??
              ParticipationStatus.pending,
      message: json['message'] as String?,
      requestedAt: json['requestedAt'] == null
          ? null
          : DateTime.parse(json['requestedAt'] as String),
    );

Map<String, dynamic> _$$EventParticipationImplToJson(
        _$EventParticipationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'eventId': instance.eventId,
      'userId': instance.userId,
      'userName': instance.userName,
      'status': _$ParticipationStatusEnumMap[instance.status]!,
      'message': instance.message,
      'requestedAt': instance.requestedAt?.toIso8601String(),
    };

const _$ParticipationStatusEnumMap = {
  ParticipationStatus.pending: 'pending',
  ParticipationStatus.approved: 'approved',
  ParticipationStatus.declined: 'declined',
};
