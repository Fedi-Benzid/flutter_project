// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'center.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CampingCenter _$CampingCenterFromJson(Map<String, dynamic> json) {
  return _CampingCenter.fromJson(json);
}

/// @nodoc
mixin _$CampingCenter {
  /// Unique identifier for the center
  String get id => throw _privateConstructorUsedError;

  /// ID of the owner user
  String get ownerId => throw _privateConstructorUsedError;

  /// Name of the camping center
  String get name => throw _privateConstructorUsedError;

  /// Detailed description of the center
  String get description => throw _privateConstructorUsedError;

  /// Location/address of the center
  String get location => throw _privateConstructorUsedError;

  /// List of photo URLs for the center
  List<String> get photos => throw _privateConstructorUsedError;

  /// List of amenity codes (e.g., 'wifi', 'shower', 'parking')
  /// See CenterAmenities in constants.dart for available options
  List<String> get amenities => throw _privateConstructorUsedError;

  /// List of tags for categorization and search
  /// (e.g., 'lake', 'mountain', 'family')
  /// See CenterTags in constants.dart for available options
  List<String> get tags => throw _privateConstructorUsedError;

  /// Minimum price per night
  double get priceMin => throw _privateConstructorUsedError;

  /// Maximum price per night
  double get priceMax => throw _privateConstructorUsedError;

  /// Whether this center is featured/interesting
  /// Used for discovery and recommendations
  bool get isInteresting => throw _privateConstructorUsedError;

  /// Average rating from reviews (1-5)
  double get averageRating => throw _privateConstructorUsedError;

  /// Total number of reviews
  int get reviewCount => throw _privateConstructorUsedError;

  /// Geographic latitude for map display
  double? get latitude => throw _privateConstructorUsedError;

  /// Geographic longitude for map display
  double? get longitude => throw _privateConstructorUsedError;

  /// When the center was created
  DateTime? get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CampingCenterCopyWith<CampingCenter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CampingCenterCopyWith<$Res> {
  factory $CampingCenterCopyWith(
          CampingCenter value, $Res Function(CampingCenter) then) =
      _$CampingCenterCopyWithImpl<$Res, CampingCenter>;
  @useResult
  $Res call(
      {String id,
      String ownerId,
      String name,
      String description,
      String location,
      List<String> photos,
      List<String> amenities,
      List<String> tags,
      double priceMin,
      double priceMax,
      bool isInteresting,
      double averageRating,
      int reviewCount,
      double? latitude,
      double? longitude,
      DateTime? createdAt});
}

/// @nodoc
class _$CampingCenterCopyWithImpl<$Res, $Val extends CampingCenter>
    implements $CampingCenterCopyWith<$Res> {
  _$CampingCenterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? ownerId = null,
    Object? name = null,
    Object? description = null,
    Object? location = null,
    Object? photos = null,
    Object? amenities = null,
    Object? tags = null,
    Object? priceMin = null,
    Object? priceMax = null,
    Object? isInteresting = null,
    Object? averageRating = null,
    Object? reviewCount = null,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      ownerId: null == ownerId
          ? _value.ownerId
          : ownerId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      photos: null == photos
          ? _value.photos
          : photos // ignore: cast_nullable_to_non_nullable
              as List<String>,
      amenities: null == amenities
          ? _value.amenities
          : amenities // ignore: cast_nullable_to_non_nullable
              as List<String>,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      priceMin: null == priceMin
          ? _value.priceMin
          : priceMin // ignore: cast_nullable_to_non_nullable
              as double,
      priceMax: null == priceMax
          ? _value.priceMax
          : priceMax // ignore: cast_nullable_to_non_nullable
              as double,
      isInteresting: null == isInteresting
          ? _value.isInteresting
          : isInteresting // ignore: cast_nullable_to_non_nullable
              as bool,
      averageRating: null == averageRating
          ? _value.averageRating
          : averageRating // ignore: cast_nullable_to_non_nullable
              as double,
      reviewCount: null == reviewCount
          ? _value.reviewCount
          : reviewCount // ignore: cast_nullable_to_non_nullable
              as int,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CampingCenterImplCopyWith<$Res>
    implements $CampingCenterCopyWith<$Res> {
  factory _$$CampingCenterImplCopyWith(
          _$CampingCenterImpl value, $Res Function(_$CampingCenterImpl) then) =
      __$$CampingCenterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String ownerId,
      String name,
      String description,
      String location,
      List<String> photos,
      List<String> amenities,
      List<String> tags,
      double priceMin,
      double priceMax,
      bool isInteresting,
      double averageRating,
      int reviewCount,
      double? latitude,
      double? longitude,
      DateTime? createdAt});
}

