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

  /// Date and time of the event start
  DateTime get date => throw _privateConstructorUsedError;

  /// End date and time of the event
  DateTime? get endDate => throw _privateConstructorUsedError;

  /// Duration in hours
  int get durationHours => throw _privateConstructorUsedError;

  /// Maximum number of participants
  int get maxParticipants => throw _privateConstructorUsedError;

  /// Current number of confirmed participants
  int get currentParticipants => throw _privateConstructorUsedError;

  /// Optional image URL for the event
  String? get imageUrl => throw _privateConstructorUsedError;

  /// Location of the event
  String? get location => throw _privateConstructorUsedError;

  /// Price per person
  double get price => throw _privateConstructorUsedError;

  /// Activities included in the event
  List<String> get activities => throw _privateConstructorUsedError;

  /// ID of the event creator
  String? get creatorId => throw _privateConstructorUsedError;

  /// Phone number of the event creator
  String? get creatorPhone => throw _privateConstructorUsedError;

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
      DateTime? endDate,
      int durationHours,
      int maxParticipants,
      int currentParticipants,
      String? imageUrl,
      String? location,
      double price,
      List<String> activities,
      String? creatorId,
      String? creatorPhone,
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
    Object? endDate = freezed,
    Object? durationHours = null,
    Object? maxParticipants = null,
    Object? currentParticipants = null,
    Object? imageUrl = freezed,
    Object? location = freezed,
    Object? price = null,
    Object? activities = null,
    Object? creatorId = freezed,
    Object? creatorPhone = freezed,
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
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
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
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      activities: null == activities
          ? _value.activities
          : activities // ignore: cast_nullable_to_non_nullable
              as List<String>,
      creatorId: freezed == creatorId
          ? _value.creatorId
          : creatorId // ignore: cast_nullable_to_non_nullable
              as String?,
      creatorPhone: freezed == creatorPhone
          ? _value.creatorPhone
          : creatorPhone // ignore: cast_nullable_to_non_nullable
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
      DateTime? endDate,
      int durationHours,
      int maxParticipants,
      int currentParticipants,
      String? imageUrl,
      String? location,
      double price,
      List<String> activities,
      String? creatorId,
      String? creatorPhone,
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
    Object? endDate = freezed,
    Object? durationHours = null,
    Object? maxParticipants = null,
    Object? currentParticipants = null,
    Object? imageUrl = freezed,
    Object? location = freezed,
    Object? price = null,
    Object? activities = null,
    Object? creatorId = freezed,
    Object? creatorPhone = freezed,
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
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
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
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      activities: null == activities
          ? _value._activities
          : activities // ignore: cast_nullable_to_non_nullable
              as List<String>,
      creatorId: freezed == creatorId
          ? _value.creatorId
          : creatorId // ignore: cast_nullable_to_non_nullable
              as String?,
      creatorPhone: freezed == creatorPhone
          ? _value.creatorPhone
          : creatorPhone // ignore: cast_nullable_to_non_nullable
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
      this.endDate,
      this.durationHours = 2,
      this.maxParticipants = 20,
      this.currentParticipants = 0,
      this.imageUrl,
      this.location,
      this.price = 0,
      final List<String> activities = const [],
      this.creatorId,
      this.creatorPhone,
      this.createdAt})
      : _activities = activities;

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

  /// Date and time of the event start
  @override
  final DateTime date;

  /// End date and time of the event
  @override
  final DateTime? endDate;

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

  /// Location of the event
  @override
  final String? location;

  /// Price per person
  @override
  @JsonKey()
  final double price;

  /// Activities included in the event
  final List<String> _activities;

  /// Activities included in the event
  @override
  @JsonKey()
  List<String> get activities {
    if (_activities is EqualUnmodifiableListView) return _activities;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_activities);
  }

  /// ID of the event creator
  @override
  final String? creatorId;

  /// Phone number of the event creator
  @override
  final String? creatorPhone;

  /// When the event was created
  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'Event(id: $id, centerId: $centerId, title: $title, description: $description, date: $date, endDate: $endDate, durationHours: $durationHours, maxParticipants: $maxParticipants, currentParticipants: $currentParticipants, imageUrl: $imageUrl, location: $location, price: $price, activities: $activities, creatorId: $creatorId, creatorPhone: $creatorPhone, createdAt: $createdAt)';
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
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.durationHours, durationHours) ||
                other.durationHours == durationHours) &&
            (identical(other.maxParticipants, maxParticipants) ||
                other.maxParticipants == maxParticipants) &&
            (identical(other.currentParticipants, currentParticipants) ||
                other.currentParticipants == currentParticipants) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.price, price) || other.price == price) &&
            const DeepCollectionEquality()
                .equals(other._activities, _activities) &&
            (identical(other.creatorId, creatorId) ||
                other.creatorId == creatorId) &&
            (identical(other.creatorPhone, creatorPhone) ||
                other.creatorPhone == creatorPhone) &&
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
      endDate,
      durationHours,
      maxParticipants,
      currentParticipants,
      imageUrl,
      location,
      price,
      const DeepCollectionEquality().hash(_activities),
      creatorId,
      creatorPhone,
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
      final DateTime? endDate,
      final int durationHours,
      final int maxParticipants,
      final int currentParticipants,
      final String? imageUrl,
      final String? location,
      final double price,
      final List<String> activities,
      final String? creatorId,
      final String? creatorPhone,
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

  /// Date and time of the event start
  DateTime get date;
  @override

  /// End date and time of the event
  DateTime? get endDate;
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

  /// Location of the event
  String? get location;
  @override

  /// Price per person
  double get price;
  @override

  /// Activities included in the event
  List<String> get activities;
  @override

  /// ID of the event creator
  String? get creatorId;
  @override

  /// Phone number of the event creator
  String? get creatorPhone;
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

  /// Phone number of the requester
  String? get phoneNumber => throw _privateConstructorUsedError;

  /// Number of persons (including family/friends)
  int get numberOfPersons => throw _privateConstructorUsedError;

  /// Additional comments
  String? get comments => throw _privateConstructorUsedError;

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
      String? phoneNumber,
      int numberOfPersons,
      String? comments,
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
    Object? phoneNumber = freezed,
    Object? numberOfPersons = null,
    Object? comments = freezed,
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
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      numberOfPersons: null == numberOfPersons
          ? _value.numberOfPersons
          : numberOfPersons // ignore: cast_nullable_to_non_nullable
              as int,
      comments: freezed == comments
          ? _value.comments
          : comments // ignore: cast_nullable_to_non_nullable
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
      String? phoneNumber,
      int numberOfPersons,
      String? comments,
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
    Object? phoneNumber = freezed,
    Object? numberOfPersons = null,
    Object? comments = freezed,
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
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      numberOfPersons: null == numberOfPersons
          ? _value.numberOfPersons
          : numberOfPersons // ignore: cast_nullable_to_non_nullable
              as int,
      comments: freezed == comments
          ? _value.comments
          : comments // ignore: cast_nullable_to_non_nullable
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
      this.phoneNumber,
      this.numberOfPersons = 1,
      this.comments,
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

  /// Phone number of the requester
  @override
  final String? phoneNumber;

  /// Number of persons (including family/friends)
  @override
  @JsonKey()
  final int numberOfPersons;

  /// Additional comments
  @override
  final String? comments;

  /// When the request was made
  @override
  final DateTime? requestedAt;

  @override
  String toString() {
    return 'EventParticipation(id: $id, eventId: $eventId, userId: $userId, userName: $userName, status: $status, message: $message, phoneNumber: $phoneNumber, numberOfPersons: $numberOfPersons, comments: $comments, requestedAt: $requestedAt)';
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
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.numberOfPersons, numberOfPersons) ||
                other.numberOfPersons == numberOfPersons) &&
            (identical(other.comments, comments) ||
                other.comments == comments) &&
            (identical(other.requestedAt, requestedAt) ||
                other.requestedAt == requestedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, eventId, userId, userName,
      status, message, phoneNumber, numberOfPersons, comments, requestedAt);

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
      final String? phoneNumber,
      final int numberOfPersons,
      final String? comments,
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

  /// Phone number of the requester
  String? get phoneNumber;
  @override

  /// Number of persons (including family/friends)
  int get numberOfPersons;
  @override

  /// Additional comments
  String? get comments;
  @override

  /// When the request was made
  DateTime? get requestedAt;
  @override
  @JsonKey(ignore: true)
  _$$EventParticipationImplCopyWith<_$EventParticipationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
