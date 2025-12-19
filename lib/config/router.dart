import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/auth/presentation/providers/auth_provider.dart';
import '../features/auth/presentation/screens/login_screen.dart';
import '../features/auth/presentation/screens/register_screen.dart';
import '../features/auth/presentation/screens/profile_screen.dart';
import '../features/auth/presentation/screens/forgot_password_screen.dart';
import '../features/auth/presentation/screens/verify_code_screen.dart';
import '../features/auth/presentation/screens/reset_password_screen.dart';
import '../features/centers/presentation/screens/home_screen.dart';
import '../features/centers/presentation/screens/center_detail_screen.dart';
import '../features/centers/presentation/screens/center_form_screen.dart';
import '../features/centers/presentation/screens/owner_dashboard_screen.dart';
import '../features/marketplace/presentation/screens/marketplace_screen.dart';
import '../features/marketplace/presentation/screens/item_detail_screen.dart';
import '../features/marketplace/presentation/screens/cart_screen.dart';
import '../features/marketplace/presentation/screens/checkout_screen.dart';
import '../features/reservations/presentation/screens/reservation_calendar_screen.dart';
import '../features/reservations/presentation/screens/booking_flow_screen.dart';
import '../features/reservations/presentation/screens/my_reservations_screen.dart';
import '../features/events/presentation/screens/events_screen.dart';
import '../features/events/presentation/screens/event_detail_screen.dart';
import '../features/events/presentation/screens/event_form_screen.dart';
import '../shared/widgets/app_shell.dart';

/// Route paths used throughout the app.
class AppRoutes {
  AppRoutes._();

  // Auth routes
  static const String login = '/login';
  static const String register = '/register';
  static const String profile = '/profile';
  static const String forgotPassword = '/forgot-password';
  static const String verifyCode = '/verify-code';
  static const String resetPassword = '/reset-password';

  // Main routes
  static const String home = '/';
  static const String centerDetail = '/centers/:id';
  static const String centerForm = '/centers/form';
  static const String ownerDashboard = '/owner';

  // Marketplace routes
  static const String marketplace = '/marketplace';
  static const String itemDetail = '/items/:id';
  static const String cart = '/cart';
  static const String checkout = '/checkout';

  // Reservation routes
  static const String reservations = '/reservations';
  static const String reservationCalendar = '/reserve/:centerId';
  static const String bookingFlow = '/booking/:centerId';

  // Event routes
  static const String events = '/events';
  static const String eventDetail = '/events/:id';
  static const String eventForm = '/events/form';

  // Helper methods for dynamic routes
  static String centerDetailPath(String id) => '/centers/$id';
  static String itemDetailPath(String id) => '/items/$id';
  static String reservationCalendarPath(String centerId) => '/reserve/$centerId';
  static String bookingFlowPath(String centerId) => '/booking/$centerId';
  static String eventDetailPath(String id) => '/events/$id';
}

