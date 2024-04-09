-- In this file we will populate the DietBaseDB with entities.

USE DietBaseDB;

-- 1. Users
INSERT INTO Users (first_name, last_name, email, password)
VALUES
	('Joe', 'Johnson', 'bigjoe@gmail.com', 'theB1gestJoe'),
    ('Madison', 'James', 'maddyJ@gmail.com', 'myPassword'),
    ('Zach', 'Angha', 'notMyRealemail@yahoo.com', 'lol'),
    ('Emily', 'Jones', 'emJones@outlook.com', 'em1023!'),
    ('Trent', 'Alexander', 'TAA@yahoo.com', 'testPass'),
    ('Babeg', 'Panoosian', 'BabegPgmailyahoo.com', 'babegEgg');

-- 2. Devices
INSERT INTO Devices (device_type, device_name)
VALUES
    ('Macbook Air', 'Macbook J'),
    ('Lenovo Laptop', 'MyLenovo'),
    ('IPhone 6', 'PersonalPhone'),
    ('Blackberry', 'oldPhone'),
    ('IPad', 'IPad456'),
    ('GalaxyS10', 'GalaxyS10');

-- 3. Login Sessions
INSERT INTO `Login Sessions` (device_id, user_id, login_date, logout_date)
VALUES
	('1', '1', CURDATE(), NULL),
    ('4', '3', CURDATE(), NULL),
    ('3', '2', CURDATE(), DATE_ADD(CURDATE(), INTERVAL 3 HOUR)),
    ('6', '4', CURDATE(), NULL),
    ('2', '5', CURDATE(), NULL),
    ('5', '2', DATE_ADD(CURDATE(), INTERVAL 10 HOUR), DATE_ADD(CURDATE(), INTERVAL 12 HOUR));

-- 4. Account
INSERT INTO Account (user_id, username, role, dob, age, date_joined)
VALUES
	('1', 'BigJoeJohn', "General User", DATE_SUB(CURDATE(), INTERVAL 30 YEAR), NULL, CURDATE()),
	('2', 'MaddyJames', "Admin", DATE_SUB(CURDATE(), INTERVAL 20 YEAR), 20, DATE_SUB(CURDATE(), INTERVAL 1 YEAR)),
    ('3', 'TestAcc', "General User", DATE_SUB(CURDATE(), INTERVAL 15 YEAR), NULL, CURDATE()),
	('4', 'EmJone22', "General User", DATE_SUB(CURDATE(), INTERVAL 23 YEAR), NULL, CURDATE()),
    ('5', 'NotTheRealMe', "Admin", DATE_SUB(CURDATE(), INTERVAL 25 YEAR), NULL, CURDATE()),
    ('6', 'BabegPanoo', "Admin", DATE_SUB(CURDATE(), INTERVAL 40 YEAR), NULL, CURDATE());

-- 5. General User
INSERT INTO `General User` (account_id, date_joined, role)
VALUES
	('1', CURDATE(), "General User"),
	('4', CURDATE(), "General User"),
	('3', CURDATE(), "General User");

-- 6. Admin
INSERT INTO Admin (account_id, date_joined, role)
VALUES
	('2', DATE_SUB(CURDATE(), INTERVAL 1 YEAR), "Admin"),
	('5', CURDATE(), "Admin"),
	('6', CURDATE(), "Admin");

-- 7. Allergies and Restrictions
INSERT INTO `Allergies and Restrictions` (restriction_name, restriction_type)
VALUES
	('Peanuts', "Allergy"),
    ('High Blood Pressure', "Restriction"),
    ('Diabetic', "Restriction"),
    ('Shellfish', 'Allergy'),
    ('Lactose Intolerant', 'Allergy'),
    ('Gluten', 'Allergy');
 
-- 8. Restriction Log
INSERT INTO `Restriction Log` (severity_level, restriction_id, account_id)
VALUES
	("Mild", 1, 3),
    ("Severe", 2, 3),
    ("Fatal", 1, 1),
	("Mild", 4, 4),
    ("Severe", 5, 5),
	("Mild", 6, 5);

