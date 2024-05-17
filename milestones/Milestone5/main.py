"""
The code below is just representative of the implementation of a Bot. 
However, this code was not meant to be compiled as it. It is the responsability 
of all the students to modifify this code such that it can fit the 
requirements for this assignments.
"""

from logging import NullHandler
import discord
import os
from discord import user
from discord.ext import commands
from models import *
from models import UpdateFoodInventoryModel, UpdateMaintenanceCaloriesModel

#TODO:  add your Discord Token as a value to your secrets on replit using the DISCORD_TOKEN key
TOKEN = os.environ["DISCORD_TOKEN"]

intents = discord.Intents.all()

bot = commands.Bot(command_prefix='!', intents=discord.Intents.all())


@bot.command(name="test", description="write your database business requirement for this command here")
async def _test(ctx, arg1):
    testModel = TestModel(ctx, arg1)
    response = testModel.response()
    await ctx.send(response)


# TODO: complete the following tasks:
#       (1) Replace the commands' names with your own commands
#       (2) Write the description of your business requirement in the description parameter
#       (3) Implement your commands' methods.

@bot.command(name="update_food_inv", description="Implement real-time updates to food inventories and grocery lists, allowing users to see what they currently have and what they need instantly.")
async def _command1(ctx, username = None, food: str = None):
    if username is None:
        response = 'Please use one of the following formats:\n    To show food inventory and grocery list: !update_food_inv <username>\n    To add to food inventory and remove from grocery list: !update_food_inv <username> "<food>"'
    else:
        if food is not None:
            originalFI = UpdateFoodInventoryModel.get(username)
            if originalFI.foodInventoryList == [] and original.groceryList == []:
                response = f'Food inventory and grocery list for {username} are empty.'
            else:
                updateFI = UpdateFoodInventoryModel.update(username,food)
                response = f"Username: {originalFI.username}\n   Food Inventory: {originalFI.foodInventoryList} \n   Grocery List: {originalFI.groceryList}\nBuying {food}...\n   Updated Food Inventory and Grocery List:\n   "
                newFI = UpdateFoodInventoryModel.get(username)
                response = response + f"Food Inventory: {newFI.foodInventoryList} \n   Grocery List: {newFI.groceryList}"
        else:
            FI = UpdateFoodInventoryModel.get(username)
            response = f"Username: {FI.username}\n   Food Inventory: {FI.foodInventoryList} \n   Grocery List: {FI.groceryList}\n"
    await ctx.send(response)


@bot.command(name="calc_maintenance_cals", description="Include an advanced formula to calculate a user’s maintenance calories based off their height, age, weight, and gender.")
async def _command2(ctx, username=None):
    if username is None:
        response = 'Please use the following format:\n    To show maintenance calories: !calc_maintenance_cals <username>'
    else:
        updateCals = UpdateMaintenanceCaloriesModel.update(username)
        newCals = UpdateMaintenanceCaloriesModel.get(username)
        response = f"Username: {newCals.username}\n    Maintenance Calories: {newCals.mainetenanceCals}"
    await ctx.send(response)


@bot.command(name="cmd_3", description="database business requirement #3 here")
async def _command3(ctx, *args):
    await ctx.send("This method is not implemented yet")


@bot.command(name="cmd_4", description="database business requirement #4 here")
async def _command4(ctx, *args):
    await ctx.send("This method is not implemented yet")


@bot.command(name="session", description="Manage how long users are logged during a session, which includes both a login date and time, and a logout date and time.")
async def _command5(ctx, email = None, device: str = None, time = None):
    if email is None:
        response = 'Please use one of the following format:\n    To show sessions: !session <email>\n    To create a new session: !session <email> "<device>" <time in minutes>'
    else:
        if device is not None and time is not None:
            newLogin = LoginModel.insert(email, device, time)
        
        login = LoginModel.get(email)
        if login.loginInfo == []:
            response = f"No login session found for {email}"
        else:
            response = f"Email: {login.email}\n "
            for index, singleLogin in enumerate(login.loginInfo, start = 1):
                response = response + f"Session: {index}\n   Device: {singleLogin.device}\n   Email: {singleLogin.email}\n   Login: {singleLogin.login}\n   Logout: {singleLogin.logout}\n"

    await ctx.send(response)


