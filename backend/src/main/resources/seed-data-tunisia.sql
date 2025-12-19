-- Campify Backend - Tunisian Seed Data
-- This script populates the database with realistic Tunisian camping centers and related data

-- Note: Run this AFTER the application has created the tables via Hibernate

-- ============================================
-- USERS (Owners and Campers)
-- ============================================
-- Password for all users: "password123" (hashed with BCrypt)

INSERT INTO users (id, email, password, first_name, last_name, phone_number, avatar_url, role) VALUES
-- Owners
(1, 'ahmed.ben.ali@campify.tn', '$2a$10$N9qo8uLOickgx2ZkmWqvu.M8ov.c3M0HZbq/Q2GRVFUqNmH1L7Zta', 'Ahmed', 'Ben Ali', '+216 98 123 456', 'https://i.pravatar.cc/150?img=12', 'OWNER'),
(2, 'fatma.khedher@campify.tn', '$2a$10$N9qo8uLOickgx2ZkmWqvu.M8ov.c3M0HZbq/Q2GRVFUqNmH1L7Zta', 'Fatma', 'Khedher', '+216 22 654 321', 'https://i.pravatar.cc/150?img=45', 'OWNER'),
(3, 'mohamed.trabelsi@campify.tn', '$2a$10$N9qo8uLOickgx2ZkmWqvu.M8ov.c3M0HZbq/Q2GRVFUqNmH1L7Zta', 'Mohamed', 'Trabelsi', '+216 55 789 012', 'https://i.pravatar.cc/150?img=33', 'OWNER'),
-- Campers
(4, 'sara.mansour@example.tn', '$2a$10$N9qo8uLOickgx2ZkmWqvu.M8ov.c3M0HZbq/Q2GRVFUqNmH1L7Zta', 'Sara', 'Mansour', '+216 28 456 789', 'https://i.pravatar.cc/150?img=20', 'USER'),
(5, 'karim.gharbi@example.tn', '$2a$10$N9qo8uLOickgx2ZkmWqvu.M8ov.c3M0HZbq/Q2GRVFUqNmH1L7Zta', 'Karim', 'Gharbi', '+216 92 345 678', 'https://i.pravatar.cc/150?img=51', 'USER');

SELECT setval('users_id_seq', 5, true);

-- ============================================
-- CAMPING CENTERS (Tunisian Locations)
-- ============================================

INSERT INTO camping_centers (id, name, description, location, price, owner_id) VALUES
(1, 'Camping Paradis Hammamet', 
 'Centre de camping moderne situé à Hammamet, avec accès direct à la plage. Idéal pour les familles et les amateurs de sports nautiques.',
 'Route de la Corniche, Hammamet 8050, Tunisia', 
 '45 TND/nuit',
 1),

(2, 'Oasis du Sahara - Douz',
 'Vivez une expérience unique dans le désert tunisien. Camp berbère authentique avec excursions en chameau et nuits sous les étoiles.',
 'Zone Touristique, Douz 4260, Tunisia',
 '65 TND/nuit',
 2),

(3, 'Camping Phoenicia Carthage',
 'Camping historique près des ruines de Carthage. Parfait pour les passionnés d''histoire et de culture. Vue magnifique sur la Méditerranée.',
 'Avenue Bourguiba, La Marsa 2078, Tunisia',
 '55 TND/nuit',
 3),

(4, 'Les Oliviers de Djerba',
 'Camping familial dans une oliveraie centenaire sur l''île de Djerba. Ambiance paisible et authentique. Accès plage à 5 minutes.',
 'Route Touristique, Midoun, Djerba 4116, Tunisia',
 '40 TND/nuit',
 1),

(5, 'Cap Bon Aventure',
 'Centre d''activités outdoor dans la péninsule du Cap Bon. Randonnées, VTT, escalade. Hébergement en tentes berbères de luxe.',
 'Korbous, Nabeul 8045, Tunisia',
 '50 TND/nuit',
 2),

(6, 'Camping Kairouan Heritage',
 'Situé près de la Grande Mosquée de Kairouan, ce camping offre une immersion culturelle unique. Visites guidées disponibles.',
 'Route de Sousse, Kairouan 3100, Tunisia',
 '35 TND/nuit',
 3);

SELECT setval('camping_centers_id_seq', 6, true);

-- ============================================
-- CENTER IMAGES
-- ============================================