-- 9. Time Zones    
INSERT INTO `Time Zones` (time_zone_name, utc_offset)
VALUES
	('Pacific Standard Time', -8),
    ('China Standard Time', 8),
    ('Hawaii Standard Time', -10),
	('Eastern Standard Time', -5),
    ('Central European Time', 1),
    ('Greenwich Mean Time', 0);

-- 10. Locations    
INSERT INTO Locations (location_name, currency)
VALUES
	('United States', 'United States Dollar (USD)'),
    ('United Kingdon', 'Pound Sterling (GBP)'),
    ('India', 'Indian Rupee (INR)'),
	('Canada', 'Canadian Dollar (CAD)'),
    ('Japan', 'Japanese Yen (JPY)'),
    ('New Zealand', 'New Zealand Dollar (NZD)');

-- 11. Measurement Systems
INSERT INTO `Measurement Systems`(system_name, units)
VALUES
	('Imperial System', 'Length: in, Weight: lbs, Fluid: fl oz'),
    ('Imperial System (Feet)', 'Length: ft, Weight: lbs, Fluid: fl oz'),
    ('Imperial System (Pint)', 'Length: in, Weight: lbs, Fluid: pt'),
    ('Metric System', 'Length: m, Weight: kg, Fluid: mL'),
    ('Metric System (Grams)', 'Length: m, Weight: g, Fluid: mL'),
    ('Metric System (Centimeters)', 'Length: cm, Weight: kg, Fluid: mL');
    
-- 12. Languages
INSERT INTO Languages (language_name, language_code)
VALUES
	('English', 'en'),
    ('German', 'de'),
    ('Spanish', 'es'),
	('French', 'fr'),
    ('Russian', 'ru'),
    ('Korean', 'ko');
    
-- 13. Account Settings
INSERT INTO `Account Settings` (language_id, system_id, location_id, time_zone_id, account_id)
VALUES
	(1, 1, 2, 3, 1),
    (2, 1, 3, 1, 2),
    (1, 5, 3, 2, 3),
	(4, 4, 6, 5, 4),
    (5, 2, 4, 2, 5),
    (3, 6, 2, 6, 6);
    
-- 14. Measurements
INSERT INTO Measurements (account_id, height, starting_weight, gender)
VALUES
	(1, 72, 170, 'Male'),
    (2, 60, 183, 'Female'),
    (3, 55, 155, 'Male'),
	(4, 62, 170, 'Female'),
    (5, 66, 180, 'Male'),
    (6, 52, 150, 'Male');
    
-- 15. Long-Term Goals
INSERT INTO `Long-Term Goals` (account_id, title, description, date_assigned, complete_by_date, completed)
VALUES
	(1, 'Lose Weight', 'Lose 10 pounds by wedding.', CURDATE(), DATE_ADD(CURDATE(), INTERVAL 6 MONTH), 1),
    (2, 'Gain Weight', 'Gain 10 more pounds by next year.', CURDATE(), DATE_ADD(CURDATE(), INTERVAL 1 YEAR), 0),
    (3, 'Drink More Water', 'Try to drink a gallon of water a day.', CURDATE(), NULL, 0),
	(4, 'Run More', 'Go for a run at least 4 times a week.', CURDATE(), NULL, 1),
    (5, 'Bench 135', 'Bench at least a plate(135) by next fall.', CURDATE(), DATE_ADD(CURDATE(), INTERVAL 5 MONTH), 0),
    (6, 'Increase Protein', 'Get a gram of protein for every pound I weigh', CURDATE(), NULL, 0);

