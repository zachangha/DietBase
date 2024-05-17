"""
In this file you must implement all your database models.
If you need to use the methods from your database.py call them
statically. For instance:
       # opens a new connection to your database
       connection = Database.connect()
       # closes the previous connection to avoid memory leaks
       connection.close()
"""


from os import EX_TEMPFAIL
from discord import user
from pymysql import DatabaseError, connect, connections

from database import *
from database import Query, Database, Insert, Delete, Update

class TestModel:
    """
    This is an object model example. Note that
    this model doesn't implement a DB connection.
    """

    def __init__(self, ctx, arg1):
        self.ctx = ctx
        self.author = ctx.message.author.name
        self.arg1 = arg1

    def response(self):
        return f'Hi, {self.author}. I am alive'

class UpdateFoodInventoryModel():
    def __init__(self, username = None) -> None:
        super().__init__()
        self.foodInventoryList = []
        self.groceryList = []
        self.username = username

    @staticmethod
    def get(value=None):
        username = value
        try:
            user = UpdateFoodInventoryModel(username)
            foodInventoryData = Database.select(Query.GetFoodInventory, (username))
            groceryListData = Database.select(Query.GetGroceryList, (username))
            if foodInventoryData:
                for values in foodInventoryData:
                    user.username = values['username']
                    user.foodInventoryList.append(values['name'])
            if groceryListData:
                for values in groceryListData:
                    user.groceryList.append(values['name'])
            return user
        except DatabaseError as db_err:
            print(f"User {username} couldn't be retreived from database. \n Error: {db_err.args[1]}")
            return None

    def update(username=None, food = None):
        try:
            updateFoodInv = Database.insert(Insert.addToFoodIventory, (food, username))
            updateGroceryList = Database.delete(Delete.DeleteFromGroceryList, (food, username))
            return updateFoodInv, updateGroceryList
        except DatabaseError as db_err:
            print(f"User {username} couldn't be retreived from database. \n Error: {db_err.args[1]}")
            return None

class UpdateMaintenanceCaloriesModel():
    def __init__(self, username = None) -> None:
        super().__init__()
        self.maintenanceCals = 0
        self.username = username

    def get(username=None):
        user = UpdateMaintenanceCaloriesModel(username)
        maintenanceCalsData = Database.select(Query.GetMaintenanceCalories, (username))
        try:
            if maintenanceCalsData:
                for values in maintenanceCalsData:
                    user.mainetenanceCals = values['Maintenance Calories']
                    user.username = values['Username']
            return user
        except DatabaseError as db_err:
            print(f"User {username} couldn't be retreived from database. \n Error: {db_err.args[1]}")
            return None
    
    def update(username=None):
        try:
            updateCals = Database.update(Update.UpdateMaintenanceCalories, (username))
            return updateCals
        except DatabaseError as db_err:
            print(f"User {username} couldn't be retreived from database. \n Error: {db_err.args[1]}")
            return None

class LoginModel():
    class LoginInfo:
        def __init__(self):
            self.email = None
            self.device = None
            self.login = None
            self.logout = None
    
    
    def __init__(self, email = None) -> None:
        super().__init__()
        self.email = email
        self.loginInfo = []


    def get(email=None):
        sessions = LoginModel(email)
        loginData = Database.select(Query.GetLogin, (email))
        try:
            if loginData:
                for values in loginData:
                    individualLogin = LoginModel.LoginInfo()
                    individualLogin.device = values['Device Name']
                    individualLogin.email = values['Email']
                    individualLogin.login = values['Login Date']
                    individualLogin.logout = values['Logout Date']
                    sessions.loginInfo.append(individualLogin)
            return sessions
        except DatabaseError as db_err:
            print(f"User {email} couldn't be retreived from database. \n Error: {db_err.args[1]}")
            return None

    def insert(email=None, device=None, time=None):
        try:
            newLogin = Database.insert(Insert.addLogin, (device, email, time))
            return newLogin
        except DatabaseError as db_err:
            print(f"User {email} couldn't be retreived from database. \n Error: {db_err.args[1]}")
            return None

