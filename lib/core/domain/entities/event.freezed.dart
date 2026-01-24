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

  /// Name of the center where the event takes place
  String? get centerName => throw _privateConstructorUsedError;

  /// First name of the event owner
  String? get ownerFirstName => throw _privateConstructorUsedError;

  /// Last name of the event owner
  String? get ownerLastName => throw _privateConstructorUsedError;

  /// Phone number of the event owner
  String? get ownerPhoneNumber => throw _privateConstructorUsedError;

  /// When the event was created
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Whether the event is closed for new requests
  bool get isClosed => throw _privateConstructorUsedError;

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
      String? centerName,
      String? ownerFirstName,
      String? ownerLastName,
      String? ownerPhoneNumber,
      DateTime? createdAt,
      bool isClosed});
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
    Object? centerName = freezed,
    Object? ownerFirstName = freezed,
    Object? ownerLastName = freezed,
    Object? ownerPhoneNumber = freezed,
    Object? createdAt = freezed,
    Object? isClosed = null,
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
      centerName: freezed == centerName
          ? _value.centerName
          : centerName // ignore: cast_nullable_to_non_nullable
              as String?,
      ownerFirstName: freezed == ownerFirstName
          ? _value.ownerFirstName
          : ownerFirstName // ignore: cast_nullable_to_non_nullable
              as String?,
      ownerLastName: freezed == ownerLastName
          ? _value.ownerLastName
          : ownerLastName // ignore: cast_nullable_to_non_nullable
              as String?,
      ownerPhoneNumber: freezed == ownerPhoneNumber
          ? _value.ownerPhoneNumber
          : ownerPhoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isClosed: null == isClosed
          ? _value.isClosed
          : isClosed // ignore: cast_nullable_to_non_nullable
              as bool,
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
      String? centerName,
      String? ownerFirstName,
      String? ownerLastName,
      String? ownerPhoneNumber,
      DateTime? createdAt,
      bool isClosed});
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
    Object? centerName = freezed,
    Object? ownerFirstName = freezed,
    Object? ownerLastName = freezed,
    Object? ownerPhoneNumber = freezed,
    Object? createdAt = freezed,
    Object? isClosed = null,
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
      centerName: freezed == centerName
          ? _value.centerName
          : centerName // ignore: cast_nullable_to_non_nullable
              as String?,
      ownerFirstName: freezed == ownerFirstName
          ? _value.ownerFirstName
          : ownerFirstName // ignore: cast_nullable_to_non_nullable
              as String?,
      ownerLastName: freezed == ownerLastName
          ? _value.ownerLastName
          : ownerLastName // ignore: cast_nullable_to_non_nullable
              as String?,
      ownerPhoneNumber: freezed == ownerPhoneNumber
          ? _value.ownerPhoneNumber
          : ownerPhoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isClosed: null == isClosed
          ? _value.isClosed
          : isClosed // ignore: cast_nullable_to_non_nullable
              as bool,
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
      this.centerName,
      this.ownerFirstName,
      this.ownerLastName,
      this.ownerPhoneNumber,
      this.createdAt,
      this.isClosed = false})
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

  /// Name of the center where the event takes place
  @override
  final String? centerName;

  /// First name of the event owner
  @override
  final String? ownerFirstName;

  /// Last name of the event owner
  @override
  final String? ownerLastName;

  /// Phone number of the event owner
  @override
  final String? ownerPhoneNumber;

  /// When the event was created
  @override
  final DateTime? createdAt;

  /// Whether the event is closed for new requests
  @override
  @JsonKey()
  final bool isClosed;

  @override
  String toString() {
    return 'Event(id: $id, centerId: $centerId, title: $title, description: $description, date: $date, endDate: $endDate, durationHours: $durationHours, maxParticipants: $maxParticipants, currentParticipants: $currentParticipants, imageUrl: $imageUrl, location: $location, price: $price, activities: $activities, creatorId: $creatorId, creatorPhone: $creatorPhone, centerName: $centerName, ownerFirstName: $ownerFirstName, ownerLastName: $ownerLastName, ownerPhoneNumber: $ownerPhoneNumber, createdAt: $createdAt, isClosed: $isClosed)';
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
            (identical(other.centerName, centerName) ||
                other.centerName == centerName) &&
            (identical(other.ownerFirstName, ownerFirstName) ||
                other.ownerFirstName == ownerFirstName) &&
            (identical(other.ownerLastName, ownerLastName) ||
                other.ownerLastName == ownerLastName) &&
            (identical(other.ownerPhoneNumber, ownerPhoneNumber) ||
                other.ownerPhoneNumber == ownerPhoneNumber) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.isClosed, isClosed) ||
                other.isClosed == isClosed));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
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
        centerName,
        ownerFirstName,
        ownerLastName,
        ownerPhoneNumber,
        createdAt,
        isClosed
      ]);

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
      final String? centerName,
      final String? ownerFirstName,
      final String? ownerLastName,
      final String? ownerPhoneNumber,
      final DateTime? createdAt,
      final bool isClosed}) = _$EventImpl;

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

  /// Name of the center where the event takes place
  String? get centerName;
  @override

  /// First name of the event owner
  String? get ownerFirstName;
  @override

  /// Last name of the event owner
  String? get ownerLastName;
  @override

  /// Phone number of the event owner
  String? get ownerPhoneNumber;
  @override

  /// When the event was created
  DateTime? get createdAt;
  @override

  /// Whether the event is closed for new requests
  bool get isClosed;
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

  /// Email of the requester
  String? get userEmail => throw _privateConstructorUsedError;

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
      String? userEmail,
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
    Object? userEmail = freezed,
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
      userEmail: freezed == userEmail
          ? _value.userEmail
          : userEmail // ignore: cast_nullable_to_non_nullable
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
      String? userEmail,
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
    Object? userEmail = freezed,
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
      userEmail: freezed == userEmail
          ? _value.userEmail
          : userEmail // ignore: cast_nullable_to_non_nullable
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
      this.userEmail,
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

  /// Email of the requester
  @override
  final String? userEmail;

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
    return 'EventParticipation(id: $id, eventId: $eventId, userId: $userId, userName: $userName, status: $status, message: $message, phoneNumber: $phoneNumber, userEmail: $userEmail, numberOfPersons: $numberOfPersons, comments: $comments, requestedAt: $requestedAt)';
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
            (identical(other.userEmail, userEmail) ||
                other.userEmail == userEmail) &&
            (identical(other.numberOfPersons, numberOfPersons) ||
                other.numberOfPersons == numberOfPersons) &&
            (identical(other.comments, comments) ||
                other.comments == comments) &&
            (identical(other.requestedAt, requestedAt) ||
                other.requestedAt == requestedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      eventId,
      userId,
      userName,
      status,
      message,
      phoneNumber,
      userEmail,
      numberOfPersons,
      comments,
      requestedAt);

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
      final String? userEmail,
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

  /// Email of the requester
  String? get userEmail;
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

