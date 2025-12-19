import '../core/domain/entities/entities.dart';

/// Seed data for demo mode.
///
/// This file contains all the mock data used when the app runs in demo mode.
/// It provides:
/// - 8 demo users (mix of campers and owners)
/// - 5 camping centers with varied features
/// - 10 marketplace items across different categories
/// - 6 community events
/// - Sample reviews, reservations, and participations
///
/// To modify demo data, edit the constants below. The mock server uses these
/// to initialize its in-memory database.

class MockData {
  MockData._();

  // ============= USERS =============

  /// Demo owner account - use for testing owner features
  static final User demoOwner = User(
    id: 'user-owner-1',
    email: 'owner@example.com',
    name: 'Alex Thompson',
    role: UserRole.owner,
    phone: '+1 (555) 123-4567',
    avatarUrl: 'https://i.pravatar.cc/150?u=owner1',
    createdAt: DateTime(2023, 1, 15),
  );

  /// Demo camper account - use for testing camper features
  static final User demoCamper = User(
    id: 'user-camper-1',
    email: 'camper@example.com',
    name: 'Jordan Rivera',
    role: UserRole.camper,
    phone: '+1 (555) 987-6543',
    avatarUrl: 'https://i.pravatar.cc/150?u=camper1',
    createdAt: DateTime(2023, 3, 20),
  );

  /// All demo users
  static final List<User> users = [
    demoOwner,
    demoCamper,
    const User(
      id: 'user-owner-2',
      email: 'mike.owner@example.com',
      name: 'Mike Chen',
      role: UserRole.owner,
      avatarUrl: 'https://i.pravatar.cc/150?u=owner2',
    ),
    const User(
      id: 'user-owner-3',
      email: 'sarah.owner@example.com',
      name: 'Sarah Williams',
      role: UserRole.owner,
      avatarUrl: 'https://i.pravatar.cc/150?u=owner3',
    ),
    const User(
      id: 'user-camper-2',
      email: 'emma.camper@example.com',
      name: 'Emma Johnson',
      role: UserRole.camper,
      avatarUrl: 'https://i.pravatar.cc/150?u=camper2',
    ),
    const User(
      id: 'user-camper-3',
      email: 'david.camper@example.com',
      name: 'David Kim',
      role: UserRole.camper,
      avatarUrl: 'https://i.pravatar.cc/150?u=camper3',
    ),
    const User(
      id: 'user-camper-4',
      email: 'lisa.camper@example.com',
      name: 'Lisa Martinez',
      role: UserRole.camper,
      avatarUrl: 'https://i.pravatar.cc/150?u=camper4',
    ),
    const User(
      id: 'user-camper-5',
      email: 'james.camper@example.com',
      name: 'James Brown',
      role: UserRole.camper,
      avatarUrl: 'https://i.pravatar.cc/150?u=camper5',
    ),
  ];

  // ============= CENTERS =============