/// @nodoc
class __$$CampingCenterImplCopyWithImpl<$Res>
    extends _$CampingCenterCopyWithImpl<$Res, _$CampingCenterImpl>
    implements _$$CampingCenterImplCopyWith<$Res> {
  __$$CampingCenterImplCopyWithImpl(
      _$CampingCenterImpl _value, $Res Function(_$CampingCenterImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? ownerId = null,
    Object? name = null,
    Object? description = null,
    Object? location = null,
    Object? photos = null,
    Object? amenities = null,
    Object? tags = null,
    Object? priceMin = null,
    Object? priceMax = null,
    Object? isInteresting = null,
    Object? averageRating = null,
    Object? reviewCount = null,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$CampingCenterImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      ownerId: null == ownerId
          ? _value.ownerId
          : ownerId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      photos: null == photos
          ? _value._photos
          : photos // ignore: cast_nullable_to_non_nullable
              as List<String>,
      amenities: null == amenities
          ? _value._amenities
          : amenities // ignore: cast_nullable_to_non_nullable
              as List<String>,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      priceMin: null == priceMin
          ? _value.priceMin
          : priceMin // ignore: cast_nullable_to_non_nullable
              as double,
      priceMax: null == priceMax
          ? _value.priceMax
          : priceMax // ignore: cast_nullable_to_non_nullable
              as double,
      isInteresting: null == isInteresting
          ? _value.isInteresting
          : isInteresting // ignore: cast_nullable_to_non_nullable
              as bool,
      averageRating: null == averageRating
          ? _value.averageRating
          : averageRating // ignore: cast_nullable_to_non_nullable
              as double,
      reviewCount: null == reviewCount
          ? _value.reviewCount
          : reviewCount // ignore: cast_nullable_to_non_nullable
              as int,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CampingCenterImpl implements _CampingCenter {
  const _$CampingCenterImpl(
      {required this.id,
      required this.ownerId,
      required this.name,
      required this.description,
      required this.location,
      final List<String> photos = const [],
      final List<String> amenities = const [],
      final List<String> tags = const [],
      this.priceMin = 0,
      this.priceMax = 0,
      this.isInteresting = false,
      this.averageRating = 0,
      this.reviewCount = 0,
      this.latitude,
      this.longitude,
      this.createdAt})
      : _photos = photos,
        _amenities = amenities,
        _tags = tags;

  factory _$CampingCenterImpl.fromJson(Map<String, dynamic> json) =>
      _$$CampingCenterImplFromJson(json);

  /// Unique identifier for the center
  @override
  final String id;

  /// ID of the owner user
  @override
  final String ownerId;

  /// Name of the camping center
  @override
  final String name;

  /// Detailed description of the center
  @override
  final String description;

  /// Location/address of the center
  @override
  final String location;

  /// List of photo URLs for the center
  final List<String> _photos;

  /// List of photo URLs for the center
  @override
  @JsonKey()
  List<String> get photos {
    if (_photos is EqualUnmodifiableListView) return _photos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_photos);
  }

  /// List of amenity codes (e.g., 'wifi', 'shower', 'parking')
  /// See CenterAmenities in constants.dart for available options
  final List<String> _amenities;

  /// List of amenity codes (e.g., 'wifi', 'shower', 'parking')
  /// See CenterAmenities in constants.dart for available options
  @override
  @JsonKey()
  List<String> get amenities {
    if (_amenities is EqualUnmodifiableListView) return _amenities;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_amenities);
  }

  /// List of tags for categorization and search
  /// (e.g., 'lake', 'mountain', 'family')
  /// See CenterTags in constants.dart for available options
  final List<String> _tags;

  /// List of tags for categorization and search
  /// (e.g., 'lake', 'mountain', 'family')
  /// See CenterTags in constants.dart for available options
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  /// Minimum price per night
  @override
  @JsonKey()
  final double priceMin;

  /// Maximum price per night
  @override
  @JsonKey()
  final double priceMax;

  /// Whether this center is featured/interesting
  /// Used for discovery and recommendations
  @override
  @JsonKey()
  final bool isInteresting;

  /// Average rating from reviews (1-5)
  @override
  @JsonKey()
  final double averageRating;

  /// Total number of reviews
  @override
  @JsonKey()
  final int reviewCount;

  /// Geographic latitude for map display
  @override
  final double? latitude;

  /// Geographic longitude for map display
  @override
  final double? longitude;

  /// When the center was created
  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'CampingCenter(id: $id, ownerId: $ownerId, name: $name, description: $description, location: $location, photos: $photos, amenities: $amenities, tags: $tags, priceMin: $priceMin, priceMax: $priceMax, isInteresting: $isInteresting, averageRating: $averageRating, reviewCount: $reviewCount, latitude: $latitude, longitude: $longitude, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CampingCenterImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.ownerId, ownerId) || other.ownerId == ownerId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.location, location) ||
                other.location == location) &&
            const DeepCollectionEquality().equals(other._photos, _photos) &&
            const DeepCollectionEquality()
                .equals(other._amenities, _amenities) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.priceMin, priceMin) ||
                other.priceMin == priceMin) &&
            (identical(other.priceMax, priceMax) ||
                other.priceMax == priceMax) &&
            (identical(other.isInteresting, isInteresting) ||
                other.isInteresting == isInteresting) &&
            (identical(other.averageRating, averageRating) ||
                other.averageRating == averageRating) &&
            (identical(other.reviewCount, reviewCount) ||
                other.reviewCount == reviewCount) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      ownerId,
      name,
      description,
      location,
      const DeepCollectionEquality().hash(_photos),
      const DeepCollectionEquality().hash(_amenities),
      const DeepCollectionEquality().hash(_tags),
      priceMin,
      priceMax,
      isInteresting,
      averageRating,
      reviewCount,
      latitude,
      longitude,
      createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CampingCenterImplCopyWith<_$CampingCenterImpl> get copyWith =>
      __$$CampingCenterImplCopyWithImpl<_$CampingCenterImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CampingCenterImplToJson(
      this,
    );
  }
}