-- 16. Nutrition Goals
INSERT INTO `Nutritional Goals` (account_id, calories, macro_nutrients, micro_nutrients)
VALUES
	(1, 2565, "Protein: 120g, Fats: 50g, Carbohydrates: 130g", 'Iron: 100mg, Vitamin A: 200mg, Vitamin D: 2000 mg, Iodine: 200mg, Folate: 500mg, Zinc: 300mg'),
    (2, 2845, "Protein: 150g, Fats: 60g, Carbohydrates: 170g", 'Iron: 200mg, Vitamin A: 275mg, Vitamin D: 2200 mg, Iodine: 270mg, Folate: 600mg, Zinc: 380mg'),
    (3, 2743, "Protein: 145g, Fats: 55g, Carbohydrates: 150g", 'Iron: 150mg, Vitamin A: 234mg, Vitamin D: 2400 mg, Iodine: 220mg, Folate: 500mg, Zinc: 340mg'),
    (4, 2205, "Protein: 143g, Fats: 54g, Carbohydrates: 134g", 'Iron: 100mg, Vitamin A: 200mg, Vitamin D: 2000 mg, Iodine: 200mg, Folate: 500mg, Zinc: 300mg'),
    (5, 2932, "Protein: 175g, Fats: 65g, Carbohydrates: 134g", 'Iron: 200mg, Vitamin A: 275mg, Vitamin D: 2200 mg, Iodine: 270mg, Folate: 600mg, Zinc: 380mg'),
    (6, 2354, "Protein: 150g, Fats: 44g, Carbohydrates: 122g", 'Iron: 150mg, Vitamin A: 234mg, Vitamin D: 2400 mg, Iodine: 220mg, Folate: 500mg, Zinc: 340mg');

-- 17. Weight Log
INSERT INTO `Weight Log` (account_id, weight, weight_log_date)
VALUES
	(1, 170, CURDATE()),
    (2, 183, DATE_ADD(CURDATE(), INTERVAL 1 WEEK)),
    (3, 155, DATE_ADD(CURDATE(), INTERVAL 3 DAY)),
	(4, 170, CURDATE()),
    (5, 180, DATE_ADD(CURDATE(), INTERVAL 3 WEEK)),
    (6, 150, DATE_ADD(CURDATE(), INTERVAL 2 DAY));
    
-- 18. Fasting Log
INSERT INTO `Fasting Log` (account_id, time_length, fasting_date)
VALUES
	(1, 720, CURDATE()),
    (2, 600, CURDATE()),
    (3, 800, DATE_ADD(CURDATE(), INTERVAL 3 DAY)),
	(4, 434, CURDATE()),
    (5, 213, CURDATE()),
    (6, 756, DATE_ADD(CURDATE(), INTERVAL 2 WEEK));

-- 19. Water Intake
INSERT INTO `Water Intake` (account_id, water_amount, water_intake_date)
VALUES
	(1, 16, CURDATE()),
    (2, 8, CURDATE()),
    (3, 36, DATE_ADD(CURDATE(), INTERVAL 3 HOUR)),
	(4, 23, CURDATE()),
    (5, 29, CURDATE()),
    (6, 16, DATE_ADD(CURDATE(), INTERVAL 6 HOUR));

-- 20. Step Counter
INSERT INTO `Step Counter` (account_id, step_amount, step_counter_date)
VALUES
	(1, 10000, CURDATE()),
    (2, 11543, CURDATE()),
    (3, 12500, DATE_ADD(CURDATE(), INTERVAL 4 DAY)),
	(4, 7893, CURDATE()),
    (5, 5789, CURDATE()),
    (6, 12532, DATE_ADD(CURDATE(), INTERVAL 24 DAY));
    
-- 21. Sleep Log
INSERT INTO `Sleep Log` (account_id, sleep_amount, sleep_date)
VALUES
	(1, 480, CURDATE()),
    (2, 300, CURDATE()),
    (3, 123, CURDATE()),
	(4, 532, CURDATE()),
    (5, 356, CURDATE()),
    (6, 543, DATE_ADD(CURDATE(), INTERVAL 24 DAY));