  static final List<CampingCenter> centers = [
    CampingCenter(
      id: 'center-1',
      ownerId: 'user-owner-1',
      name: 'Pine Valley Retreat',
      description:
          'Nestled in the heart of an ancient pine forest, Pine Valley Retreat offers a serene escape from city life. Wake up to the sound of birds, enjoy hiking trails that wind through towering trees, and end your day stargazing around a crackling campfire. Our facilities include modern amenities while preserving the natural beauty that makes camping magical.',
      location: 'Blue Ridge Mountains, NC',
      photos: [
        'https://images.unsplash.com/photo-1504280390367-361c6d9f38f4?w=800',
        'https://images.unsplash.com/photo-1478131143081-80f7f84ca84d?w=800',
        'https://images.unsplash.com/photo-1510312305653-8ed496efae75?w=800',
      ],
      amenities: [
        'wifi',
        'shower',
        'toilet',
        'electricity',
        'parking',
        'bbq',
        'campfire',
      ],
      tags: ['mountain', 'forest', 'hiking', 'family'],
      priceMin: 35.0,
      priceMax: 75.0,
      isInteresting: true,
      averageRating: 4.7,
      reviewCount: 23,
      latitude: 35.5951,
      longitude: -82.5515,
      createdAt: DateTime(2022, 6, 1),
    ),
    CampingCenter(
      id: 'center-2',
      ownerId: 'user-owner-1',
      name: 'Lakeside Haven',
      description:
          'Experience the tranquility of waterfront camping at Lakeside Haven. Our campground sits on the shores of Crystal Lake, offering swimming, fishing, and kayaking right from your campsite. Perfect for families looking for a mix of adventure and relaxation. The sunsets over the lake are absolutely breathtaking.',
      location: 'Lake Tahoe, CA',
      photos: [
        'https://images.unsplash.com/photo-1537905569824-f89f14cceb68?w=800',
        'https://images.unsplash.com/photo-1523987355523-c7b5b0dd90a7?w=800',
        'https://images.unsplash.com/photo-1476041800959-2f6bb412c8ce?w=800',
      ],
      amenities: ['shower', 'toilet', 'water', 'parking', 'bbq', 'playground'],
      tags: ['lake', 'family', 'fishing', 'beach'],
      priceMin: 45.0,
      priceMax: 95.0,
      isInteresting: true,
      averageRating: 4.9,
      reviewCount: 45,
      latitude: 39.0968,
      longitude: -120.0324,
      createdAt: DateTime(2022, 4, 15),
    ),
    CampingCenter(
      id: 'center-3',
      ownerId: 'user-owner-2',
      name: 'Desert Oasis Camp',
      description:
          'Discover the magic of desert camping at our unique desert oasis. By day, explore stunning rock formations and desert wildlife. By night, experience unparalleled stargazing with zero light pollution. Our glamping tents offer a touch of luxury in the wilderness.',
      location: 'Joshua Tree, CA',
      photos: [
        'https://images.unsplash.com/photo-1533873984035-25970ab07461?w=800',
        'https://images.unsplash.com/photo-1496545672447-f699b503d270?w=800',
        'https://images.unsplash.com/photo-1469854523086-cc02fe5d8800?w=800',
      ],
      amenities: ['wifi', 'shower', 'toilet', 'electricity', 'parking'],
      tags: ['glamping', 'hiking'],
      priceMin: 65.0,
      priceMax: 150.0,
      isInteresting: true,
      averageRating: 4.5,
      reviewCount: 18,
      latitude: 34.1347,
      longitude: -116.3131,
      createdAt: DateTime(2023, 1, 10),
    ),
    CampingCenter(
      id: 'center-4',
      ownerId: 'user-owner-2',
      name: 'Riverside Meadows',
      description:
          'Camp alongside a gentle river at Riverside Meadows. Perfect for fishing enthusiasts and nature lovers. The meadows are home to diverse wildlife, and our pet-friendly policy means your furry friends can enjoy the adventure too. River tubing and catch-and-release fishing are popular activities.',
      location: 'Yellowstone, WY',
      photos: [
        'https://images.unsplash.com/photo-1445308394109-4ec2920981b1?w=800',
        'https://images.unsplash.com/photo-1508739773434-c26b3d09e071?w=800',
        'https://images.unsplash.com/photo-1517824806704-9040b037703b?w=800',
      ],
      amenities: ['toilet', 'water', 'parking', 'bbq'],
      tags: ['fishing', 'pet-friendly', 'family'],
      priceMin: 25.0,
      priceMax: 55.0,
      isInteresting: false,
      averageRating: 4.3,
      reviewCount: 31,
      latitude: 44.4280,
      longitude: -110.5885,
      createdAt: DateTime(2022, 8, 20),
    ),
    CampingCenter(
      id: 'center-5',
      ownerId: 'user-owner-3',
      name: 'Coastal Breeze Campground',
      description:
          'Wake up to ocean views at Coastal Breeze Campground. Located just steps from sandy beaches, our campground offers the perfect blend of camping and beach vacation. Enjoy surfing, tide pool exploration, and fresh seafood from local vendors. The sound of waves will lull you to sleep each night.',
      location: 'Big Sur, CA',
      photos: [
        'https://images.unsplash.com/photo-1534880606858-29b0e8a24e8d?w=800',
        'https://images.unsplash.com/photo-1499363536502-87642509e31b?w=800',
        'https://images.unsplash.com/photo-1510414842594-a61c69b5ae57?w=800',
      ],
      amenities: [
        'shower',
        'toilet',
        'electricity',
        'water',
        'parking',
        'store',
      ],
      tags: ['beach', 'family', 'hiking'],
      priceMin: 55.0,
      priceMax: 120.0,
      isInteresting: true,
      averageRating: 4.8,
      reviewCount: 67,
      latitude: 36.2704,
      longitude: -121.8081,
      createdAt: DateTime(2021, 11, 5),
    ),
  ];

