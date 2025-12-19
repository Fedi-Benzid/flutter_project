import 'dart:async';
import '../config/env.dart';
import '../core/domain/entities/entities.dart';
import 'mock_data.dart';

/// Mock server that simulates a REST API for demo mode.
///
/// This class provides an in-memory database with all CRUD operations.
/// It's used when [AppConfig.useDemoMode] is true, allowing the app
/// to function without a real backend.
///
/// To switch to a real backend:
/// 1. Set [AppConfig.useDemoMode] to false
/// 2. Implement real API clients in the repository layer
class MockServer {
  MockServer._();
  static final MockServer instance = MockServer._();

  // In-memory storage
  final Map<String, User> _users = {};
  final Map<String, CampingCenter> _centers = {};
  final Map<String, MarketplaceItem> _items = {};
  final Map<String, Reservation> _reservations = {};
  final Map<String, Event> _events = {};
  final Map<String, Review> _reviews = {};
  final Map<String, Order> _orders = {};
  final Map<String, EventParticipation> _participations = {};
  final Map<String, List<CartItem>> _carts = {}; // userId -> cart items

  // Current authenticated user
  String? _currentUserId;
  String? _currentAuthToken;

  bool _initialized = false;

  /// Initialize the mock server with seed data.
  Future<void> initialize() async {
    if (_initialized) return;

    // Load seed data
    for (final user in MockData.users) {
      _users[user.id] = user;
    }
    for (final center in MockData.centers) {
      _centers[center.id] = center;
    }
    for (final item in MockData.items) {
      _items[item.id] = item;
    }
    for (final event in MockData.events) {
      _events[event.id] = event;
    }
    for (final review in MockData.reviews) {
      _reviews[review.id] = review;
    }
    for (final reservation in MockData.reservations) {
      _reservations[reservation.id] = reservation;
    }
    for (final order in MockData.orders) {
      _orders[order.id] = order;
    }
    for (final participation in MockData.participations) {
      _participations[participation.id] = participation;
    }

    _initialized = true;
  }

  /// Simulate network delay for realistic behavior.
  Future<void> _simulateDelay() async {
    await Future.delayed(Duration(milliseconds: AppConfig.mockNetworkDelay));
  }

  // ============= AUTH ENDPOINTS =============

  /// POST /auth/login
  Future<Map<String, dynamic>> login(String email, String password) async {
    await _simulateDelay();

    // Find user by email (password check is mocked - always accepts 'password123')
    final user = _users.values.firstWhere(
      (u) => u.email.toLowerCase() == email.toLowerCase(),
      orElse: () => throw MockServerException(401, 'Invalid email or password'),
    );

    if (password != 'password123') {
      throw MockServerException(401, 'Invalid email or password');
    }

    // Generate mock token
    _currentUserId = user.id;
    _currentAuthToken = 'mock_token_${user.id}_${DateTime.now().millisecondsSinceEpoch}';

    return {'user': user.toJson(), 'token': _currentAuthToken};
  }

  /// POST /auth/register
  Future<Map<String, dynamic>> register({
    required String email,
    required String password,
    required String name,
    required UserRole role,
  }) async {
    await _simulateDelay();

    // Check if email already exists
    if (_users.values.any(
      (u) => u.email.toLowerCase() == email.toLowerCase(),
    )) {
      throw MockServerException(409, 'Email already registered');
    }

    final user = User(
      id: 'user-${DateTime.now().millisecondsSinceEpoch}',
      email: email,
      name: name,
      role: role,
      createdAt: DateTime.now(),
    );

    _users[user.id] = user;
    _currentUserId = user.id;
    _currentAuthToken = 'mock_token_${user.id}_${DateTime.now().millisecondsSinceEpoch}';

    return {'user': user.toJson(), 'token': _currentAuthToken};
  }

  /// POST /auth/logout
  Future<void> logout() async {
    await _simulateDelay();
    _currentUserId = null;
    _currentAuthToken = null;
  }

