// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Event _$EventFromJson(Map<String, dynamic> json) {
  return _Event.fromJson(json);
}

/// @nodoc
mixin _$Event {
  /// Unique identifier
  String get id => throw _privateConstructorUsedError;

  /// ID of the center where the event takes place
  String get centerId => throw _privateConstructorUsedError;

  /// Event title
  String get title => throw _privateConstructorUsedError;

  /// Detailed description of the event
  String get description => throw _privateConstructorUsedError;

  /// Date and time of the event
  DateTime get date => throw _privateConstructorUsedError;

  /// Duration in hours
  int get durationHours => throw _privateConstructorUsedError;

  /// Maximum number of participants
  int get maxParticipants => throw _privateConstructorUsedError;

  /// Current number of confirmed participants
  int get currentParticipants => throw _privateConstructorUsedError;

  /// Optional image URL for the event
  String? get imageUrl => throw _privateConstructorUsedError;

  /// When the event was created
  DateTime? get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EventCopyWith<Event> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventCopyWith<$Res> {
  factory $EventCopyWith(Event value, $Res Function(Event) then) =
      _$EventCopyWithImpl<$Res, Event>;
  @useResult
  $Res call(
      {String id,
      String centerId,
      String title,
      String description,
      DateTime date,
      int durationHours,
      int maxParticipants,
      int currentParticipants,
      String? imageUrl,
      DateTime? createdAt});
}

/// @nodoc
class _$EventCopyWithImpl<$Res, $Val extends Event>
    implements $EventCopyWith<$Res> {
  _$EventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? centerId = null,
    Object? title = null,
    Object? description = null,
    Object? date = null,
    Object? durationHours = null,
    Object? maxParticipants = null,
    Object? currentParticipants = null,
    Object? imageUrl = freezed,
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
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      durationHours: null == durationHours
          ? _value.durationHours
          : durationHours // ignore: cast_nullable_to_non_nullable
              as int,
      maxParticipants: null == maxParticipants
          ? _value.maxParticipants
          : maxParticipants // ignore: cast_nullable_to_non_nullable
              as int,
      currentParticipants: null == currentParticipants
          ? _value.currentParticipants
          : currentParticipants // ignore: cast_nullable_to_non_nullable
              as int,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EventImplCopyWith<$Res> implements $EventCopyWith<$Res> {
  factory _$$EventImplCopyWith(
          _$EventImpl value, $Res Function(_$EventImpl) then) =
      __$$EventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String centerId,
      String title,
      String description,
      DateTime date,
      int durationHours,
      int maxParticipants,
      int currentParticipants,
      String? imageUrl,
      DateTime? createdAt});
}