-- 22. Nutritional Information
INSERT INTO `Nutritional Information` (calories, serving_size, macro_nutrients, micro_nutrients, verification)
VALUES
	(180, "4oz", "Protein: 20g, Fats: 15g, Carbohydrates: 0g", 'Iron: 20mg, Vitamin A: 20mg, Vitamin D: 0mg, Iodine: 200mg, Folate: 100mg, Zinc: 200mg', "Verified"),
    (240, "20g", "Protein: 0g, Fats: 23g, Carbohydrates: 15g", NULL, "Pending"),
    (120, "4fl oz", NULL, NULL, "None"),
	(220, "4oz", "Protein: 23g, Fats: 18g, Carbohydrates: 2g", 'Iron: 25mg, Vitamin A: 22mg, Vitamin D: 10mg, Iodine: 190mg, Folate: 130mg, Zinc: 230mg', "Verified"),
    (90, "35g", "Protein: 0g, Fats: 23g, Carbohydrates: 15g", NULL, "Pending"),
    (200, "1 can", NULL, NULL, "None"),
    (750, "1 meal", "Protein: 75g, Fats: 35g, Carbohydrates: 15g", NULL, "Verified");
    


-- 23. Food
INSERT INTO Food (name, brand, nutrition_id)
VALUES
	("Granola Bar", "Quaker Oats", 2),
    ("Cup of Ramen", "Cup of Noodles", NULL),
    ("Coca-Cola", NULL, 6),
	("Steak", "Amazon Fresh", 4),
    ("Freeze Dried Apples", "Good and Gather", 5),
    ("Whole Milk", "Trader Joes", 3),
    ("Ground Beef", "Whole Foods", 1),
    ("Shrimp", "Whole Foods", NULL),
    ("Flour", "Trader Joes", NULL);

-- 24. Food Type
INSERT INTO `Food Type` (food_type_name, food_type_description)
VALUES
	("Carb Heavy", "Food that is high in carbohydrates."),
    ("High Sodium", "Food that is high in sodium."),
    ("Keto", "Food that is low in carbohydrates to fit the keto diet."),
    ("High Sugar", "Food that is high in sugar."),
    ("High Protein", "Food that is high in protein."),
    ("Lactose", "Food contains lactose.");

-- 25. Assigned Food Types
INSERT INTO `Assigned Food Types` (food_id, food_type_id, date_updated)
VALUES
	(1, 1, CURDATE()),
    (2, 2, CURDATE()),
    (3, 4, DATE_ADD(CURDATE(), INTERVAL 4 DAY)),
	(4, 5, CURDATE()),
    (6, 6, CURDATE()),
    (5, 1, DATE_ADD(CURDATE(), INTERVAL 8 DAY));

-- 26. Grocery List
INSERT INTO `Grocery List` (food_id, account_id, priority_level, status)
VALUES
	(1, 1, "Needed", "Acquired"),
    (2, 1, "Can Wait", "Don't Have"),
    (3, 2, "Important", "Ordered"),
	(4, 3, "Can Wait", "Acquired"),
    (5, 6, "Important", "Ordered"),
    (6, 4, "Important", "Ordered");

-- 27. Food Inventory
INSERT INTO `Food Inventory` (food_id, account_id, expiration_date, status)
VALUES
	(1, 1, DATE_ADD(CURDATE(), INTERVAL 4 DAY), "None"),
    (2, 1, DATE_SUB(CURDATE(), INTERVAL 20 DAY), "Expired"),
    (2, 2, DATE_ADD(CURDATE(), INTERVAL 15 DAY), "Used"),
	(3, 6, DATE_ADD(CURDATE(), INTERVAL 3 DAY), "None"),
    (5, 3, DATE_SUB(CURDATE(), INTERVAL 60 DAY), "Expired"),
    (6, 4, DATE_ADD(CURDATE(), INTERVAL 25 DAY), "Used");
    