  /// GET /auth/profile
  Future<User> getProfile() async {
    await _simulateDelay();
    _checkAuth();
    return _users[_currentUserId]!;
  }

  /// PUT /auth/profile
  Future<User> updateProfile({
    String? name,
    String? phone,
    String? avatarUrl,
    DateTime? createdAt,
  }) async {
    await _simulateDelay();
    _checkAuth();

    final current = _users[_currentUserId]!;
    final updated = current.copyWith(
      name: name ?? current.name,
      phone: phone ?? current.phone,
      avatarUrl: avatarUrl ?? current.avatarUrl,
      createdAt: createdAt ?? current.createdAt,
    );

    _users[_currentUserId!] = updated;
    return updated;
  }

  /// POST /auth/reset-password
  Future<void> resetPassword(String email) async {
    await _simulateDelay();
    // In demo mode, just pretend we sent an email
    if (!_users.values.any(
      (u) => u.email.toLowerCase() == email.toLowerCase(),
    )) {
      // Don't reveal if email exists or not for security
    }
  }

  // ============= CENTERS ENDPOINTS =============

  /// GET /centers
  Future<List<CampingCenter>> getCenters({
    String? search,
    List<String>? tags,
    bool? isInteresting,
  }) async {
    await _simulateDelay();

    var results = _centers.values.toList();

    if (search != null && search.isNotEmpty) {
      final query = search.toLowerCase();
      results = results
          .where(
            (c) => c.name.toLowerCase().contains(query) || c.location.toLowerCase().contains(query) || c.description.toLowerCase().contains(query),
          )
          .toList();
    }

    if (tags != null && tags.isNotEmpty) {
      results = results.where((c) => tags.any((tag) => c.tags.contains(tag))).toList();
    }

    if (isInteresting == true) {
      results = results.where((c) => c.isInteresting).toList();
    }

    return results;
  }

  /// GET /centers/:id
  Future<CampingCenter> getCenter(String id) async {
    await _simulateDelay();
    final center = _centers[id];
    if (center == null) {
      throw MockServerException(404, 'Center not found');
    }
    return center;
  }

  /// POST /centers
  Future<CampingCenter> createCenter(CampingCenter center) async {
    await _simulateDelay();
    _checkAuth();
    _checkOwner();

    final newCenter = center.copyWith(
      id: 'center-${DateTime.now().millisecondsSinceEpoch}',
      ownerId: _currentUserId!,
      createdAt: DateTime.now(),
    );

    _centers[newCenter.id] = newCenter;
    return newCenter;
  }

  /// PUT /centers/:id
  Future<CampingCenter> updateCenter(String id, CampingCenter center) async {
    await _simulateDelay();
    _checkAuth();

    final existing = _centers[id];
    if (existing == null) {
      throw MockServerException(404, 'Center not found');
    }
    if (existing.ownerId != _currentUserId) {
      throw MockServerException(403, 'Not authorized to update this center');
    }

    final updated = center.copyWith(id: id, ownerId: existing.ownerId);
    _centers[id] = updated;
    return updated;
  }

  /// DELETE /centers/:id
  Future<void> deleteCenter(String id) async {
    await _simulateDelay();
    _checkAuth();

    final center = _centers[id];
    if (center == null) {
      throw MockServerException(404, 'Center not found');
    }
    if (center.ownerId != _currentUserId) {
      throw MockServerException(403, 'Not authorized to delete this center');
    }

    _centers.remove(id);
  }

  /// GET /centers/:id/reviews
  Future<List<Review>> getCenterReviews(String centerId) async {
    await _simulateDelay();
    return _reviews.values.where((r) => r.centerId == centerId).toList();
  }

  // ============= ITEMS ENDPOINTS =============

  /// GET /items
  Future<List<MarketplaceItem>> getItems({
    String? centerId,
    ItemCategory? category,
  }) async {
    await _simulateDelay();

    var results = _items.values.toList();

    if (centerId != null) {
      results = results.where((i) => i.centerId == centerId).toList();
    }

    if (category != null) {
      results = results.where((i) => i.category == category).toList();
    }

    return results;
  }