/// @nodoc
class __$$EventImplCopyWithImpl<$Res>
    extends _$EventCopyWithImpl<$Res, _$EventImpl>
    implements _$$EventImplCopyWith<$Res> {
  __$$EventImplCopyWithImpl(
      _$EventImpl _value, $Res Function(_$EventImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? centerId = null,
    Object? title = null,
    Object? description = null,
    Object? date = null,
    Object? durationHours = null,
    Object? maxParticipants = null,
    Object? currentParticipants = null,
    Object? imageUrl = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$EventImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      centerId: null == centerId
          ? _value.centerId
          : centerId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      durationHours: null == durationHours
          ? _value.durationHours
          : durationHours // ignore: cast_nullable_to_non_nullable
              as int,
      maxParticipants: null == maxParticipants
          ? _value.maxParticipants
          : maxParticipants // ignore: cast_nullable_to_non_nullable
              as int,
      currentParticipants: null == currentParticipants
          ? _value.currentParticipants
          : currentParticipants // ignore: cast_nullable_to_non_nullable
              as int,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
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
class _$EventImpl implements _Event {
  const _$EventImpl(
      {required this.id,
      required this.centerId,
      required this.title,
      required this.description,
      required this.date,
      this.durationHours = 2,
      this.maxParticipants = 20,
      this.currentParticipants = 0,
      this.imageUrl,
      this.createdAt});

  factory _$EventImpl.fromJson(Map<String, dynamic> json) =>
      _$$EventImplFromJson(json);

  /// Unique identifier
  @override
  final String id;

  /// ID of the center where the event takes place
  @override
  final String centerId;

  /// Event title
  @override
  final String title;

  /// Detailed description of the event
  @override
  final String description;

  /// Date and time of the event
  @override
  final DateTime date;

  /// Duration in hours
  @override
  @JsonKey()
  final int durationHours;

  /// Maximum number of participants
  @override
  @JsonKey()
  final int maxParticipants;

  /// Current number of confirmed participants
  @override
  @JsonKey()
  final int currentParticipants;

  /// Optional image URL for the event
  @override
  final String? imageUrl;

  /// When the event was created
  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'Event(id: $id, centerId: $centerId, title: $title, description: $description, date: $date, durationHours: $durationHours, maxParticipants: $maxParticipants, currentParticipants: $currentParticipants, imageUrl: $imageUrl, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EventImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.centerId, centerId) ||
                other.centerId == centerId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.durationHours, durationHours) ||
                other.durationHours == durationHours) &&
            (identical(other.maxParticipants, maxParticipants) ||
                other.maxParticipants == maxParticipants) &&
            (identical(other.currentParticipants, currentParticipants) ||
                other.currentParticipants == currentParticipants) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      centerId,
      title,
      description,
      date,
      durationHours,
      maxParticipants,
      currentParticipants,
      imageUrl,
      createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EventImplCopyWith<_$EventImpl> get copyWith =>
      __$$EventImplCopyWithImpl<_$EventImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EventImplToJson(
      this,
    );
  }
}

abstract class _Event implements Event {
  const factory _Event(
      {required final String id,
      required final String centerId,
      required final String title,
      required final String description,
      required final DateTime date,
      final int durationHours,
      final int maxParticipants,
      final int currentParticipants,
      final String? imageUrl,
      final DateTime? createdAt}) = _$EventImpl;

  factory _Event.fromJson(Map<String, dynamic> json) = _$EventImpl.fromJson;

  @override

  /// Unique identifier
  String get id;
  @override

  /// ID of the center where the event takes place
  String get centerId;
  @override

  /// Event title
  String get title;
  @override

  /// Detailed description of the event
  String get description;
  @override

  /// Date and time of the event
  DateTime get date;
  @override

  /// Duration in hours
  int get durationHours;
  @override

  /// Maximum number of participants
  int get maxParticipants;
  @override

  /// Current number of confirmed participants
  int get currentParticipants;
  @override

  /// Optional image URL for the event
  String? get imageUrl;
  @override