  // ============= ITEMS =============

  static final List<MarketplaceItem> items = [
    MarketplaceItem(
      id: 'item-1',
      centerId: 'center-1',
      name: '4-Person Dome Tent',
      description:
          'Spacious dome tent perfect for families. Features quick-setup design, waterproof fly, and mesh windows for ventilation. Includes stakes and carry bag.',
      imageUrl:
          'https://images.unsplash.com/photo-1504280390367-361c6d9f38f4?w=400',
      category: ItemCategory.tent,
      rentPricePerDay: 25.0,
      buyPrice: 189.99,
      quantity: 5,
      isAvailable: true,
      createdAt: DateTime(2023, 3, 1),
    ),
    MarketplaceItem(
      id: 'item-2',
      centerId: 'center-1',
      name: '2-Person Backpacking Tent',
      description:
          'Lightweight backpacking tent for two. Ultra-compact when packed, perfect for hiking adventures. Weather-resistant with aluminum poles.',
      imageUrl:
          'https://images.unsplash.com/photo-1478131143081-80f7f84ca84d?w=400',
      category: ItemCategory.tent,
      rentPricePerDay: 18.0,
      buyPrice: 149.99,
      quantity: 8,
      isAvailable: true,
      createdAt: DateTime(2023, 3, 15),
    ),
    MarketplaceItem(
      id: 'item-3',
      centerId: 'center-2',
      name: 'Premium Sleeping Bag (-10°C)',
      description:
          'Mummy-style sleeping bag rated for cold weather camping. Synthetic insulation, water-resistant shell, and compression sack included.',
      imageUrl:
          'https://images.unsplash.com/photo-1510312305653-8ed496efae75?w=400',
      category: ItemCategory.sleeping,
      rentPricePerDay: 12.0,
      buyPrice: 89.99,
      quantity: 15,
      isAvailable: true,
      createdAt: DateTime(2023, 2, 10),
    ),
    MarketplaceItem(
      id: 'item-4',
      centerId: 'center-2',
      name: 'Self-Inflating Sleeping Pad',
      description:
          'Comfortable foam sleeping pad that self-inflates. R-value of 4.0 for insulation. Compact roll-up design with repair kit.',
      imageUrl:
          'https://images.unsplash.com/photo-1537905569824-f89f14cceb68?w=400',
      category: ItemCategory.sleeping,
      rentPricePerDay: 8.0,
      buyPrice: 59.99,
      quantity: 20,
      isAvailable: true,
      createdAt: DateTime(2023, 4, 5),
    ),
    MarketplaceItem(
      id: 'item-5',
      centerId: 'center-1',
      name: 'Portable Camp Stove',
      description:
          'Two-burner propane camp stove with adjustable heat. Wind guards included. Perfect for cooking delicious campsite meals.',
      imageUrl:
          'https://images.unsplash.com/photo-1523987355523-c7b5b0dd90a7?w=400',
      category: ItemCategory.cooking,
      rentPricePerDay: 15.0,
      buyPrice: 79.99,
      quantity: 6,
      isAvailable: true,
      createdAt: DateTime(2023, 1, 20),
    ),
    MarketplaceItem(
      id: 'item-6',
      centerId: 'center-3',
      name: 'Complete Cookware Set',
      description:
          'Non-stick camping cookware set including pots, pans, utensils, and plates for 4 people. Nesting design for compact storage.',
      imageUrl:
          'https://images.unsplash.com/photo-1476041800959-2f6bb412c8ce?w=400',
      category: ItemCategory.cooking,
      rentPricePerDay: 10.0,
      buyPrice: 54.99,
      quantity: 10,
      isAvailable: true,
      createdAt: DateTime(2023, 5, 1),
    ),
    MarketplaceItem(
      id: 'item-7',
      centerId: 'center-4',
      name: 'LED Camping Lantern',
      description:
          'Rechargeable LED lantern with 3 brightness modes. USB charging port doubles as power bank. 30-hour runtime on low.',
      imageUrl:
          'https://images.unsplash.com/photo-1533873984035-25970ab07461?w=400',
      category: ItemCategory.lighting,
      rentPricePerDay: 5.0,
      buyPrice: 29.99,
      quantity: 25,
      isAvailable: true,
      createdAt: DateTime(2023, 2, 28),
    ),
    MarketplaceItem(
      id: 'item-8',
      centerId: 'center-5',
      name: 'Folding Camp Chair',
      description:
          'Comfortable folding chair with cup holder and side pocket. Supports up to 300 lbs. Includes carry bag with shoulder strap.',
      imageUrl:
          'https://images.unsplash.com/photo-1496545672447-f699b503d270?w=400',
      category: ItemCategory.furniture,
      rentPricePerDay: 6.0,
      buyPrice: 34.99,
      quantity: 30,
      isAvailable: true,
      createdAt: DateTime(2023, 4, 15),
    ),
    MarketplaceItem(
      id: 'item-9',
      centerId: 'center-1',
      name: 'Portable Hammock',
      description:
          'Double hammock with tree straps. Lightweight parachute nylon, holds up to 500 lbs. Perfect for afternoon naps in nature.',
      imageUrl:
          'https://images.unsplash.com/photo-1469854523086-cc02fe5d8800?w=400',
      category: ItemCategory.furniture,
      rentPricePerDay: 8.0,
      buyPrice: 39.99,
      quantity: 12,
      isAvailable: true,
      createdAt: DateTime(2023, 3, 10),
    ),
    MarketplaceItem(
      id: 'item-10',
      centerId: 'center-2',
      name: 'First Aid & Survival Kit',
      description:
          'Comprehensive first aid kit with emergency supplies. Includes bandages, medications, emergency blanket, and survival tools.',
      imageUrl:
          'https://images.unsplash.com/photo-1445308394109-4ec2920981b1?w=400',
      category: ItemCategory.accessories,
      rentPricePerDay: 5.0,
      buyPrice: 44.99,
      quantity: 15,
      isAvailable: true,
      createdAt: DateTime(2023, 1, 5),
    ),
  ];