  /// GET /items/:id
  Future<MarketplaceItem> getItem(String id) async {
    await _simulateDelay();
    final item = _items[id];
    if (item == null) {
      throw MockServerException(404, 'Item not found');
    }
    return item;
  }

  /// POST /items
  Future<MarketplaceItem> createItem(MarketplaceItem item) async {
    await _simulateDelay();
    _checkAuth();
    _checkOwner();

    final newItem = item.copyWith(
      id: 'item-${DateTime.now().millisecondsSinceEpoch}',
      createdAt: DateTime.now(),
    );

    _items[newItem.id] = newItem;
    return newItem;
  }

  /// PUT /items/:id
  Future<MarketplaceItem> updateItem(String id, MarketplaceItem item) async {
    await _simulateDelay();
    _checkAuth();

    if (!_items.containsKey(id)) {
      throw MockServerException(404, 'Item not found');
    }

    final updated = item.copyWith(id: id);
    _items[id] = updated;
    return updated;
  }

  /// DELETE /items/:id
  Future<void> deleteItem(String id) async {
    await _simulateDelay();
    _checkAuth();

    if (!_items.containsKey(id)) {
      throw MockServerException(404, 'Item not found');
    }

    _items.remove(id);
  }

  // ============= CART ENDPOINTS =============

  /// GET /cart
  Future<List<CartItem>> getCart() async {
    await _simulateDelay();
    _checkAuth();
    return _carts[_currentUserId] ?? [];
  }

  /// POST /cart
  Future<List<CartItem>> addToCart(CartItem cartItem) async {
    await _simulateDelay();
    _checkAuth();

    final cart = _carts[_currentUserId] ?? [];

    // Check if item already in cart
    final existingIndex = cart.indexWhere((c) => c.item.id == cartItem.item.id);
    if (existingIndex >= 0) {
      cart[existingIndex] = cartItem.copyWith(
        quantity: cart[existingIndex].quantity + cartItem.quantity,
      );
    } else {
      cart.add(cartItem);
    }

    _carts[_currentUserId!] = cart;
    return cart;
  }

  /// PUT /cart/:itemId
  Future<List<CartItem>> updateCartItem(
    String itemId,
    CartItem cartItem,
  ) async {
    await _simulateDelay();
    _checkAuth();

    final cart = _carts[_currentUserId] ?? [];
    final index = cart.indexWhere((c) => c.item.id == itemId);

    if (index >= 0) {
      cart[index] = cartItem;
      _carts[_currentUserId!] = cart;
    }

    return cart;
  }

  /// DELETE /cart/:itemId
  Future<List<CartItem>> removeFromCart(String itemId) async {
    await _simulateDelay();
    _checkAuth();

    final cart = _carts[_currentUserId] ?? [];
    cart.removeWhere((c) => c.item.id == itemId);
    _carts[_currentUserId!] = cart;

    return cart;
  }

  /// DELETE /cart
  Future<void> clearCart() async {
    await _simulateDelay();
    _checkAuth();
    _carts[_currentUserId!] = [];
  }

  // ============= RESERVATIONS ENDPOINTS =============

  /// GET /reservations
  Future<List<Reservation>> getReservations({bool? ownerView}) async {
    await _simulateDelay();
    _checkAuth();

    if (ownerView == true) {
      // Get reservations for centers owned by current user
      final ownedCenterIds = _centers.values.where((c) => c.ownerId == _currentUserId).map((c) => c.id).toSet();
      return _reservations.values.where((r) => ownedCenterIds.contains(r.centerId)).toList();
    }

    // Get user's own reservations
    return _reservations.values.where((r) => r.userId == _currentUserId).toList();
  }

  /// GET /reservations/:id
  Future<Reservation> getReservation(String id) async {
    await _simulateDelay();
    _checkAuth();

    final reservation = _reservations[id];
    if (reservation == null) {
      throw MockServerException(404, 'Reservation not found');
    }
    return reservation;
  }