INSERT INTO center_images (center_id, image_url) VALUES
-- Hammamet
(1, 'https://images.unsplash.com/photo-1504851149312-7a075b496cc7?w=800'),
(1, 'https://images.unsplash.com/photo-1523987355523-c7b5b0dd90a7?w=800'),
(1, 'https://images.unsplash.com/photo-1478131143081-80f7f84ca84d?w=800'),
-- Douz
(2, 'https://images.unsplash.com/photo-1509316785289-025f5b846b35?w=800'),
(2, 'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=800'),
(2, 'https://images.unsplash.com/photo-1473496169904-658ba7c44d8a?w=800'),
-- Carthage
(3, 'https://images.unsplash.com/photo-1478131143081-80f7f84ca84d?w=800'),
(3, 'https://images.unsplash.com/photo-1445308394109-4ec2920981b1?w=800'),
-- Djerba
(4, 'https://images.unsplash.com/photo-1504280390367-361c6d9f38f4?w=800'),
(4, 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800'),
-- Cap Bon
(5, 'https://images.unsplash.com/photo-1478131143081-80f7f84ca84d?w=800'),
(5, 'https://images.unsplash.com/photo-1476514525535-07fb3b4ae5f1?w=800'),
-- Kairouan
(6, 'https://images.unsplash.com/photo-1504851149312-7a075b496cc7?w=800'),
(6, 'https://images.unsplash.com/photo-1445308394109-4ec2920981b1?w=800');

-- ============================================
-- REVIEWS
-- ============================================

INSERT INTO reviews (id, center_id, user_id, rating, comment, created_at) VALUES
(1, 1, 4, 5, 'Excellent camping! La plage est magnifique et le personnel très accueillant. Je recommande vivement!', NOW() - INTERVAL '15 days'),
(2, 1, 5, 4, 'Très bon séjour à Hammamet. Installations propres et bien entretenues. Un peu bruyant le weekend.', NOW() - INTERVAL '10 days'),
(3, 2, 4, 5, 'Expérience inoubliable dans le Sahara! Les balades en chameau et les nuits sous les étoiles étaient magiques.', NOW() - INTERVAL '20 days'),
(4, 3, 5, 4, 'Belle vue sur Carthage. Parfait pour visiter les sites archéologiques. Camping un peu ancien mais charmant.', NOW() - INTERVAL '5 days'),
(5, 4, 4, 5, 'Djerba est un paradis! Le camping dans l''oliveraie est très paisible. Idéal pour se ressourcer.', NOW() - INTERVAL '12 days'),
(6, 5, 5, 4, 'Activités outdoor excellentes. Les randonnées guidées dans le Cap Bon sont superbes!', NOW() - INTERVAL '8 days');

SELECT setval('reviews_id_seq', 6, true);

-- ============================================
-- MARKETPLACE ITEMS
-- ============================================

INSERT INTO marketplace_items (id, name, description, price, category, center_id, stock) VALUES
-- Camping Gear
(1, 'Tente Familiale 4 Places', 'Tente résistante au vent avec double toit. Parfaite pour le climat tunisien.', 350.00, 'CAMPING_GEAR', NULL, 15),
(2, 'Sac de Couchage -5°C', 'Sac de couchage 3 saisons, idéal pour les nuits fraîches du désert.', 120.00, 'CAMPING_GEAR', NULL, 25),
(3, 'Matelas Gonflable', 'Matelas auto-gonflant avec pompe incluse.', 85.00, 'CAMPING_GEAR', NULL, 20),
(4, 'Lampe Camping LED', 'Lampe rechargeable avec 3 modes d''éclairage.', 45.00, 'CAMPING_GEAR', NULL, 30),

-- Food & Beverages
(5, 'Pack Barbecue Tunisien', 'Kit complet: merguez, brochettes, charbon et épices locales.', 55.00, 'FOOD_BEVERAGES', 1, 10),
(6, 'Café des Bédouins', 'Café traditionnel tunisien moulu, 500g.', 18.00, 'FOOD_BEVERAGES', 2, 50),
(7, 'Dattes Deglet Nour', 'Dattes premium de la région de Tozeur, 1kg.', 25.00, 'FOOD_BEVERAGES', 2, 40),
(8, 'Eau Minérale Safia 12x1.5L', 'Pack d''eau pour vos excursions.', 12.00, 'FOOD_BEVERAGES', NULL, 100),

-- Outdoor Equipment  
(9, 'Chaise Pliante Camping', 'Chaise légère et confortable avec porte-gobelet.', 65.00, 'OUTDOOR_EQUIPMENT', NULL, 35),
(10, 'Glacière 30L', 'Conserve le froid pendant 48h.', 95.00, 'OUTDOOR_EQUIPMENT', NULL, 20),
(11, 'Kit Snorkeling', 'Masque, tuba et palmes pour explorer la Méditerranée.', 75.00, 'OUTDOOR_EQUIPMENT', 1, 15),
(12, 'Sandales de Plage', 'Sandales confortables résistantes à l''eau et au sable.', 35.00, 'OUTDOOR_EQUIPMENT', 4, 50),

-- Accessories
(13, 'Crème Solaire SPF50', 'Protection haute contre le soleil tunisien intense.', 28.00, 'ACCESSORIES', NULL, 60),
(14, 'Chapeau Sahara', 'Chapeau large bord pour protection solaire maximale.', 42.00, 'ACCESSORIES', 2, 40),
(15, 'Sac à Dos Randonnée 25L', 'Sac léger avec poche hydratation.', 110.00, 'ACCESSORIES', NULL, 25);

SELECT setval('marketplace_items_id_seq', 15, true);

-- ============================================
-- MARKETPLACE ITEM IMAGES
-- ============================================

INSERT INTO marketplace_item_images (item_id, image_url) VALUES
(1, 'https://images.unsplash.com/photo-1478131143081-80f7f84ca84d?w=400'),
(2, 'https://images.unsplash.com/photo-1520095972714-909e91b038e5?w=400'),
(3, 'https://images.unsplash.com/photo-1504851149312-7a075b496cc7?w=400'),
(5, 'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=400'),
(11, 'https://images.unsplash.com/photo-1544551763-46a013bb70d5?w=400');

-- ============================================
-- EVENTS
-- ============================================

INSERT INTO events (id, title, description, center_id, owner_id, start_date, end_date, max_participants, image_url, created_at) VALUES
(1, 'Festival Berbère - Musique et Culture',
 'Soirée traditionnelle avec musique berbère, danse et dégustation de plats locaux sous les étoiles du Sahara.',
 2, 2, NOW() + INTERVAL '10 days', NOW() + INTERVAL '10 days' + INTERVAL '6 hours', 50,
 'https://images.unsplash.com/photo-1533174072545-7a4b6ad7a6c3?w=800', NOW()),

(2, 'Randonnée Cap Bon Sunrise',
 'Randonnée matinale pour admirer le lever du soleil depuis les hauteurs du Cap Bon. Petit-déjeuner inclus.',
 5, 2, NOW() + INTERVAL '5 days', NOW() + INTERVAL '5 days' + INTERVAL '4 hours', 20,
 'https://images.unsplash.com/photo-1551632811-561732d1e306?w=800', NOW()),

(3, 'Atelier Poterie Traditionnelle',
 'Apprenez l''art de la poterie tunisienne avec un artisan local. Créez votre propre souvenir!',
 6, 3, NOW() + INTERVAL '7 days', NOW() + INTERVAL '7 days' + INTERVAL '3 hours', 15,
 'https://images.unsplash.com/photo-1578926078025-ce1e8050fbc5?w=800', NOW()),

(4, 'Plongée Découverte Hammamet',
 'Baptême de plongée dans les eaux cristallines de Hammamet. Équipement et moniteur inclus.',
 1, 1, NOW() + INTERVAL '3 days', NOW() + INTERVAL '3 days' + INTERVAL '2 hours', 12,
 'https://images.unsplash.com/photo-1544551763-46a013bb70d5?w=800', NOW()),

(5, 'Soirée Astronomie Désert',
 'Observation des étoiles avec un astronome dans le désert de Douz. Télescope professionnel fourni.',
 2, 2, NOW() + INTERVAL '12 days', NOW() + INTERVAL '12 days' + INTERVAL '4 hours', 25,
 'https://images.unsplash.com/photo-1419242902214-272b3f66ee7a?w=800', NOW()),

(6, 'Cours de Cuisine Tunisienne',
 'Apprenez à préparer des plats traditionnels: couscous, brik, tajine. Dégustation incluse!',
 4, 1, NOW() + INTERVAL '8 days', NOW() + INTERVAL '8 days' + INTERVAL '3 hours', 18,
 'https://images.unsplash.com/photo-1556910103-1c02745aae4d?w=800', NOW());

SELECT setval('events_id_seq', 6, true);

-- ============================================
-- RESERVATIONS (Sample)
-- ============================================

INSERT INTO reservations (id, user_id, center_id, check_in_date, check_out_date, guests, total_price, status, created_at) VALUES
(1, 4, 1, NOW() + INTERVAL '5 days', NOW() + INTERVAL '8 days', 2, 135.00, 'CONFIRMED', NOW() - INTERVAL '2 days'),
(2, 5, 2, NOW() + INTERVAL '15 days', NOW() + INTERVAL '18 days', 4, 195.00, 'CONFIRMED', NOW() - INTERVAL '1 day'),
(3, 4, 4, NOW() + INTERVAL '20 days', NOW() + INTERVAL '25 days', 3, 200.00, 'PENDING', NOW());

SELECT setval('reservations_id_seq', 3, true);

-- ============================================
-- COMPLETION MESSAGE
-- ============================================

SELECT 'Tunisian seed data inserted successfully!' as status,
       (SELECT COUNT(*) FROM camping_centers) as centers,
       (SELECT COUNT(*) FROM marketplace_items) as items,
       (SELECT COUNT(*) FROM events) as events,
       (SELECT COUNT(*) FROM reviews) as reviews;