class InsertWeightLogModel():
    class WeightLog:
        def __init__(self):
            self.weight = None
            self.date = None
    
    def __init__(self, username = None) -> None:
        super().__init__()
        self.username = username
        self.weightLogs = []
    
    def get(username=None):
        userWeightLogs = InsertWeightLogModel(username)
        weightLogData = Database.select(Query.GetWeightLog, (username))
        try:
            if weightLogData:
                for values in weightLogData:
                    individualWeightLog = InsertWeightLogModel.WeightLog()
                    individualWeightLog.weight = values['Weight']
                    individualWeightLog.date = values['Date Entered']
                    userWeightLogs.weightLogs.append(individualWeightLog)
            return userWeightLogs
        except DatabaseError as db_err:
            print(f"User {username} couldn't be retreived from database. \n Error: {db_err.args[1]}")
            return None

    def insert(username=None, weight=None):
        try:
            newWeightLog = Database.insert(Insert.addWeightLog, (username, weight))
            return newWeightLog
        except DatabaseError as db_err:
            print(f"User {username} couldn't be retreived from database. \n Error: {db_err.args[1]}")
            return None

class FoodTagModel():
    def __init__(self, foodTag = None) -> None:
        super().__init__()
        self.foodTag = foodTag
        self.foods = []

    def get(foodTag=None):
        targetFoodTag = FoodTagModel(foodTag)
        foodTagData = Database.select(Query.GetFoodByTag, (foodTag))
        try:
            if foodTagData:
                for values in foodTagData:
                    targetFoodTag.foods.append(values['Food Name'])
            return targetFoodTag
        except DatabaseError as db_err:
            print(f"User {username} couldn't be retreived from database. \n Error: {db_err.args[1]}")
            return None

class FindFoodModel():
    class foundEntity:
        def __init__(self):
            self.name = None
            self.brand = None
            self.calories = None
            self.protein = None
            self.carbs = None
            self.fat = None
            self.serving_size = None
            
    def __init__(self, name = None) -> None:
        super().__init__()
        self.name = name
        self.results = []

    def get(name=None):
        returningData = FindFoodModel(name)
        name = "%" + name + "%"
        foodData = Database.select(Query.GetFood, (name))
        try:
            if foodData:
                for values in foodData:
                    entry = FindFoodModel.foundEntity()
                    entry.name = values['Food Name']
                    entry.brand = values['Brand']
                    entry.calories = values['Calories']
                    entry.protein = values['Protein']
                    entry.carbs = values['Carbs']
                    entry.fat = values['Fats']
                    entry.serving_size = values['Serving Size']
                    returningData.results.append(entry)
            else:
                print("No results found")
            return returningData
        except DatabaseError as db_err:
            print(f"User {username} couldn't be retreived from database. \n Error: {db_err.args[1]}")
            return None

class LTGoalsModel():
    class longTermGoal:
        def __init__(self):
            self.title = None
            self.description = None
            self.date_assigned = None
            self.complete_by_date = None
            self.completed = None

    def __init__(self, username = None) -> None:
        super().__init__()
        self.username = username
        self.results = []

    def get(username=None):
        foundLTGoals = LTGoalsModel(username)
        LTGoalsData = Database.select(Query.GetLTGoals, (username))
        try:
            if LTGoalsData:
                for values in LTGoalsData:
                    entry = LTGoalsModel.longTermGoal()
                    entry.title = values['title']
                    entry.description = values['description']
                    entry.date_assigned = values['date_assigned']
                    entry.complete_by_date = values['complete_by_date']
                    entry.completed = values['completed']
                    foundLTGoals.results.append(entry)
            else:
                print("No results found")
            return foundLTGoals
        except DatabaseError as db_err:
            print(f"User {username} couldn't be retreived from database. \n Error: {db_err.args[1]}")
            return None

    def insert(username=None, title=None, description=None, complete_by_date=None):
        try:
            newLTGoal = Database.insert(Insert.addLTGoal, (username, title, description, complete_by_date))
            return newLTGoal
        except DatabaseError as db_err:
            print(f"User {username} couldn't be retreived from database. \n Error: {db_err.args[1]}")
            return None
        