  // ============= EVENTS =============

  static List<Event> get events => [
        Event(
          id: 'event-1',
          centerId: 'center-1',
          title: 'Weekend Hiking Adventure',
          description:
              'Join us for an exciting weekend of hiking through scenic mountain trails! We\'ll explore hidden waterfalls, enjoy campfire cooking, and share stories under the stars. All skill levels welcome.',
          date: DateTime.now().add(const Duration(days: 14)),
          durationHours: 4,
          maxParticipants: 12,
          currentParticipants: 5,
          imageUrl:
              'https://images.unsplash.com/photo-1551632811-561732d1e306?w=800',
          createdAt: DateTime.now().subtract(const Duration(days: 7)),
        ),
        Event(
          id: 'event-2',
          centerId: 'center-1',
          title: 'Family Camping Workshop',
          description:
              'Learn essential camping skills in this family-friendly workshop. We\'ll cover tent setup, fire safety, outdoor cooking basics, and Leave No Trace principles. Kids activities included!',
          date: DateTime.now().add(const Duration(days: 21)),
          durationHours: 3,
          maxParticipants: 20,
          currentParticipants: 8,
          imageUrl:
              'https://images.unsplash.com/photo-1504280390367-361c6d9f38f4?w=800',
          createdAt: DateTime.now().subtract(const Duration(days: 10)),
        ),
        Event(
          id: 'event-3',
          centerId: 'center-2',
          title: 'Lakeside Kayaking Trip',
          description:
              'Paddle through crystal clear waters on this guided kayaking adventure. We\'ll explore hidden coves, spot wildlife, and enjoy a picnic lunch on a secluded beach. Kayaks provided.',
          date: DateTime.now().add(const Duration(days: 7)),
          durationHours: 5,
          maxParticipants: 8,
          currentParticipants: 6,
          imageUrl:
              'https://images.unsplash.com/photo-1537905569824-f89f14cceb68?w=800',
          createdAt: DateTime.now().subtract(const Duration(days: 5)),
        ),
        Event(
          id: 'event-4',
          centerId: 'center-3',
          title: 'Night Sky Photography',
          description:
              'Capture the Milky Way at one of the darkest sky locations in the country. Bring your camera and tripod for stunning astrophotography. Beginners welcome - tips and techniques shared.',
          date: DateTime.now().add(const Duration(days: 28)),
          durationHours: 4,
          maxParticipants: 15,
          currentParticipants: 3,
          imageUrl:
              'https://images.unsplash.com/photo-1533873984035-25970ab07461?w=800',
          createdAt: DateTime.now().subtract(const Duration(days: 3)),
        ),
        Event(
          id: 'event-5',
          centerId: 'center-4',
          title: 'Fishing Tournament',
          description:
              'Compete in our annual catch-and-release fishing tournament! Prizes for biggest catch, most fish, and best fish story. Fishing gear available for rent. Lunch and refreshments included.',
          date: DateTime.now().add(const Duration(days: 35)),
          durationHours: 6,
          maxParticipants: 30,
          currentParticipants: 12,
          imageUrl:
              'https://images.unsplash.com/photo-1445308394109-4ec2920981b1?w=800',
          createdAt: DateTime.now().subtract(const Duration(days: 14)),
        ),
        Event(
          id: 'event-6',
          centerId: 'center-5',
          title: 'Beach Cleanup & Surf Day',
          description:
              'Start the day giving back with a beach cleanup, then catch some waves! Surfing lessons available for beginners. Help preserve our beautiful coastline while having fun.',
          date: DateTime.now().add(const Duration(days: 10)),
          durationHours: 5,
          maxParticipants: 25,
          currentParticipants: 15,
          imageUrl:
              'https://images.unsplash.com/photo-1534880606858-29b0e8a24e8d?w=800',
          createdAt: DateTime.now().subtract(const Duration(days: 8)),
        ),
      ];