  /// POST /reservations
  Future<Reservation> createReservation(Reservation reservation) async {
    await _simulateDelay();
    _checkAuth();

    final newReservation = reservation.copyWith(
      id: 'reservation-${DateTime.now().millisecondsSinceEpoch}',
      userId: _currentUserId!,
      status: ReservationStatus.pending,
      createdAt: DateTime.now(),
    );

    _reservations[newReservation.id] = newReservation;
    return newReservation;
  }

  /// PUT /reservations/:id/status
  Future<Reservation> updateReservationStatus(
    String id,
    ReservationStatus status,
  ) async {
    await _simulateDelay();
    _checkAuth();

    final reservation = _reservations[id];
    if (reservation == null) {
      throw MockServerException(404, 'Reservation not found');
    }

    // Only owner of the center can approve/decline
    final center = _centers[reservation.centerId];
    if (center?.ownerId != _currentUserId) {
      throw MockServerException(
        403,
        'Not authorized to update this reservation',
      );
    }

    final updated = reservation.copyWith(status: status);
    _reservations[id] = updated;
    return updated;
  }

  /// DELETE /reservations/:id
  Future<void> cancelReservation(String id) async {
    await _simulateDelay();
    _checkAuth();

    final reservation = _reservations[id];
    if (reservation == null) {
      throw MockServerException(404, 'Reservation not found');
    }
    if (reservation.userId != _currentUserId) {
      throw MockServerException(
        403,
        'Not authorized to cancel this reservation',
      );
    }

    final updated = reservation.copyWith(status: ReservationStatus.cancelled);
    _reservations[id] = updated;
  }

  // ============= EVENTS ENDPOINTS =============

  /// GET /events
  Future<List<Event>> getEvents({String? centerId}) async {
    await _simulateDelay();
    var results = _events.values.toList();
    if (centerId != null) {
      results = results.where((e) => e.centerId == centerId).toList();
    }
    return results;
  }

  /// GET /events/:id
  Future<Event> getEvent(String id) async {
    await _simulateDelay();
    final event = _events[id];
    if (event == null) {
      throw MockServerException(404, 'Event not found');
    }
    return event;
  }

  /// POST /events
  Future<Event> createEvent(Event event) async {
    await _simulateDelay();
    _checkAuth();

    final newEvent = event.copyWith(
      id: 'event-${DateTime.now().millisecondsSinceEpoch}',
      currentParticipants: 0,
      createdAt: DateTime.now(),
    );

    _events[newEvent.id] = newEvent;
    return newEvent;
  }

  /// PUT /events/:id
  Future<Event> updateEvent(String id, Event event) async {
    await _simulateDelay();
    _checkAuth();

    final existing = _events[id];
    if (existing == null) {
      throw MockServerException(404, 'Event not found');
    }
    // Check ownership via center
    final center = _centers[existing.centerId];
    if (center?.ownerId != _currentUserId) {
      throw MockServerException(403, 'Not authorized to update this event');
    }

    final updated = event.copyWith(id: id, centerId: existing.centerId);
    _events[id] = updated;
    return updated;
  }

  /// DELETE /events/:id
  Future<void> deleteEvent(String id) async {
    await _simulateDelay();
    _checkAuth();

    final event = _events[id];
    if (event == null) {
      throw MockServerException(404, 'Event not found');
    }
    // Check ownership via center
    final center = _centers[event.centerId];
    if (center?.ownerId != _currentUserId) {
      throw MockServerException(403, 'Not authorized to delete this event');
    }

    _events.remove(id);
    // Also remove all participations
    _participations.removeWhere((_, p) => p.eventId == id);
  }

  /// GET /events/:id/participants
  Future<List<EventParticipation>> getEventParticipations(
    String eventId,
  ) async {
    await _simulateDelay();
    return _participations.values.where((p) => p.eventId == eventId).toList();
  }

