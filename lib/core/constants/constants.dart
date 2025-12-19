/// Application constants used throughout the app.
///
/// These constants provide centralized configuration for:
/// - Storage keys
/// - API endpoints
/// - UI constants
/// - Validation rules
library;

/// Keys for secure storage
class StorageKeys {
  StorageKeys._();

  static const String authToken = 'auth_token';
  static const String refreshToken = 'refresh_token';
  static const String userId = 'user_id';
  static const String userRole = 'user_role';
}

/// Hive box names for local storage
class HiveBoxes {
  HiveBoxes._();

  static const String users = 'users';
  static const String centers = 'centers';
  static const String items = 'items';
  static const String reservations = 'reservations';
  static const String events = 'events';
  static const String reviews = 'reviews';
  static const String cart = 'cart';
  static const String orders = 'orders';
  static const String participations = 'participations';
}

/// API endpoint paths
class ApiEndpoints {
  ApiEndpoints._();

  // Auth
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String logout = '/auth/logout';
  static const String resetPassword = '/auth/reset-password';
  static const String profile = '/auth/profile';
  static const String uploadAvatar = '/auth/avatar';

  // Users
  static const String users = '/users';

  // Centers
  static const String centers = '/centers';
  static String centerById(String id) => '/centers/$id';
  static String centerReviews(String id) => '/centers/$id/reviews';
  static String centerItems(String id) => '/centers/$id/items';

  // Items
  static const String items = '/items';
  static String itemById(String id) => '/items/$id';

  // Reservations
  static const String reservations = '/reservations';
  static String reservationById(String id) => '/reservations/$id';
  static String reservationStatus(String id) => '/reservations/$id/status';

  // Orders
  static const String orders = '/orders';
  static String orderById(String id) => '/orders/$id';
  static const String checkout = '/orders/checkout';

  // Events
  static const String events = '/events';
  static String eventById(String id) => '/events/$id';
  static String eventParticipants(String id) => '/events/$id/participants';
  static String participationStatus(String eventId, String participationId) =>
      '/events/$eventId/participants/$participationId';

  // Reviews
  static const String reviews = '/reviews';
  static String reviewById(String id) => '/reviews/$id';
}

/// UI-related constants
class UIConstants {
  UIConstants._();

  // Animation durations
  static const Duration animationFast = Duration(milliseconds: 200);
  static const Duration animationNormal = Duration(milliseconds: 300);
  static const Duration animationSlow = Duration(milliseconds: 500);

  // Grid layout
  static const int gridCrossAxisCount = 2;
  static const double gridChildAspectRatio = 0.75;
  static const double gridSpacing = 16;

  // Image sizes
  static const double avatarSizeSmall = 40;
  static const double avatarSizeMedium = 64;
  static const double avatarSizeLarge = 120;

  // Card heights
  static const double cardHeightSmall = 100;
  static const double cardHeightMedium = 200;
  static const double cardHeightLarge = 300;

  // Max width for responsive layout
  static const double maxContentWidth = 600;
  static const double tabletBreakpoint = 768;
  static const double desktopBreakpoint = 1200;
}

/// Validation constants
class ValidationConstants {
  ValidationConstants._();

  static const int minPasswordLength = 6;
  static const int maxPasswordLength = 50;
  static const int minNameLength = 2;
  static const int maxNameLength = 100;
  static const int maxDescriptionLength = 1000;
  static const int maxReviewLength = 500;
  static const int minRating = 1;
  static const int maxRating = 5;
  static const int maxEventCapacity = 1000;
  static const int minRentalDays = 1;
  static const int maxRentalDays = 30;
}

/// Center tags for filtering
class CenterTags {
  CenterTags._();

  static const String lake = 'lake';
  static const String mountain = 'mountain';
  static const String forest = 'forest';
  static const String beach = 'beach';
  static const String family = 'family';
  static const String petFriendly = 'pet-friendly';
  static const String glamping = 'glamping';
  static const String hiking = 'hiking';
  static const String fishing = 'fishing';
  static const String campfire = 'campfire';

  static const List<String> all = [
    lake,
    mountain,
    forest,
    beach,
    family,
    petFriendly,
    glamping,
    hiking,
    fishing,
    campfire,
  ];

  static String displayName(String tag) {
    switch (tag) {
      case lake:
        return 'Lake';
      case mountain:
        return 'Mountain';
      case forest:
        return 'Forest';
      case beach:
        return 'Beach';
      case family:
        return 'Family Friendly';
      case petFriendly:
        return 'Pet Friendly';
      case glamping:
        return 'Glamping';
      case hiking:
        return 'Hiking';
      case fishing:
        return 'Fishing';
      case campfire:
        return 'Campfire';
      default:
        return tag;
    }
  }
}

/// Center amenities
class CenterAmenities {
  CenterAmenities._();

  static const String wifi = 'wifi';
  static const String shower = 'shower';
  static const String toilet = 'toilet';
  static const String electricity = 'electricity';
  static const String water = 'water';
  static const String parking = 'parking';
  static const String bbq = 'bbq';
  static const String playground = 'playground';
  static const String store = 'store';
  static const String laundry = 'laundry';

  static const List<String> all = [
    wifi,
    shower,
    toilet,
    electricity,
    water,
    parking,
    bbq,
    playground,
    store,
    laundry,
  ];

  static String displayName(String amenity) {
    switch (amenity) {
      case wifi:
        return 'Wi-Fi';
      case shower:
        return 'Showers';
      case toilet:
        return 'Toilets';
      case electricity:
        return 'Electricity';
      case water:
        return 'Water';
      case parking:
        return 'Parking';
      case bbq:
        return 'BBQ Area';
      case playground:
        return 'Playground';
      case store:
        return 'Store';
      case laundry:
        return 'Laundry';
      default:
        return amenity;
    }
  }
}