EventRating _$EventRatingFromJson(Map<String, dynamic> json) {
  return _EventRating.fromJson(json);
}

/// @nodoc
mixin _$EventRating {
  /// Unique identifier
  String get id => throw _privateConstructorUsedError;

  /// ID of the event
  String get eventId => throw _privateConstructorUsedError;

  /// ID of the user who rated
  String get userId => throw _privateConstructorUsedError;

  /// Name of the user (denormalized for display)
  String? get userName => throw _privateConstructorUsedError;

  /// Rating value (1-5)
  int get rating => throw _privateConstructorUsedError;

  /// Optional comment
  String? get comment => throw _privateConstructorUsedError;

  /// When the rating was created
  DateTime? get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EventRatingCopyWith<EventRating> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventRatingCopyWith<$Res> {
  factory $EventRatingCopyWith(
          EventRating value, $Res Function(EventRating) then) =
      _$EventRatingCopyWithImpl<$Res, EventRating>;
  @useResult
  $Res call(
      {String id,
      String eventId,
      String userId,
      String? userName,
      int rating,
      String? comment,
      DateTime? createdAt});
}

/// @nodoc
class _$EventRatingCopyWithImpl<$Res, $Val extends EventRating>
    implements $EventRatingCopyWith<$Res> {
  _$EventRatingCopyWithImpl(this._value, this._then);

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
    Object? userName = freezed,
    Object? rating = null,
    Object? comment = freezed,
    Object? createdAt = freezed,
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
      userName: freezed == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String?,
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as int,
      comment: freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EventRatingImplCopyWith<$Res>
    implements $EventRatingCopyWith<$Res> {
  factory _$$EventRatingImplCopyWith(
          _$EventRatingImpl value, $Res Function(_$EventRatingImpl) then) =
      __$$EventRatingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String eventId,
      String userId,
      String? userName,
      int rating,
      String? comment,
      DateTime? createdAt});
}

/// @nodoc
class __$$EventRatingImplCopyWithImpl<$Res>
    extends _$EventRatingCopyWithImpl<$Res, _$EventRatingImpl>
    implements _$$EventRatingImplCopyWith<$Res> {
  __$$EventRatingImplCopyWithImpl(
      _$EventRatingImpl _value, $Res Function(_$EventRatingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? eventId = null,
    Object? userId = null,
    Object? userName = freezed,
    Object? rating = null,
    Object? comment = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$EventRatingImpl(
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
      userName: freezed == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String?,
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as int,
      comment: freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
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
class _$EventRatingImpl implements _EventRating {
  const _$EventRatingImpl(
      {required this.id,
      required this.eventId,
      required this.userId,
      this.userName,
      required this.rating,
      this.comment,
      this.createdAt});

  factory _$EventRatingImpl.fromJson(Map<String, dynamic> json) =>
      _$$EventRatingImplFromJson(json);

  /// Unique identifier
  @override
  final String id;

  /// ID of the event
  @override
  final String eventId;

  /// ID of the user who rated
  @override
  final String userId;

  /// Name of the user (denormalized for display)
  @override
  final String? userName;

  /// Rating value (1-5)
  @override
  final int rating;

  /// Optional comment
  @override
  final String? comment;

  /// When the rating was created
  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'EventRating(id: $id, eventId: $eventId, userId: $userId, userName: $userName, rating: $rating, comment: $comment, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EventRatingImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.eventId, eventId) || other.eventId == eventId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.comment, comment) || other.comment == comment) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, eventId, userId, userName, rating, comment, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EventRatingImplCopyWith<_$EventRatingImpl> get copyWith =>
      __$$EventRatingImplCopyWithImpl<_$EventRatingImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EventRatingImplToJson(
      this,
    );
  }
}

abstract class _EventRating implements EventRating {
  const factory _EventRating(
      {required final String id,
      required final String eventId,
      required final String userId,
      final String? userName,
      required final int rating,
      final String? comment,
      final DateTime? createdAt}) = _$EventRatingImpl;

  factory _EventRating.fromJson(Map<String, dynamic> json) =
      _$EventRatingImpl.fromJson;

  @override

  /// Unique identifier
  String get id;
  @override

  /// ID of the event
  String get eventId;
  @override

  /// ID of the user who rated
  String get userId;
  @override

  /// Name of the user (denormalized for display)
  String? get userName;
  @override

  /// Rating value (1-5)
  int get rating;
  @override

  /// Optional comment
  String? get comment;
  @override

  /// When the rating was created
  DateTime? get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$EventRatingImplCopyWith<_$EventRatingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