@bot.command(name="weight_log", description="Provide users with the ability to track their progress on their weight gain or weight loss journeys by allowing them to put multiple weight log entries.")
async def _command6(ctx, username=None, weight=None):
    if username is None:
        response = 'Please use one of the following format:\n    To show weight logs: !weight_log <username>\n    To create a new weight log: !weight_log <username> <weight>'
    else:
        if weight is not None:
            newWeightLog = InsertWeightLogModel.insert(username, weight)
        listOfWeightLogs = InsertWeightLogModel.get(username)
        if listOfWeightLogs.weightLogs == []:
            response = f"No weight logs found for {username}"
        else:
            response = f"Username: {listOfWeightLogs.username}\n    Weight Logs:\n"
            for index, singleWeightLog in enumerate(listOfWeightLogs.weightLogs,  start = 1):
                response = response + f"        Weight Log {index}:    Weight: {singleWeightLog.weight}kg    Date: {singleWeightLog.date}\n"
    await ctx.send(response)


@bot.command(name="food_tag", description="Provide a way for users to filter foods by a food tag that will help the user fulfill their specific nutritional needs.")
async def _command7(ctx, foodTag: str=None):
    if foodTag is None:
        response = 'Please use the following format:\n    To show for foods by food tag: !food_tag "<food tag>"\n'
    else:
        foundFoods = FoodTagModel.get(foodTag)
        if foundFoods.foods == []:
            response = f"No foods found with the tag {foodTag}"
        else:
            response = f"Foods with the tag {foodTag}:\n    "
            for index, food in enumerate(foundFoods.foods,  start = 1):
                response = response + f"{index}. {food}\n"
    await ctx.send(response)


@bot.command(name="find_food", description="Provide searching for users to efficiently find specific foods, medications, supplements, and recipes to put into their diet logs.")
async def _command8(ctx, name: str = None):
    if name is None:
        response = 'Please use the following format:\n    To search for foods: !find_food "<food name>"\n'
    else:
        foundData = FindFoodModel.get(name)
        if foundData.results == []:
            response = f"No results found for {name}"
        else:
            response = f"Results for {foundData.name}:\n"
            for index, food in enumerate(foundData.results, start = 1):
                response = response + f"{index}. {food.name} - {food.brand} - {food.calories} calories - {food.protein}g protein - {food.carbs}g carbs - {food.fat}g fat - serving size: {food.serving_size}\n"
    await ctx.send(response)


@bot.command(name="add_goal", description="Allow for users to track their past and present goals. This includes a starting date and a complete by date, as well as a title and description.")
async def _command9(ctx, username = None, title: str = None, description: str = None, length=None):
    if username is None:
        response = 'Please use one of the following formats:\n    To get list of long term goals: !add_goal <username>\n    To add a new long term goal: !add_goal <username> "<title>" "<description>" <length in weeks>'
    else:
        if title is not None and description is not None and length is not None:
            newGoal = LTGoalsModel.insert(username, title, description, length)
        getGoals = LTGoalsModel.get(username)
    
        if (getGoals.results == []):
            response = "No goals found or username does not exist"
        else:
            response = f"Username: {getGoals.username}\n"
            for index, goal in enumerate(getGoals.results, start = 1):
                response = response + f"    Goal {index}:   Title: {goal.title}    Description: {goal.description}    Date Assigned: {goal.date_assigned}    Complete By Date: {goal.complete_by_date}    "
                if goal.completed == 1:
                    response = response + f"Status: Completed\n"
                else:
                    response = response + f"Status: Not Completed\n"
    await ctx.send(response)


@bot.command(name="cmd_10", description="database business requirement #10 here")
async def _command10(ctx, *args):
    await ctx.send("This method is not implemented yet")


@bot.command(name="cmd_11", description="database business requirement #11 here")
async def _command11(ctx, *args):
    await ctx.send("This method is not implemented yet")


@bot.command(name="cmd_12", description="database business requirement #12 here")
async def _command12(ctx, *args):
    await ctx.send("This method is not implemented yet")


@bot.command(name="cmd_13", description="database business requirement #13 here")
async def _command13(ctx, *args):
    await ctx.send("This method is not implemented yet")


@bot.command(name="cmd_14", description="database business requirement #14 here")
async def _command14(ctx, *args):
    await ctx.send("This method is not implemented yet")


@bot.command(name="cmd_15", description="database business requirement #15 here")
async def _command15(ctx, *args):
    await ctx.send("This method is not implemented yet")


bot.run(TOKEN)