-- 28. Medication
INSERT INTO Medication (name, instructions, nutrition_id)
VALUES
	('Antibiotic', 'Once a day for 6 days.', NULL),
    ('Metformin', 'Take before every meal.', NULL),
    ('Ibuprofen', 'Take every 8 hours, with a something to eat.', NULL),
	('Asprin', NULL, NULL),
    ('Penicillin', 'Take before every meal.', NULL),
    ('Prednisone', 'Take once a day before you go to bed for a month.', NULL);
    
-- 29. Supplements
INSERT INTO Supplements (name, brand, nutrition_id)
VALUES
	('Chocolate Whey Protein Powder', 'Gold Standard', NULL),
    ('Vitamin D', 'Natures Bounty', NULL),
    ('Fish Oil', NULL, NULL),
	('Vanilla Whey Protein Powder', 'Gold Standard', NULL),
    ('Vitamin C', 'Natures Bounty', NULL),
    ('Magnesium', 'Santa Cruz Paleo', NULL);
    
-- 30. Recipe
INSERT INTO Recipe (name, directions, nutrition_id, difficulty)
VALUES
	('Shrimp Pasta', '1. Boil Pasta	2. Cook Shrimp	3. Add shrimp with pasta and sauce', NULL, 2),
    ('Meatloaf', '... Cook meat loaf for 30 minutes at 400 degrees.', NULL, 4),
    ('Shepards Pie', '1. Put vegtables and meat in pastry	2. Bake at 350 degrees for an hour', NULL, 3),
	('Steak And Potatos', '1. Cook steak in cast iron pan at high temp	2. Bake potatos in oven	3. Place together and serve', 7, 2),
    ('Protein Cookies', '1. Mix protein powder, flour, and eggs	2. Bake in oven at 400 degrees till crispy on the outside', NULL, 3),
    ('Bone Broth Stew', 'Pour bone broth and cut steak into pot and cook for 30 minutes on high', NULL, 3);
    
-- 31. Used in Recipe
INSERT INTO `Used in Recipe` (food_id, recipe_id, alternative)
VALUES
	(8, 1, "Any lean meat"),
    (7, 2, NULL),
    (7, 3, "Ground lamb or bison"),
    (4, 4, "Any lean meat"),
    (8, 5, NULL),
    (4, 6, NULL);

-- 32. Diet Log
INSERT INTO `Diet Log` (account_id, food_id, recipe_id, medication_id, supplement_id, time_entered, entity_type, serving_amount)
VALUES
	(1, 2, NULL, NULL, NULL, CURDATE(), "Food", 2.5),
    (2, NULL, NULL, NULL, 1, DATE_ADD(CURDATE(), INTERVAL 4 DAY), "Supplement", 1),
    (3, NULL, NULL, 1, NULL, CURDATE(), "Recipe", 1),
	(4, NULL, 5, NULL, NULL, CURDATE(), "Recipe", 2.435),
    (5, NULL, NULL, 3, NULL, DATE_ADD(CURDATE(), INTERVAL 4 DAY), "Medicine", 1),
    (6, NULL, NULL, 1, NULL, CURDATE(), "Recipe", 1.2);

-- 33. Saved Recipes
INSERT INTO `Saved Recipes` (recipe_id, account_id, bookmark_name)
VALUES
	(1, 1, NULL),
    (2, 2, "Spring Dishes"),
    (3, 4, NULL),
    (4, 3, "Party dishes"),
    (5, 5, "Fall Dishes"),
    (6, 6, NULL);

-- 34. Meal Plans
INSERT INTO `Meal Plans` (meal_plan_name, meal_plan_description)
VALUES
	("Keto Diet Meal Plan", "Monday- Breakfast: Eggs with keto bread as toast..."),
    ("Winter Bulking Plan", "...Friday- Snack: Protein shake with 2 scoops of protein powder and 2 tablespoons of peanut butter..."),
    ("Rapid Weightloss Plan", "...Sunday- Dinner: Chicken with greens and rice"),
    ("Spring Bulking Plan", "Monday- Breakfast: Scrambled eggs using 4 eggs..."),
    ("High Protein Vegan Plan", "...Friday- Snack: Protein shake with 2 scoops of vegan protein powder using almond milk..."),
    ("Low Saturaded Fat Diet", "...Sunday- Dinner: Salmon with greens");