  /// When the event was created
  DateTime? get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$EventImplCopyWith<_$EventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

EventParticipation _$EventParticipationFromJson(Map<String, dynamic> json) {
  return _EventParticipation.fromJson(json);
}

/// @nodoc
mixin _$EventParticipation {
  /// Unique identifier
  String get id => throw _privateConstructorUsedError;

  /// ID of the event
  String get eventId => throw _privateConstructorUsedError;

  /// ID of the user requesting to participate
  String get userId => throw _privateConstructorUsedError;

  /// Name of the user (denormalized for display)
  String get userName => throw _privateConstructorUsedError;

  /// Current status of the request
  ParticipationStatus get status => throw _privateConstructorUsedError;

  /// Optional message from the requester
  String? get message => throw _privateConstructorUsedError;

  /// When the request was made
  DateTime? get requestedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EventParticipationCopyWith<EventParticipation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventParticipationCopyWith<$Res> {
  factory $EventParticipationCopyWith(
          EventParticipation value, $Res Function(EventParticipation) then) =
      _$EventParticipationCopyWithImpl<$Res, EventParticipation>;
  @useResult
  $Res call(
      {String id,
      String eventId,
      String userId,
      String userName,
      ParticipationStatus status,
      String? message,
      DateTime? requestedAt});
}

/// @nodoc
class _$EventParticipationCopyWithImpl<$Res, $Val extends EventParticipation>
    implements $EventParticipationCopyWith<$Res> {
  _$EventParticipationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? eventId = null,
    Object? userId = null,
    Object? userName = null,
    Object? status = null,
    Object? message = freezed,
    Object? requestedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      eventId: null == eventId
          ? _value.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ParticipationStatus,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      requestedAt: freezed == requestedAt
          ? _value.requestedAt
          : requestedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EventParticipationImplCopyWith<$Res>
    implements $EventParticipationCopyWith<$Res> {
  factory _$$EventParticipationImplCopyWith(_$EventParticipationImpl value,
          $Res Function(_$EventParticipationImpl) then) =
      __$$EventParticipationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String eventId,
      String userId,
      String userName,
      ParticipationStatus status,
      String? message,
      DateTime? requestedAt});
}

/// @nodoc
class __$$EventParticipationImplCopyWithImpl<$Res>
    extends _$EventParticipationCopyWithImpl<$Res, _$EventParticipationImpl>
    implements _$$EventParticipationImplCopyWith<$Res> {
  __$$EventParticipationImplCopyWithImpl(_$EventParticipationImpl _value,
      $Res Function(_$EventParticipationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? eventId = null,
    Object? userId = null,
    Object? userName = null,
    Object? status = null,
    Object? message = freezed,
    Object? requestedAt = freezed,
  }) {
    return _then(_$EventParticipationImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      eventId: null == eventId
          ? _value.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ParticipationStatus,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      requestedAt: freezed == requestedAt
          ? _value.requestedAt
          : requestedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EventParticipationImpl implements _EventParticipation {
  const _$EventParticipationImpl(
      {required this.id,
      required this.eventId,
      required this.userId,
      required this.userName,
      this.status = ParticipationStatus.pending,
      this.message,
      this.requestedAt});

  factory _$EventParticipationImpl.fromJson(Map<String, dynamic> json) =>
      _$$EventParticipationImplFromJson(json);

  /// Unique identifier
  @override
  final String id;

  /// ID of the event
  @override
  final String eventId;

  /// ID of the user requesting to participate
  @override
  final String userId;

  /// Name of the user (denormalized for display)
  @override
  final String userName;

  /// Current status of the request
  @override
  @JsonKey()
  final ParticipationStatus status;

  /// Optional message from the requester
  @override
  final String? message;

  /// When the request was made
  @override
  final DateTime? requestedAt;

  @override
  String toString() {
    return 'EventParticipation(id: $id, eventId: $eventId, userId: $userId, userName: $userName, status: $status, message: $message, requestedAt: $requestedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EventParticipationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.eventId, eventId) || other.eventId == eventId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.requestedAt, requestedAt) ||
                other.requestedAt == requestedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, eventId, userId, userName, status, message, requestedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EventParticipationImplCopyWith<_$EventParticipationImpl> get copyWith =>
      __$$EventParticipationImplCopyWithImpl<_$EventParticipationImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EventParticipationImplToJson(
      this,
    );
  }
}

abstract class _EventParticipation implements EventParticipation {
  const factory _EventParticipation(
      {required final String id,
      required final String eventId,
      required final String userId,
      required final String userName,
      final ParticipationStatus status,
      final String? message,
      final DateTime? requestedAt}) = _$EventParticipationImpl;

  factory _EventParticipation.fromJson(Map<String, dynamic> json) =
      _$EventParticipationImpl.fromJson;

  @override

  /// Unique identifier
  String get id;
  @override

  /// ID of the event
  String get eventId;
  @override

  /// ID of the user requesting to participate
  String get userId;
  @override

  /// Name of the user (denormalized for display)
  String get userName;
  @override

  /// Current status of the request
  ParticipationStatus get status;
  @override

  /// Optional message from the requester
  String? get message;
  @override

  /// When the request was made
  DateTime? get requestedAt;
  @override
  @JsonKey(ignore: true)
  _$$EventParticipationImplCopyWith<_$EventParticipationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
