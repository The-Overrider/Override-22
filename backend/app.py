#! IMPORTANT
# https://developer.mozilla.org/en-US/docs/Web/HTTP/Status#client_error_responses

from flask import Flask
from flask import render_template
from flask import request
from flask import abort
from flask import jsonify
from flask import url_for

from flask_mysqldb import MySQL

import os
import time
import sys
import pickle
import bz2
import base64

hashlen                         = 64

app                             = Flask(__name__)

app.config["MYSQL_HOST"]        = "localhost"
app.config["MYSQL_USER"]        = "override"
app.config["MYSQL_PASSWORD"]    = "override"
app.config["MYSQL_DB"]          = "override"

mysql                           = MySQL (app)
con                             = mysql.connection
cursor                          = con.cursor ()


@app.route ("/register", methods=["POST"])
def register_user ():
    """
    Registers a user in the database
    Requires the user's email, phone, name, password

    The details must be provided as arguments in the URL in the form of the following suffix
        ?name=xyz&email=xyz&phone=xyz&password=xyz
    """
    name    = request.args.get ("name", default = None)
    email   = request.args.get ("email", default = "")
    phone   = request.args.get ("phone", default = "")
    password= request.args.get ("password", default = "")

    data    = {}

    # A user must have a non-empty name
    if name is None or len (name) <= 0:
        data["msg"] = "Name can not be empty!"
        return jsonify (data), 400

    # A user must have either a non-empty email or a non-empty phone number
    if (email is None or len (email) <= 0) and (phone is None or len (phone) <= 0):
        data["msg"] = "Either email or phone number must be provided!"
        return jsonify (data), 400

    # A user must have a non-empty password
    if password is None or len (password) <= 0:
        data["msg"] = "Password can not be empty!"
        return jsonify (data), 400

    # hash the password to get a fixed length string of length 64 (for now just get concat the name and the password)
    usr_hash = name + password
    if len (usr_hash) < hashlen:
        usr_hash = usr_hash[:hashlen]
    elif len (usr_hash) > hashlen:
        usr_hash = (' ' * hashlen - len (usr_hash)) + usr_hash

    # hash the phone and the email to get a fixed length of 64
    uuid     = phone + email
    if len (uuid) < hashlen:
        uuid     = uuid[:hashlen]
    elif len (uuid) > hashlen:
        uuid     = (' ' * hashlen - len (uuid)) + uuid

    # Check if a user with this number of email address can not exist in the database already
    if len (cursor.execute (f'''SELECT * FROM users WHERE uuid={uuid}''')) != 0:
        data["msg"] = "Duplicate user found!"
        return jsonify (data), 409

    # Insert the user into the table
    try:
        cursor.execute (f'''INSERT INTO users VALUES (
            {email},
            {phone},
            {name},
            {usr_hash},
            {uuid}
        );''')

    except:
        print (f"Error while inserting user\n{name}\n{email}\n{phone}\n{password}")
        data["msg"] = "Bad request!"
        return jsonify (data), 400

    # If the user was created successfully, return normally
    cursor.commit ()

    data["msg"] = "Success!"
    return jsonify (data), 201


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


app.run (host = "localhost")
mysql.commit ()
mysql.close ()