-- 35. Followed Meal Plans
INSERT INTO `Followed Meal Plans` (meal_plan_id, account_id, date_subscribed)
VALUES
	(1, 2, CURDATE()),
    (1, 4, DATE_SUB(CURDATE(), INTERVAL 4 DAY)),
    (3, 1, CURDATE()),
    (5, 3, CURDATE()),
    (6, 5, DATE_SUB(CURDATE(), INTERVAL 45 DAY)),
    (2, 6, CURDATE());

-- 36. Meal Category
INSERT INTO `Meal Category` (meal_category_name, meal_category_description)
VALUES
	("Mediterranean", "Meal is from Mediterranian culture."),
    ("High Fat", "Meal is high in fat."),
    ("Keto Friendly", "Good meal for those looking for keto, low in carbs."),
    ("Middle Eastern", "Meal is from Middle Eastern culture."),
    ("Low Fat", "Meal is low in fat."),
    ("Lactose Free", "Food that doesn't contain lactose.");

-- 37. Recipe Tags
INSERT INTO `Recipe Tags` (meal_category_id, recipe_id, date_updated)
VALUES
	(2, 4, CURDATE()),
    (5, 2, DATE_SUB(CURDATE(), INTERVAL 4 DAY)),
    (4, 3, CURDATE()),
    (3, 5, CURDATE()),
    (2, 1, DATE_SUB(CURDATE(), INTERVAL 23 DAY)),
    (6, 6, CURDATE());

-- 38. Exercises
INSERT INTO Exercises (exercise_name, exercise_description, calories_burned, time)
VALUES
	("Pushups", "3 sets of 20 push ups.", 10, 7),
    ("Triathlon Preparation", "Begin with biking 3 miles...", 350, 60),
    ("Jumping Jacks", "Perform jumping jacks for 5 minutes, take a 2 minute break, then repeat for 20 minutes of jumping jacks.", 50, 30),
    ("Pull Ups", "4 sets of 10 pull ups.", 10, 10),
    ("Swimming", "General swimming.", 100, 60),
    ("Walking", "Relaxed walk.", 50, 20);

-- 39. Exercise Log
INSERT INTO `Exercise Log` (exercise_id, account_id, date_entered, time_taken)
VALUES
	(2, 2, CURDATE(), 14),
    (3, 1, CURDATE(), 60),
    (5, 3, DATE_SUB(CURDATE(), INTERVAL 4 WEEK), 30),
    (4, 4, CURDATE(), 35),
    (3, 6, CURDATE(), 38),
    (2, 5, DATE_SUB(CURDATE(), INTERVAL 2 WEEK), 32);

-- 40. Groups
INSERT INTO `Groups` (group_name, group_description, date_created, group_type)
VALUES
	("Meatless Monday", "Group designed to go plant-based every Monday or at least once a week!", CURDATE(), "Dieting"),
    ("Calisthenic Enthusiasts", "People who love to work out with calisthenic", CURDATE(), "Exercise"),
    ("Mothers That Walk", "Mothers that love to get out of the house for a nice stroll on the neighborhood.", DATE_SUB(CURDATE(), INTERVAL 4 WEEK), NULL),
    ("Weight Lifters", "For people who live in the gym!", CURDATE(), "Exercise"),
    ("HIIT Enjoyers", "People who love to use HIIT workouts", CURDATE(), "Exercise"),
    ("Swimmers Alliance", "For anyone who loves to swim.", DATE_SUB(CURDATE(), INTERVAL 8 WEEK), "Exercise");