  // ============= REVIEWS =============

  static List<Review> get reviews => [
        Review(
          id: 'review-1',
          userId: 'user-camper-1',
          userName: 'Jordan Rivera',
          centerId: 'center-1',
          rating: 5,
          comment:
              'Absolutely stunning location! The pine trees create such a peaceful atmosphere. Facilities were clean and staff was super friendly. Will definitely be coming back!',
          createdAt: DateTime.now().subtract(const Duration(days: 30)),
        ),
        Review(
          id: 'review-2',
          userId: 'user-camper-2',
          userName: 'Emma Johnson',
          centerId: 'center-1',
          rating: 4,
          comment:
              'Great campground with beautiful trails. Lost one star because the WiFi was spotty, but honestly that helped us unplug and enjoy nature more!',
          createdAt: DateTime.now().subtract(const Duration(days: 45)),
        ),
        Review(
          id: 'review-3',
          userId: 'user-camper-3',
          userName: 'David Kim',
          centerId: 'center-2',
          rating: 5,
          comment:
              'The lake views are incredible. We kayaked every morning and the kids loved the playground. Perfect family camping destination.',
          createdAt: DateTime.now().subtract(const Duration(days: 20)),
        ),
        Review(
          id: 'review-4',
          userId: 'user-camper-4',
          userName: 'Lisa Martinez',
          centerId: 'center-2',
          rating: 5,
          comment:
              'Best camping experience ever! The sunset over the lake was magical. Highly recommend the fishing - caught my biggest bass here!',
          createdAt: DateTime.now().subtract(const Duration(days: 15)),
        ),
        Review(
          id: 'review-5',
          userId: 'user-camper-1',
          userName: 'Jordan Rivera',
          centerId: 'center-3',
          rating: 4,
          comment:
              'Unique desert experience. The glamping tents are luxurious. Night sky was breathtaking. Bring lots of water - it gets hot!',
          createdAt: DateTime.now().subtract(const Duration(days: 60)),
        ),
        Review(
          id: 'review-6',
          userId: 'user-camper-5',
          userName: 'James Brown',
          centerId: 'center-4',
          rating: 4,
          comment:
              'Lovely riverside setting. Fishing was excellent. Basic facilities but that\'s what we wanted - back to nature camping. Dog loved it too!',
          createdAt: DateTime.now().subtract(const Duration(days: 25)),
        ),
        Review(
          id: 'review-7',
          userId: 'user-camper-2',
          userName: 'Emma Johnson',
          centerId: 'center-5',
          rating: 5,
          comment:
              'Waking up to ocean waves is pure bliss. Beach access is fantastic and the camp store has everything you need. Worth every penny.',
          createdAt: DateTime.now().subtract(const Duration(days: 10)),
        ),
        Review(
          id: 'review-8',
          userId: 'user-camper-3',
          userName: 'David Kim',
          centerId: 'center-5',
          rating: 5,
          comment:
              'We stayed for a week and didn\'t want to leave. Kids learned to surf, we had amazing seafood dinners. The Big Sur coastline is majestic.',
          createdAt: DateTime.now().subtract(const Duration(days: 5)),
        ),
      ];