  /// POST /events/:id/participants
  Future<EventParticipation> requestParticipation(
    String eventId, {
    String? message,
  }) async {
    await _simulateDelay();
    _checkAuth();

    final event = _events[eventId];
    if (event == null) {
      throw MockServerException(404, 'Event not found');
    }

    // Check if already requested
    if (_participations.values.any(
      (p) => p.eventId == eventId && p.userId == _currentUserId,
    )) {
      throw MockServerException(409, 'Already requested to join this event');
    }

    final user = _users[_currentUserId]!;
    final participation = EventParticipation(
      id: 'participation-${DateTime.now().millisecondsSinceEpoch}',
      eventId: eventId,
      userId: _currentUserId!,
      userName: user.name,
      status: ParticipationStatus.pending,
      message: message,
      requestedAt: DateTime.now(),
    );

    _participations[participation.id] = participation;
    return participation;
  }

  /// PUT /events/:eventId/participants/:participationId
  Future<EventParticipation> updateParticipationStatus(
    String eventId,
    String participationId,
    ParticipationStatus status,
  ) async {
    await _simulateDelay();
    _checkAuth();

    final event = _events[eventId];
    if (event == null) {
      throw MockServerException(404, 'Event not found');
    }
    // Check ownership via center
    final center = _centers[event.centerId];
    if (center?.ownerId != _currentUserId) {
      throw MockServerException(403, 'Not authorized to update participations');
    }

    final participation = _participations[participationId];
    if (participation == null) {
      throw MockServerException(404, 'Participation not found');
    }

    final updated = participation.copyWith(status: status);
    _participations[participationId] = updated;

    // Update participant count if approved
    if (status == ParticipationStatus.approved) {
      _events[eventId] = event.copyWith(
        currentParticipants: event.currentParticipants + 1,
      );
    }

    return updated;
  }

  // ============= REVIEWS ENDPOINTS =============

  /// GET /reviews
  Future<List<Review>> getReviews({String? centerId, String? userId}) async {
    await _simulateDelay();

    var results = _reviews.values.toList();

    if (centerId != null) {
      results = results.where((r) => r.centerId == centerId).toList();
    }

    if (userId != null) {
      results = results.where((r) => r.userId == userId).toList();
    }

    return results;
  }

  /// POST /reviews
  Future<Review> createReview(Review review) async {
    await _simulateDelay();
    _checkAuth();

    final user = _users[_currentUserId]!;
    final newReview = review.copyWith(
      id: 'review-${DateTime.now().millisecondsSinceEpoch}',
      userId: _currentUserId!,
      userName: user.name,
      createdAt: DateTime.now(),
    );

    _reviews[newReview.id] = newReview;

    // Update center's average rating
    _updateCenterRating(review.centerId);

    return newReview;
  }

  /// PUT /reviews/:id
  Future<Review> updateReview(String id, Review review) async {
    await _simulateDelay();
    _checkAuth();

    final existing = _reviews[id];
    if (existing == null) {
      throw MockServerException(404, 'Review not found');
    }
    if (existing.userId != _currentUserId) {
      throw MockServerException(403, 'Not authorized to update this review');
    }

    final updated = review.copyWith(
      id: id,
      userId: existing.userId,
      userName: existing.userName,
    );
    _reviews[id] = updated;

    // Update center's average rating
    _updateCenterRating(review.centerId);

    return updated;
  }

  /// DELETE /reviews/:id
  Future<void> deleteReview(String id) async {
    await _simulateDelay();
    _checkAuth();

    final review = _reviews[id];
    if (review == null) {
      throw MockServerException(404, 'Review not found');
    }
    if (review.userId != _currentUserId) {
      throw MockServerException(403, 'Not authorized to delete this review');
    }

    final centerId = review.centerId;
    _reviews.remove(id);

    // Update center's average rating
    _updateCenterRating(centerId);
  }

