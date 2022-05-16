# bot.py
# This file is intended to be a "getting started" code example for students.
# The code in this file is fully functional.
# Students are free to edit the code in the milestone 3 folder.
# Students are NOT allowed to distribute this code without the express permission of the class instructor
# IMPORTANT: How to set your secret environment variables? read README guidelines.

# imports
from email import message
import os
import discord
import database as db
import random

# environment variables
token = "OTcxMTkwODAxNTA3OTU0NzI4.GHeiVY.vfO9CYk2jrBI-POxA1mUHlzO2oii0pj6Ml4aKU"
server = "nadhikariServer"
# server_id = os.environ['SERVER_ID']  # optional
# channel_id = os.environ['CHANNEL_ID']  # optional

# database connection
# secret keys related to your database must be updated. Otherwise, it won't work
db_conn = db.connect()
# bot events
intens = discord.Intents.all()
intents = discord.Intents.default()
intents.members = True
client = discord.Client(intents=intents)

# list of all member in server
member_list = []


@client.event
async def on_ready():
    """
    This method triggers with the bot connects to the server
    Note that the sample implementation here only prints the
    welcome message on the IDE console, not on Discord
    :return: VOID
    """
    print("{} has joined the server".format(client.user.name))
    for guild in client.guilds:
        for member in guild.members:
            if member.display_name != "CSC675nadhikariBot":
                member_list.append(member.display_name)
    await client.change_presence(
        activity=discord.Activity(
            type=discord.ActivityType.watching,
            name="Hello " + random.choice(member_list),
        )
    )


@client.event
async def on_message(message):
    """
    This method triggers when a user sends a message in any of your Discord server channels
    :param message: the message from the user. Note that this message is passed automatically by the Discord API
    :return: VOID
    """

    response = None  # will save the response from the bot
    if message.author == client.user:
        return  # the message was sent by the bot
    if message.type is discord.MessageType.new_member:
        # a new member joined the server. Welcome him.
        response = "Welcome {}".format(message.author)
    else:
        # A message was send by the user.
        msg = message.content.lower()
        # response = db.response(msg)
        if "find_book_date_cat 1980 1990 comic" in msg:
            response = db.response(msg)
            # print(response)
            # print("\n".join(answer))
        elif "storage" in msg:
            response = db.response(msg)
        elif "change_password" in msg:
            response = db.response(msg)
        elif "late_users" in msg:
            response = db.response(msg)

    if response:
        # bot sends response to the Discord API and the response is show
        # on the channel from your Discord server that triggered this method.
        embed = discord.Embed(
            description=("\n".join(map(str, response))), color=discord.Color.blue()
        )
        await message.channel.send(embed=embed)


try:
    # start the bot and keep the above methods listening for new events
    client.run(token)
except:
    print(
        "Bot is offline because your secret environment variables are not set. Head to the left panel, "
        + "find the lock icon, and set your environment variables. For more details, read the README file in your "
        + "milestone 3 repository"
    )