  // ============= RESERVATIONS =============

  static List<Reservation> get reservations => [
        Reservation(
          id: 'reservation-1',
          userId: 'user-camper-1',
          centerId: 'center-1',
          startDate: DateTime.now().add(const Duration(days: 5)),
          endDate: DateTime.now().add(const Duration(days: 8)),
          guestCount: 2,
          items: const [
            ReservationItem(
              itemId: 'item-1',
              itemName: '4-Person Dome Tent',
              quantity: 1,
              pricePerDay: 25.0,
              totalPrice: 75.0,
            ),
          ],
          status: ReservationStatus.approved,
          basePrice: 135.0, // 3 nights * $45
          totalPrice: 210.0,
          notes:
              'Anniversary camping trip - any romantic spot recommendations?',
          createdAt: DateTime.now().subtract(const Duration(days: 3)),
        ),
        Reservation(
          id: 'reservation-2',
          userId: 'user-camper-2',
          centerId: 'center-2',
          startDate: DateTime.now().add(const Duration(days: 10)),
          endDate: DateTime.now().add(const Duration(days: 14)),
          guestCount: 4,
          items: const [
            ReservationItem(
              itemId: 'item-3',
              itemName: 'Premium Sleeping Bag (-10°C)',
              quantity: 4,
              pricePerDay: 12.0,
              totalPrice: 192.0,
            ),
            ReservationItem(
              itemId: 'item-6',
              itemName: 'Complete Cookware Set',
              quantity: 1,
              pricePerDay: 10.0,
              totalPrice: 40.0,
            ),
          ],
          status: ReservationStatus.pending,
          basePrice: 320.0, // 4 nights * $80
          totalPrice: 552.0,
          notes:
              'Family trip with kids (ages 8 and 11). Need kid-friendly activities.',
          createdAt: DateTime.now().subtract(const Duration(days: 1)),
        ),
        Reservation(
          id: 'reservation-3',
          userId: 'user-camper-3',
          centerId: 'center-3',
          startDate: DateTime.now().subtract(const Duration(days: 5)),
          endDate: DateTime.now().subtract(const Duration(days: 3)),
          guestCount: 2,
          items: const [],
          status: ReservationStatus.completed,
          basePrice: 200.0,
          totalPrice: 200.0,
          createdAt: DateTime.now().subtract(const Duration(days: 10)),
        ),
        Reservation(
          id: 'reservation-4',
          userId: 'user-camper-4',
          centerId: 'center-5',
          startDate: DateTime.now().add(const Duration(days: 20)),
          endDate: DateTime.now().add(const Duration(days: 25)),
          guestCount: 3,
          items: const [
            ReservationItem(
              itemId: 'item-8',
              itemName: 'Folding Camp Chair',
              quantity: 3,
              pricePerDay: 6.0,
              totalPrice: 90.0,
            ),
          ],
          status: ReservationStatus.pending,
          basePrice: 425.0, // 5 nights * $85
          totalPrice: 515.0,
          notes: 'Looking forward to surfing!',
          createdAt: DateTime.now().subtract(const Duration(days: 2)),
        ),
      ];

