# How to Load Tunisian Seed Data

## Method 1: Using psql (PostgreSQL Client)

If you have `psql` installed:

```bash
# Connect to your database and run the script
psql -h ep-dawn-fog-a81603gh-pooler.eastus2.azure.neon.tech -U neondb_owner -d neondb -f backend/src/main/resources/seed-data-tunisia.sql
```

When prompted, enter the password: `npg_rZI2zS9jtRkn`

## Method 2: Using pgAdmin or DBeaver

1. Open your database tool (pgAdmin, DBeaver, DataGrip, etc.)
2. Connect to the Neon PostgreSQL database:
   - Host: `ep-dawn-fog-a81603gh-pooler.eastus2.azure.neon.tech`
   - Port: `5432`
   - Database: `neondb`
   - Username: `neondb_owner`
   - Password: `npg_rZI2zS9jtRkn`
   - SSL Mode: `require`
3. Open the SQL script file: `backend/src/main/resources/seed-data-tunisia.sql`
4. Execute the entire script

## Method 3: Via Spring Boot Application

The seed data will be automatically loaded when you start the backend if you update the `DataSeeder.java` (next step).

## What's Included

### Tunisian Camping Centers (6 locations):
- **Camping Paradis Hammamet** - Beach camping in Hammamet
- **Oasis du Sahara - Douz** - Authentic desert experience
- **Camping Phoenicia Carthage** - Historical site near Carthage ruins
- **Les Oliviers de Djerba** - Family camping in olive grove, Djerba island
- **Cap Bon Aventure** - Outdoor activities in Cap Bon peninsula
- **Camping Kairouan Heritage** - Cultural immersion near Great Mosque

### Marketplace Items (15 products):
- Camping gear (tents, sleeping bags, etc.)
- Tunisian food & beverages (dates, coffee, BBQ kits)
- Outdoor equipment (snorkel gear, beach items)
- Accessories (sunscreen, hats)

### Events (6 activities):
- Berber Festival with music and culture
- Sunrise hiking in Cap Bon
- Traditional pottery workshop
- Scuba diving in Hammamet
- Desert astronomy night
- Tunisian cooking class

### Sample Data:
- 5 users (3 owners, 2 campers)
- 6 reviews
- 3 sample reservations

### Default Login Credentials:
All seeded users have the password: **password123**

Example logins:
- **Owner**: `ahmed.ben.ali@campify.tn` / `password123`
- **Owner**: `fatma.khedher@campify.tn` / `password123`
- **Camper**: `sara.mansour@example.tn` / `password123`

## Verification

After running the script, you should see a summary message showing the count of inserted records.

## Note

Make sure the Spring Boot application has run at least once to create all the necessary tables via Hibernate before executing this seed script.
