from flask import Flask
from flask import render_template
from flask import request
from flask import abort
from flask import jsonify
from flask import url_for

import os
import time
import sys
import pickle
import bz2
import base64


app = Flask(__name__)

@app.route ("/register", methods=["PUT"])
def register_user ():
    """
    Registers a user in the database
    Requires the user's email, phone, name, password
    """
    pass

@app.route ("/login", methods=["GET"])
def check_login ():
    """
    Checks if a user's credentials while logging in are appropriate
    """
    pass

@app.route ("/viewfriends", methods=["GET"])
def get_friends ():
    """
    Returns the friends of a user
    """
    pass

@app.route ("/viewrequests", methods=["GET"])
def get_requests ():
    """
    Returns the friend requests of a user
    """
    pass

@app.route ("/finishrequest", methods=["POST"])
def finish_request ():
    """
    Accepts/Ignores a friend request as specified by the user
    """
    pass

@app.route ("/sendrequest", methods=["POST"])
def send_request ():
    """
    Sends a request from one user to another as specified by the user
    """
    pass

@app.route ("/removefriend", methods=["POST"])
def remove_friend ():
    """
    Removed the friend relationship between two users
    """
    pass

@app.route ("/viewgroups", methods=["GET"])
def get_groups ():
    """
    Returns the groups in which a user exists
    """
    pass

@app.route ("/viewgrouprequests", methods=["GET"])
def get_group_requests ():
    """
    Returns the group requests of a user
    """
    pass

@app.route ("/finishgrouprequest", methods=["POST"])
def finish_group_request ():
    """
    Accepts/Ignores a group request as specified by the user
    """
    pass

@app.route ("/exitgroup", methods=["POST"])
def exit_group ():
    """
    Removes a user from the groups (deletes group information if the group has no more members left)
    """
    pass