-- 41. Joined Groups
INSERT INTO `Joined Groups` (account_id, group_id, date_joined_group)
VALUES
	(1, 2, CURDATE()),
    (2, 2, CURDATE()),
    (4, 3, DATE_SUB(CURDATE(), INTERVAL 2 MONTH)),
	(3, 5, CURDATE()),
    (5, 2, CURDATE()),
    (6, 1, DATE_SUB(CURDATE(), INTERVAL 1 MONTH));

-- 42. Posts
INSERT INTO Posts (account_id, post_title, post_description, date_created)
VALUES
	(3, "Try these new low carb crackers!", "These new crackers give you the same great taste with significantly less carbs.", CURDATE()),
    (1, "Tips for beginner?", "Hello, I just started tracking my nutrition any tips to help me?", CURDATE()),
    (2, "New best workout for fatloss!", "Adding in glute bridges has helped me lost so much fat I can't believe it!", DATE_SUB(CURDATE(), INTERVAL 2 WEEK)),
	(6, "Hello Everyone!", "I'm new to the community and excited to meet you all!", CURDATE()),
    (4, "Stretching", "Anyone who stretches can you give me some good ones to do?", CURDATE()),
    (5, "Exercise = Happiness!", "Just a reminder to get out there and break a sweat!", DATE_SUB(CURDATE(), INTERVAL 2 WEEK));

-- 43. Notification
INSERT INTO Notification (account_id, notification_description)
VALUES
	(1, "Reminder to take your medication today."),
    (3, "You haven't ate in a while, make sure to log it here!"),
    (2, "Go out for a run today!"),
    (4, "Reminder to take your medication today."),
    (5, "Workout today?"),
    (6, "Take a rest day, you've been working out a lot recently!");

-- 44. Challenges
INSERT INTO Challenges (challenge_name, challenge_description, challenge_length, challenge_type)
VALUES
	("Morning Stretches", "Do 10 minutes of stretching every morning for 30 days.", 30, "Fitness"),
    ("Pile on Protein", "Get at least 100 grams of protein everyday", 30, "Diet"),
    ("More Water", "Drink at least a gallon of water a day for a week", 7, "Diet"),
    ("Working out", "Work out everyday for 30 days.", 30, "Fitness"),
    ("Reduce Sugar", "Lower your sugar intake by 20 grams", NULL, "Diet"),
    ("Less Soda", "Drink only one soda every 2 days for a week!", 7, "Diet");

-- 45. Accepted Challenges
INSERT INTO `Accepted Challenges` (challenge_id, account_id, date_started, date_ended)
VALUES
	(1, 2, CURDATE(), NULL),
    (1, 4, CURDATE(), DATE_ADD(CURDATE(), INTERVAL 1 MONTH)),
    (2, 3, CURDATE(), NULL),
    (1, 5, CURDATE(), NULL),
    (1, 6, CURDATE(), DATE_ADD(CURDATE(), INTERVAL 1 MONTH)),
    (2, 1, CURDATE(), NULL);

-- 46. Friends
INSERT INTO Friends (sender_id, receiver_id, favorite)
VALUES
	(1, 2, 0),
    (2, 4, 1),
    (3, 4, 0),
    (4, 5, 0),
    (5, 1, 1),
    (6, 4, 1);
    
-- 47. Day Log
INSERT INTO `Day Log` (account_id, calories_consumed, date, calories_burned, calories_status)
VALUES
	(1, 2517, CURDATE(),120, "Under Goal"),
    (2, 2903, CURDATE(),0, "Within Goal"),
    (3, 2752, DATE_ADD(CURDATE(), INTERVAL 1 DAY),50, "Within Goal"),
    (4, 2447, CURDATE(),122, "Over Goal"),
    (5, 2703, CURDATE(),34, "Under Goal"),
    (6, 2232, DATE_ADD(CURDATE(), INTERVAL 5 DAY),30, "Under Goal");