abstract class _CampingCenter implements CampingCenter {
  const factory _CampingCenter(
      {required final String id,
      required final String ownerId,
      required final String name,
      required final String description,
      required final String location,
      final List<String> photos,
      final List<String> amenities,
      final List<String> tags,
      final double priceMin,
      final double priceMax,
      final bool isInteresting,
      final double averageRating,
      final int reviewCount,
      final double? latitude,
      final double? longitude,
      final DateTime? createdAt}) = _$CampingCenterImpl;

  factory _CampingCenter.fromJson(Map<String, dynamic> json) =
      _$CampingCenterImpl.fromJson;

  @override

  /// Unique identifier for the center
  String get id;
  @override

  /// ID of the owner user
  String get ownerId;
  @override

  /// Name of the camping center
  String get name;
  @override

  /// Detailed description of the center
  String get description;
  @override

  /// Location/address of the center
  String get location;
  @override

  /// List of photo URLs for the center
  List<String> get photos;
  @override

  /// List of amenity codes (e.g., 'wifi', 'shower', 'parking')
  /// See CenterAmenities in constants.dart for available options
  List<String> get amenities;
  @override

  /// List of tags for categorization and search
  /// (e.g., 'lake', 'mountain', 'family')
  /// See CenterTags in constants.dart for available options
  List<String> get tags;
  @override

  /// Minimum price per night
  double get priceMin;
  @override

  /// Maximum price per night
  double get priceMax;
  @override

  /// Whether this center is featured/interesting
  /// Used for discovery and recommendations
  bool get isInteresting;
  @override

  /// Average rating from reviews (1-5)
  double get averageRating;
  @override

  /// Total number of reviews
  int get reviewCount;
  @override

  /// Geographic latitude for map display
  double? get latitude;
  @override

  /// Geographic longitude for map display
  double? get longitude;
  @override

  /// When the center was created
  DateTime? get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$CampingCenterImplCopyWith<_$CampingCenterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
