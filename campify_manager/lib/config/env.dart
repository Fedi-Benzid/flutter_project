/// Environment configuration for Campify Manager.
///
/// This class manages app-wide configuration including:
/// - Demo mode toggle (uses mock server vs real API)
/// - API base URL configuration
/// - Feature flags
///
/// To switch from demo to production mode:
/// 1. Set [useDemoMode] to false
/// 2. Update [apiBaseUrl] to your backend URL
library;

class AppConfig {
  /// Private constructor to prevent instantiation
  AppConfig._();

  /// Whether the app is running in demo mode.
  /// When true, all API calls are intercepted by the mock server.
  /// Set to false and update [apiBaseUrl] to connect to a real backend.
  static const bool useDemoMode = true;

  /// Base URL for the API.
  /// In demo mode, this is ignored as requests go to the mock server.
  /// For production, update this to your actual backend URL.
  static const String apiBaseUrl = 'https://api.campify.example.com';

  /// API version prefix
  static const String apiVersion = '/api/v1';

  /// Full API URL
  static String get fullApiUrl => '$apiBaseUrl$apiVersion';

  /// Request timeout in milliseconds
  static const int requestTimeout = 30000;

  /// Simulated network delay in demo mode (milliseconds)
  static const int mockNetworkDelay = 500;

  /// App name
  static const String appName = 'Campify Manager';

  /// App version
  static const String appVersion = '1.0.0';

  /// Feature flags
  static const bool enableOnboarding = true;
  static const bool enablePayments = true;
  static const bool enableEvents = true;

  /// Demo account credentials (for display purposes)
  static const String demoOwnerEmail = 'owner@example.com';
  static const String demoCamperEmail = 'camper@example.com';
  static const String demoPassword = 'password123';
}