/// Provider for the GoRouter instance.
final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: AppRoutes.home,
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final isLoggedIn = authState.maybeWhen(
        authenticated: (_) => true,
        orElse: () => false,
      );

      final isLoggingIn = state.matchedLocation == AppRoutes.login;
      final isRegistering = state.matchedLocation == AppRoutes.register;
      final isForgotPassword = state.matchedLocation == AppRoutes.forgotPassword;
      final isVerifyingCode = state.matchedLocation == AppRoutes.verifyCode;
      final isResettingPassword = state.matchedLocation == AppRoutes.resetPassword;

      // If not logged in and not on auth pages, redirect to login
      if (!isLoggedIn && !isLoggingIn && !isRegistering && !isForgotPassword && !isVerifyingCode && !isResettingPassword) {
        return AppRoutes.login;
      }

      // If logged in and on login page, redirect to home
      if (isLoggedIn && (isLoggingIn || isRegistering)) {
        return AppRoutes.home;
      }

      return null;
    },
    routes: [
      // Auth routes (no shell)
      GoRoute(
        path: AppRoutes.login,
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.register,
        name: 'register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: AppRoutes.forgotPassword,
        name: 'forgotPassword',
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: AppRoutes.verifyCode,
        name: 'verifyCode',
        builder: (context, state) {
          final email = state.extra as String? ?? '';
          return VerifyCodeScreen(email: email);
        },
      ),
      GoRoute(
        path: AppRoutes.resetPassword,
        name: 'resetPassword',
        builder: (context, state) {
          final data = state.extra as Map<String, dynamic>? ?? {};
          return ResetPasswordScreen(
            email: data['email'] as String? ?? '',
            code: data['code'] as String? ?? '',
          );
        },
      ),

      // Main app with shell (bottom navigation)
      ShellRoute(
        builder: (context, state, child) => AppShell(child: child),
        routes: [
          // Home / Centers
          GoRoute(
            path: AppRoutes.home,
            name: 'home',
            builder: (context, state) => const HomeScreen(),
            routes: [
              GoRoute(
                path: 'centers/:id',
                name: 'centerDetail',
                builder: (context, state) {
                  final centerId = state.pathParameters['id']!;
                  return CenterDetailScreen(centerId: centerId);
                },
              ),
            ],
          ),

          // Marketplace
          GoRoute(
            path: AppRoutes.marketplace,
            name: 'marketplace',
            builder: (context, state) => const MarketplaceScreen(),
            routes: [
              GoRoute(
                path: 'items/:id',
                name: 'itemDetail',
                builder: (context, state) {
                  final itemId = state.pathParameters['id']!;
                  return ItemDetailScreen(itemId: itemId);
                },
              ),
            ],
          ),

          // Events
          GoRoute(
            path: AppRoutes.events,
            name: 'events',
            builder: (context, state) => const EventsScreen(),
            routes: [
              GoRoute(
                path: ':id',
                name: 'eventDetail',
                builder: (context, state) {
                  final eventId = state.pathParameters['id']!;
                  return EventDetailScreen(eventId: eventId);
                },
              ),
            ],
          ),

          // Reservations
          GoRoute(
            path: AppRoutes.reservations,
            name: 'reservations',
            builder: (context, state) => const MyReservationsScreen(),
          ),

          // Profile
          GoRoute(
            path: AppRoutes.profile,
            name: 'profile',
            builder: (context, state) => const ProfileScreen(),
          ),
        ],
      ),

      // Routes outside shell (full screen)
      GoRoute(
        path: '/centers/form',
        name: 'centerForm',
        builder: (context, state) {
          final centerId = state.uri.queryParameters['id'];
          return CenterFormScreen(centerId: centerId);
        },
      ),
      GoRoute(
        path: AppRoutes.ownerDashboard,
        name: 'ownerDashboard',
        builder: (context, state) => const OwnerDashboardScreen(),
      ),
      GoRoute(
        path: AppRoutes.cart,
        name: 'cart',
        builder: (context, state) => const CartScreen(),
      ),
      GoRoute(
        path: AppRoutes.checkout,
        name: 'checkout',
        builder: (context, state) => const CheckoutScreen(),
      ),
      GoRoute(
        path: '/reserve/:centerId',
        name: 'reservationCalendar',
        builder: (context, state) {
          final centerId = state.pathParameters['centerId']!;
          return ReservationCalendarScreen(centerId: centerId);
        },
      ),
      GoRoute(
        path: '/booking/:centerId',
        name: 'bookingFlow',
        builder: (context, state) {
          final centerId = state.pathParameters['centerId']!;
          final startDate = state.uri.queryParameters['start'];
          final endDate = state.uri.queryParameters['end'];
          return BookingFlowScreen(
            centerId: centerId,
            startDate: startDate != null ? DateTime.parse(startDate) : null,
            endDate: endDate != null ? DateTime.parse(endDate) : null,
          );
        },
      ),
      GoRoute(
        path: '/events/form',
        name: 'eventForm',
        builder: (context, state) {
          final eventId = state.uri.queryParameters['id'];
          return EventFormScreen(eventId: eventId);
        },
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'Page not found',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(state.uri.toString()),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go(AppRoutes.home),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    ),
  );
});
