import 'package:freezed_annotation/freezed_annotation.dart';

part 'center.freezed.dart';
part 'center.g.dart';

/// CampingCenter entity representing a camping location in the system.
///
/// This model contains all information about a camping center including:
/// - Basic information (name, description, location)
/// - Media (photos)
/// - Features (amenities, tags)
/// - Pricing information
/// - Discovery features (isInteresting flag for featured centers)
@freezed
class CampingCenter with _$CampingCenter {
  const factory CampingCenter({
    /// Unique identifier for the center
    required String id,

    /// ID of the owner user
    required String ownerId,

    /// Name of the camping center
    required String name,

    /// Detailed description of the center
    required String description,

    /// Location/address of the center
    required String location,

    /// List of photo URLs for the center
    @Default([]) List<String> photos,

    /// List of amenity codes (e.g., 'wifi', 'shower', 'parking')
    /// See CenterAmenities in constants.dart for available options
    @Default([]) List<String> amenities,

    /// List of tags for categorization and search
    /// (e.g., 'lake', 'mountain', 'family')
    /// See CenterTags in constants.dart for available options
    @Default([]) List<String> tags,

    /// Minimum price per night
    @Default(0) double priceMin,

    /// Maximum price per night
    @Default(0) double priceMax,

    /// Whether this center is featured/interesting
    /// Used for discovery and recommendations
    @Default(false) bool isInteresting,

    /// Average rating from reviews (1-5)
    @Default(0) double averageRating,

    /// Total number of reviews
    @Default(0) int reviewCount,

    /// Geographic latitude for map display
    double? latitude,

    /// Geographic longitude for map display
    double? longitude,

    /// When the center was created
    DateTime? createdAt,
  }) = _CampingCenter;

  factory CampingCenter.fromJson(Map<String, dynamic> json) =>
      _$CampingCenterFromJson(json);
}
