// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'center.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CampingCenterImpl _$$CampingCenterImplFromJson(Map<String, dynamic> json) =>
    _$CampingCenterImpl(
      id: json['id'] as String,
      ownerId: json['ownerId'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      location: json['location'] as String,
      photos: (json['photos'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      amenities: (json['amenities'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      priceMin: (json['priceMin'] as num?)?.toDouble() ?? 0,
      priceMax: (json['priceMax'] as num?)?.toDouble() ?? 0,
      isInteresting: json['isInteresting'] as bool? ?? false,
      averageRating: (json['averageRating'] as num?)?.toDouble() ?? 0,
      reviewCount: (json['reviewCount'] as num?)?.toInt() ?? 0,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$CampingCenterImplToJson(_$CampingCenterImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ownerId': instance.ownerId,
      'name': instance.name,
      'description': instance.description,
      'location': instance.location,
      'photos': instance.photos,
      'amenities': instance.amenities,
      'tags': instance.tags,
      'priceMin': instance.priceMin,
      'priceMax': instance.priceMax,
      'isInteresting': instance.isInteresting,
      'averageRating': instance.averageRating,
      'reviewCount': instance.reviewCount,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
