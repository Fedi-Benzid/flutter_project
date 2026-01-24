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
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      durationHours: (json['durationHours'] as num?)?.toInt() ?? 2,
      maxParticipants: (json['maxParticipants'] as num?)?.toInt() ?? 20,
      currentParticipants: (json['currentParticipants'] as num?)?.toInt() ?? 0,
      imageUrl: json['imageUrl'] as String?,
      location: json['location'] as String?,
      price: (json['price'] as num?)?.toDouble() ?? 0,
      activities: (json['activities'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      creatorId: json['creatorId'] as String?,
      creatorPhone: json['creatorPhone'] as String?,
      centerName: json['centerName'] as String?,
      ownerFirstName: json['ownerFirstName'] as String?,
      ownerLastName: json['ownerLastName'] as String?,
      ownerPhoneNumber: json['ownerPhoneNumber'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      isClosed: json['isClosed'] as bool? ?? false,
    );

Map<String, dynamic> _$$EventImplToJson(_$EventImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'centerId': instance.centerId,
      'title': instance.title,
      'description': instance.description,
      'date': instance.date.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'durationHours': instance.durationHours,
      'maxParticipants': instance.maxParticipants,
      'currentParticipants': instance.currentParticipants,
      'imageUrl': instance.imageUrl,
      'location': instance.location,
      'price': instance.price,
      'activities': instance.activities,
      'creatorId': instance.creatorId,
      'creatorPhone': instance.creatorPhone,
      'centerName': instance.centerName,
      'ownerFirstName': instance.ownerFirstName,
      'ownerLastName': instance.ownerLastName,
      'ownerPhoneNumber': instance.ownerPhoneNumber,
      'createdAt': instance.createdAt?.toIso8601String(),
      'isClosed': instance.isClosed,
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
      phoneNumber: json['phoneNumber'] as String?,
      userEmail: json['userEmail'] as String?,
      numberOfPersons: (json['numberOfPersons'] as num?)?.toInt() ?? 1,
      comments: json['comments'] as String?,
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
      'phoneNumber': instance.phoneNumber,
      'userEmail': instance.userEmail,
      'numberOfPersons': instance.numberOfPersons,
      'comments': instance.comments,
      'requestedAt': instance.requestedAt?.toIso8601String(),
    };

const _$ParticipationStatusEnumMap = {
  ParticipationStatus.pending: 'pending',
  ParticipationStatus.approved: 'approved',
  ParticipationStatus.declined: 'declined',
};

_$EventRatingImpl _$$EventRatingImplFromJson(Map<String, dynamic> json) =>
    _$EventRatingImpl(
      id: json['id'] as String,
      eventId: json['eventId'] as String,
      userId: json['userId'] as String,
      userName: json['userName'] as String?,
      rating: (json['rating'] as num).toInt(),
      comment: json['comment'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$EventRatingImplToJson(_$EventRatingImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'eventId': instance.eventId,
      'userId': instance.userId,
      'userName': instance.userName,
      'rating': instance.rating,
      'comment': instance.comment,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
