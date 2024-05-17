# In this file you must implement your main query methods 
# so they can be used by your database models to interact with your bot.

import os
from pymysql import DatabaseError
import pymysql.cursors

#TODO: add the values for these database keys in your secrets on replit
db_host = os.environ["DB_HOST"]
db_username = os.environ["DB_USER"]
db_password = os.environ["DB_PASSWORD"]
db_name = os.environ["DB_NAME"]


class Database:

    # This method was already implemented for you
    def connect(self):
        """
        This method creates a connection with your database
        IMPORTANT: all the environment variables must be set correctly
                   before attempting to run this method. Otherwise, it
                   will throw an error message stating that the attempt
                   to connect to your database failed.
        """
        try:
            conn = pymysql.connect(host=db_host,
                                   port=3306,
                                   user=db_username,
                                   password=db_password,
                                   db=db_name,
                                   charset="utf8mb4", cursorclass=pymysql.cursors.DictCursor)
            print("Bot connected to database {}".format(db_name))
            return conn
        except ConnectionError as err:
            print(f"An error has occurred: {err.args[1]}")
            print("\n")

    #TODO: needs to implement the internal logic of all the main query operations
    def get_response(self, query, values=None, fetch=True, many_entities=False):
        response = None 
        connection = self.connect() 
        if connection:
            cursor = connection.cursor()
            if values: 
                if many_entities:
                    cursor.executemany(query, values)
                else: 
                    cursor.execute(query, values)
            else: 
                cursor.execute(query)

            connection.commit()
            connection.close()
            if fetch: 
                response = cursor.fetchall()
        else:
            print("Failed to connect to the database.")
            
        return response
        
    # the following methods were already implemented for you.
    @staticmethod
    def select(query, values=None, fetch=True):
        database = Database()
        return database.get_response(query, values=values, fetch=fetch)

    @staticmethod
    def insert(query, values=None, many_entities=False):
        database = Database()
        return database.get_response(query, values=values, many_entities=many_entities)

    @staticmethod
    def update(query, values=None):
        database = Database()
        return database.get_response(query, values=values)

    @staticmethod
    def delete(query, values=None):
        database = Database()
        return database.get_response(query, values=values)

class Query:
    GetFoodInventory = """SELECT fo.name, ac.username 
FROM `Food Inventory` fi
JOIN Food fo ON fo.food_id = fi.food_id
JOIN Account ac ON ac.account_id = fi.account_id
WHERE ac.username = %s;"""

    GetGroceryList = """SELECT fo.name, ac.username 
FROM `Grocery List` gl
JOIN Food fo ON fo.food_id = gl.food_id
JOIN Account ac ON ac.account_id = gl.account_id
WHERE ac.username = %s;"""

    GetMaintenanceCalories = """SELECT ng.calories AS "Maintenance Calories", ac.username AS "Username"
FROM `Nutritional Goals` ng
JOIN Account ac ON ac.account_id = ng.account_id
WHERE ac.username = %s;"""

    GetLogin = """SELECT de.device_name AS "Device Name", us.email AS "Email", lo.login_date AS "Login Date", lo.logout_date AS "Logout Date"
FROM `Login Sessions` lo
JOIN Devices de ON de.device_id = lo.device_id
JOIN Users us ON us.user_id = lo.user_id
WHERE us.email = %s;"""

    GetWeightLog = """SELECT wl.weight AS "Weight", ac.username AS "Username", wl.weight_log_date AS "Date Entered"
FROM `Weight Log` wl
JOIN Account ac ON ac.account_id = wl.account_id
WHERE ac.username = %s;"""

    GetFoodByTag = """SELECT ft.food_type_name AS "Food Tag", fo.name AS "Food Name"
FROM `Food Type` ft
JOIN `Assigned Food Types` aft ON aft.food_type_id = ft.food_type_id
JOIN Food fo ON fo.food_id = aft.food_id
WHERE ft.food_type_name = %s;"""

    GetFood = """SELECT fo.name AS "Food Name", fo.brand AS "Brand", ni.calories AS "Calories", ni.protein AS "Protein", ni.fats AS "Fats", ni.carbs AS "Carbs", ni.serving_size AS "Serving Size"
FROM Food fo
JOIN `Nutritional Information` ni ON ni.nutrition_id = fo.nutrition_id
WHERE fo.name LIKE %s;"""

    GetLTGoals = """SELECT ac.username, lg.title, lg.description, lg.date_assigned, lg.complete_by_date, lg.completed 
FROM `Long-Term Goals` lg
JOIN Account ac ON ac.account_id = lg.account_id
WHERE ac.username = %s;"""

class Insert:
    addToFoodIventory = """INSERT INTO `Food Inventory` (food_id, account_id, expiration_date, status)
    SELECT
        (SELECT food_id FROM Food WHERE name = %s), 
        (SELECT account_id FROM Account WHERE username = %s), 
        DATE_ADD(CURDATE(), INTERVAL 3 WEEK), 
        "None";"""

    addLogin = """INSERT INTO `Login Sessions` (device_id, user_id, login_date, logout_date)
SELECT (SELECT device_id FROM Devices WHERE device_name = %s), (SELECT user_id FROM Users WHERE email = %s), CURDATE(), DATE_ADD(CURDATE(), INTERVAL %s MINUTE);"""

    addWeightLog = """INSERT INTO `Weight Log` (account_id, weight, weight_log_date)
SELECT 
    (SELECT account_id FROM Account WHERE username = %s), %s, CURDATE();"""

    addLTGoal = """INSERT INTO `Long-Term Goals` (account_id, title, description, date_assigned, complete_by_date, completed)
SELECT
	(SELECT account_id FROM Account WHERE username = %s), %s, %s, CURDATE(), DATE_ADD(CURDATE(), INTERVAL %s WEEK), 0;"""

class Delete:
    DeleteFromGroceryList = """DELETE FROM `Grocery List`
    WHERE food_id = (SELECT food_id FROM Food WHERE name = %s) AND account_id = (SELECT account_id FROM Account WHERE username = %s);"""

class Update:
    UpdateMaintenanceCalories = """UPDATE `Nutritional Goals` ng
JOIN (
    SELECT 
        ng.account_id,
        CASE 
            WHEN me.gender = 'Male' THEN 66 + (13.7 * me.starting_weight) + (5 * me.height) - (ac.age * 6.8)
            WHEN me.gender = 'Female' THEN 655 + (9.6 * me.starting_weight) + (1.8 * me.height) - (ac.age * 4.7)
        END AS calculated_calories
    FROM `Nutritional Goals` ng
    JOIN Account ac ON ng.account_id = ac.account_id
    JOIN Measurements me ON ac.account_id = me.account_id
) AS subquery
ON ng.account_id = subquery.account_id
SET ng.calories = subquery.calculated_calories
WHERE ng.account_id = (SELECT account_id FROM Account WHERE username = %s);"""