  // ============= EVENT PARTICIPATIONS =============

  static List<EventParticipation> get participations => [
        EventParticipation(
          id: 'participation-1',
          eventId: 'event-1',
          userId: 'user-camper-2',
          userName: 'Emma Johnson',
          status: ParticipationStatus.approved,
          message: 'Love hiking! Looking forward to this adventure.',
          requestedAt: DateTime.now().subtract(const Duration(days: 5)),
        ),
        EventParticipation(
          id: 'participation-2',
          eventId: 'event-1',
          userId: 'user-camper-3',
          userName: 'David Kim',
          status: ParticipationStatus.approved,
          message: 'I\'ll bring my camera for the photography!',
          requestedAt: DateTime.now().subtract(const Duration(days: 4)),
        ),
        EventParticipation(
          id: 'participation-3',
          eventId: 'event-2',
          userId: 'user-camper-1',
          userName: 'Jordan Rivera',
          status: ParticipationStatus.pending,
          message: 'Perfect for our family! We\'re beginners.',
          requestedAt: DateTime.now().subtract(const Duration(days: 2)),
        ),
        EventParticipation(
          id: 'participation-4',
          eventId: 'event-3',
          userId: 'user-camper-4',
          userName: 'Lisa Martinez',
          status: ParticipationStatus.approved,
          requestedAt: DateTime.now().subtract(const Duration(days: 3)),
        ),
        EventParticipation(
          id: 'participation-5',
          eventId: 'event-6',
          userId: 'user-camper-1',
          userName: 'Jordan Rivera',
          status: ParticipationStatus.pending,
          message: 'Happy to help with the cleanup!',
          requestedAt: DateTime.now().subtract(const Duration(days: 1)),
        ),
      ];

  // ============= ORDERS =============

  static List<Order> get orders => [
        Order(
          id: 'order-1',
          userId: 'user-camper-1',
          reservationId: 'reservation-1',
          items: const [
            OrderItem(
              itemId: 'item-1',
              name: '4-Person Dome Tent',
              quantity: 1,
              unitPrice: 25.0,
              totalPrice: 75.0,
              isRental: true,
              rentalDays: 3,
            ),
          ],
          subtotal: 210.0,
          serviceFee: 15.0,
          totalAmount: 225.0,
          paymentStatus: PaymentStatus.completed,
          paymentMethod: 'Visa •••• 4242',
          transactionId: 'txn_mock_001',
          createdAt: DateTime.now().subtract(const Duration(days: 3)),
          paidAt: DateTime.now().subtract(const Duration(days: 3)),
        ),
        Order(
          id: 'order-2',
          userId: 'user-camper-3',
          reservationId: 'reservation-3',
          items: const [],
          subtotal: 200.0,
          serviceFee: 10.0,
          totalAmount: 210.0,
          paymentStatus: PaymentStatus.completed,
          paymentMethod: 'Mastercard •••• 5555',
          transactionId: 'txn_mock_002',
          createdAt: DateTime.now().subtract(const Duration(days: 10)),
          paidAt: DateTime.now().subtract(const Duration(days: 10)),
        ),
      ];
}