  void _updateCenterRating(String centerId) {
    final centerReviews = _reviews.values.where((r) => r.centerId == centerId).toList();
    if (centerReviews.isEmpty) {
      _centers[centerId] = _centers[centerId]!.copyWith(
        averageRating: 0,
        reviewCount: 0,
      );
    } else {
      final avgRating = centerReviews.map((r) => r.rating).reduce((a, b) => a + b) / centerReviews.length;
      _centers[centerId] = _centers[centerId]!.copyWith(
        averageRating: avgRating,
        reviewCount: centerReviews.length,
      );
    }
  }

  // ============= ORDERS ENDPOINTS =============

  /// GET /orders
  Future<List<Order>> getOrders() async {
    await _simulateDelay();
    _checkAuth();
    return _orders.values.where((o) => o.userId == _currentUserId).toList();
  }

  /// GET /orders/:id
  Future<Order> getOrder(String id) async {
    await _simulateDelay();
    _checkAuth();

    final order = _orders[id];
    if (order == null) {
      throw MockServerException(404, 'Order not found');
    }
    return order;
  }

  /// POST /orders/checkout
  Future<Order> checkout({String? reservationId}) async {
    await _simulateDelay();
    _checkAuth();

    final cart = _carts[_currentUserId] ?? [];
    if (cart.isEmpty && reservationId == null) {
      throw MockServerException(400, 'Cart is empty');
    }

    // Calculate totals
    double subtotal = 0;
    final orderItems = <OrderItem>[];

    for (final cartItem in cart) {
      final totalPrice = cartItem.totalPrice;
      subtotal += totalPrice;
      orderItems.add(
        OrderItem(
          itemId: cartItem.item.id,
          name: cartItem.item.name,
          quantity: cartItem.quantity,
          unitPrice: cartItem.isRenting ? cartItem.item.rentPricePerDay : (cartItem.item.buyPrice ?? 0),
          totalPrice: totalPrice,
          isRental: cartItem.isRenting,
          rentalDays: cartItem.isRenting ? cartItem.rentalDays : null,
        ),
      );
    }

    // Add reservation cost if applicable
    if (reservationId != null) {
      final reservation = _reservations[reservationId];
      if (reservation != null) {
        subtotal += reservation.totalPrice;
      }
    }

    final serviceFee = subtotal * 0.05; // 5% service fee
    final totalAmount = subtotal + serviceFee;

    final order = Order(
      id: 'order-${DateTime.now().millisecondsSinceEpoch}',
      userId: _currentUserId!,
      reservationId: reservationId,
      items: orderItems,
      subtotal: subtotal,
      serviceFee: serviceFee,
      totalAmount: totalAmount,
      paymentStatus: PaymentStatus.pending,
      createdAt: DateTime.now(),
    );

    _orders[order.id] = order;

    // Clear cart
    _carts[_currentUserId!] = [];

    return order;
  }

  // ============= HELPER METHODS =============

  void _checkAuth() {
    if (_currentUserId == null) {
      throw MockServerException(401, 'Authentication required');
    }
  }

  void _checkOwner() {
    final user = _users[_currentUserId];
    if (user?.role != UserRole.owner) {
      throw MockServerException(403, 'Owner access required');
    }
  }

  /// Set the current user (for testing/demo purposes).
  void setCurrentUser(String userId, String token) {
    _currentUserId = userId;
    _currentAuthToken = token;
  }

  /// Get current user ID (for testing).
  String? get currentUserId => _currentUserId;

  /// Clear current session.
  void clearSession() {
    _currentUserId = null;
    _currentAuthToken = null;
  }

  /// Reset all data to initial seed state.
  Future<void> reset() async {
    _users.clear();
    _centers.clear();
    _items.clear();
    _reservations.clear();
    _events.clear();
    _reviews.clear();
    _orders.clear();
    _participations.clear();
    _carts.clear();
    _currentUserId = null;
    _currentAuthToken = null;
    _initialized = false;
    await initialize();
  }
}

/// Exception thrown by mock server operations.
class MockServerException implements Exception {
  final int statusCode;
  final String message;

  MockServerException(this.statusCode, this.message);

  @override
  String toString() => 'MockServerException($statusCode): $message';
}
