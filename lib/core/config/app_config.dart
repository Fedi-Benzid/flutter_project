class AppConfig {
  // Backend configuration
  static const String baseUrl = 'http://localhost:8080';
  static const String apiPrefix = '/api';

  // API endpoints base paths
  static const String authPath = '$apiPrefix/auth';
  static const String centersPath = '$apiPrefix/centers';
  static const String reservationsPath = '$apiPrefix/reservations';
  static const String marketplacePath = '$apiPrefix/marketplace';
  static const String eventsPath = '$apiPrefix/events';

  // Timeout configuration
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
}
