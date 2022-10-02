#! IMPORTANT
# https://developer.mozilla.org/en-US/docs/Web/HTTP/Status#client_error_responses

from flask import Flask
from flask import render_template
from flask import request
from flask import abort
from flask import jsonify
from flask import url_for

import mysql.connector

import os
import time
import sys
import pickle
import bz2
import base64

hashlen                         = 64

app                             = Flask(__name__)

con                             = mysql.connector.connect (
    host        = "localhost",
    user        = "override",
    password    = "override",
    database    = "override"

)
cursor                          = con.cursor ()

def get_uuid (_email, _phone):
    if _email is not None:
        cursor.execute (f'''SELECT * FROM users WHERE email=\"{_email}\"''')

    elif _phone is not None:
        cursor.execute (f'''SELECT * FROM users WHERE phone=\"{_phone}\"''')

    else:
        return None, -1

    users   = cursor.fetchall ()
    if len (users) <= 0:
        return None, 0

    return users[0], users[0][4]

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

    # hash the password to get a fixed length string of length 64
    usr_hash = password
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

    # Insert the user into the table
    try:
        cursor.execute (f'''INSERT INTO users VALUES (
            \"{email}\",
            \"{phone}\",
            \"{name}\",
            \"{usr_hash}\",
            \"{uuid}\"
        );''')

    except:
        print (f"Error while inserting user\n{name}\n{email}\n{phone}\n{password}")
        data["msg"] = "Bad request!"
        return jsonify (data), 400

    # If the user was created successfully, return normally
    con.commit ()

    data["msg"] = "Success!"
    return jsonify (data), 201


@app.route ("/login", methods=["GET"])
def check_login ():
    """
    Checks if a user's credentials while logging in are appropriate
    Requires the user's email/phone, password

    The details must be provided as arguments in the URL in the form of the following suffix
        ?email=xyz&phone=xyz&password=xyz
    Giving either the email or hte phone number is enough
    If both are given, email takes precedence
    """

    email   = request.args.get ("email", default = None)
    phone   = request.args.get ("phone", default = None)
    password= request.args.get ("password", default = "")

    data    = {}

    users   = ()

    # hash the password to get a fixed length string of length 64
    usr_hash = password
    if len (usr_hash) < hashlen:
        usr_hash = usr_hash[:hashlen]
    elif len (usr_hash) > hashlen:
        usr_hash = (' ' * hashlen - len (usr_hash)) + usr_hash

    if email is not None:
        cursor.execute (f'''SELECT * from users where email = \"{email}\";''')
        users   = cursor.fetchall ()

    if phone is not None:
        cursor.execute (f'''SELECT * from users where phone = \"{phone}\";''')
        users   = cursor.fetchall ()

    else:
        data["msg"] = "Either phone or email must be given!"
        return jsonify (data), 400

    # the length of the returned iterable should be non-zero (a user must be found)
    if len (users) <= 0:
        data["msg"] = "No user found!"
        return jsonify (data), 400

    # the given password and stored password should match
    print (users[0][3], usr_hash)
    if users[0][3] != usr_hash:
        data["msg"] = "Incorrect Password!"
        return jsonify (data), 401

    data["msg"] = "Success!"
    return jsonify (data), 201

@app.route ("/viewfriends", methods=["GET"])
def get_friends ():
    """
    Returns the friends of a user
    """

    email   = request.args.get ("email", default = None)
    phone   = request.args.get ("phone", default = None)

    data    = {}

    if email is not None:
        cursor.execute (f'''SELECT * FROM users WHERE email=\"{email}\"''')

    elif phone is not None:
        cursor.execute (f'''SELECT * FROM users WHERE phone=\"{phone}\"''')

    else:
        data["msg"] = "Either email or phone must be given!"
        return jsonify (data), 400

    users   = cursor.fetchall ()

    if len (users) <= 0:
        data["msg"] = "No user found!"
        return jsonify (data), 400

    uuid    = users[0][4]

    cursor.execute (f'''SELECT * FROM friends WHERE uuid1 = \"{uuid}\"''')
    uuids = [relation[1] for relation in cursor.fetchall ()]

    cursor.execute (f'''SELECT * FROM friends WHERE uuid2 = \"{uuid}\"''')
    uuids += [relation[0] for relation in cursor.fetchall ()]

    data["friends"] = []

    for uuid in uuids:
        cursor.execute (f'''SELECT name, email, phone FROM users WHERE uuid=\"{uuid}\"''')
        user = cursor.fetchall ()[0]
        data["friends"].append (user)

    return jsonify (data), 201


@app.route ("/viewrequests", methods=["GET"])
def get_requests ():
    """
    Returns the friend requests of a user
    """

    email   = request.args.get ("email", default = None)
    phone   = request.args.get ("phone", default = None)

    data    = {}

    if email is not None:
        cursor.execute (f'''SELECT * FROM users WHERE email=\"{email}\"''')

    elif phone is not None:
        cursor.execute (f'''SELECT * FROM users WHERE phone=\"{phone}\"''')

    else:
        data["msg"] = "Either email or phone must be given!"
        return jsonify (data), 400

    users   = cursor.fetchall ()

    if len (users) <= 0:
        data["msg"] = "No user found!"
        return jsonify (data), 400

    uuid    = users[0][4]

    cursor.execute (f'''SELECT * FROM friend_requests WHERE receiver = \"{uuid}\"''')
    uuids = [relation[0] for relation in cursor.fetchall ()]

    data["requests"] = []

    for uuid in uuids:
        cursor.execute (f'''SELECT name, email, phone FROM users WHERE uuid=\"{uuid}\"''')
        user = cursor.fetchall ()[0]
        data["requests"].append (user)

    return jsonify (data), 201

@app.route ("/addfriend", methods=["POST"])
def add_friend ():
    """
    Accepts a friend request as specified by the user
    """

    sender_email    = request.args.get ("sender_email", default = None)
    sender_phone    = request.args.get ("sender_phone", default = None)

    receiver_email  = request.args.get ("receiver_email", default = None)
    receiver_phone  = request.args.get ("receiver_phone", default = None)

    removereq       = request.args.get ("removereq", default = "true")

    data            = {}


    if sender_email is not None:
        cursor.execute (f'''SELECT * FROM users where email=\"{sender_email}\"''')

    elif sender_phone is not None:
        cursor.execute (f'''SELECT * FROM users where phone=\"{sender_phone}\"''')

    else:
        data["msg"] = "Either email or phone must be given for sender!"
        return jsonify (data), 400

    senders         = cursor.fetchall ()
    if len (senders) <= 0:
        data["msg"] = "No user matching the sender could be found!"
        return jsonify (data), 400
    sender_uuid     = senders[0][4]


    if receiver_email is not None:
        cursor.execute (f'''SELECT * FROM users where email=\"{receiver_email}\"''')

    elif receiver_phone is not None:
        cursor.execute (f'''SELECT * FROM users where phone=\"{receiver_phone}\"''')

    else:
        data["msg"] = "Either email or phone must be given for receiver!"
        return jsonify (data), 400

    receivers      = cursor.fetchall ()
    if len (receivers) <= 0:
        data["msg"] = "No user matching the receiver could be found!"
        return jsonify (data), 400
    receiver_uuid   = receivers[0][4]

    cursor.execute (f'''SELECT * FROM friends WHERE
                        (uuid1=\"{sender_uuid}\" AND uuid2=\"{receiver_uuid}\") OR
                        (uuid2=\"{sender_uuid}\" AND uuid1=\"{receiver_uuid}\");''')

    exists = cursor.fetchall ()

    if len (exists) <= 0:
        cursor.execute (f'''INSERT INTO friends VALUES (
            \"{sender_uuid}\",
            \"{receiver_uuid}\"
        );''')
        con.commit ()

    if removereq == "true":
        cursor.execute (f'''DELETE * FROM friend_requests WHERE
                        sender=\"{sender_uuid}\" AND receiver=\"{receiver_uuid}\";''')

    data["msg"] = "Success!"
    return jsonify (data), 201

@app.route ("/remfriend", methods=["POST"])
def rem_friend ():
    """
    Ignores a friend request as specified by the user
    """

    sender_email    = request.args.get ("sender_email", default = None)
    sender_phone    = request.args.get ("sender_phone", default = None)

    receiver_email  = request.args.get ("receiver_email", default = None)
    receiver_phone  = request.args.get ("receiver_phone", default = None)

    removereq       = request.args.get ("removereq", default = "true")

    data            = {}


    if sender_email is not None:
        cursor.execute (f'''SELECT * FROM users where email=\"{sender_email}\"''')

    elif sender_phone is not None:
        cursor.execute (f'''SELECT * FROM users where phone=\"{sender_phone}\"''')

    else:
        data["msg"] = "Either email or phone must be given for sender!"
        return jsonify (data), 400

    senders         = cursor.fetchall ()
    if len (senders) <= 0:
        data["msg"] = "No user matching the sender could be found!"
        return jsonify (data), 400
    sender_uuid     = senders[0][4]


    if receiver_email is not None:
        cursor.execute (f'''SELECT * FROM users where email=\"{receiver_email}\"''')

    elif receiver_phone is not None:
        cursor.execute (f'''SELECT * FROM users where phone=\"{receiver_phone}\"''')

    else:
        data["msg"] = "Either email or phone must be given for receiver!"
        return jsonify (data), 400

    receivers      = cursor.fetchall ()
    if len (receivers) <= 0:
        data["msg"] = "No user matching the receiver could be found!"
        return jsonify (data), 400
    receiver_uuid   = receivers[0][4]

    cursor.execute (f'''SELECT * FROM friends WHERE
                        (uuid1=\"{sender_uuid}\" AND uuid2=\"{receiver_uuid}\") OR
                        (uuid2=\"{sender_uuid}\" AND uuid1=\"{receiver_uuid}\");''')

    exists = cursor.fetchall ()

    if len (exists) > 0:
        cursor.execute (f'''DELETE FROM friends WHERE
                        (uuid1=\"{sender_uuid}\" AND uuid2=\"{receiver_uuid}\") OR
                        (uuid2=\"{sender_uuid}\" AND uuid1=\"{receiver_uuid}\");''')
        con.commit ()

    if removereq == "true":
        cursor.execute (f'''DELETE * FROM friend_requests WHERE
                        sender=\"{sender_uuid}\" AND receiver=\"{receiver_uuid}\";''')

    data["msg"] = "Success!"
    return jsonify (data), 201

@app.route ("/sendrequest", methods=["POST"])
def send_request ():
    """
    Sends a request from one user to another as specified by the user
    """

    sender_email    = request.args.get ("sender_email", default = None)
    sender_phone    = request.args.get ("sender_phone", default = None)

    receiver_email  = request.args.get ("receiver_email", default = None)
    receiver_phone  = request.args.get ("receiver_phone", default = None)

    data            = {}

    if sender_email is not None:
        cursor.execute (f'''SELECT * FROM users where email=\"{sender_email}\"''')

    elif sender_phone is not None:
        cursor.execute (f'''SELECT * FROM users where phone=\"{sender_phone}\"''')

    else:
        data["msg"] = "Either email or phone must be given for sender!"
        return jsonify (data), 400

    senders         = cursor.fetchall ()
    if len (senders) <= 0:
        data["msg"] = "No user matching the sender could be found!"
        return jsonify (data), 400
    sender_uuid     = senders[0][4]


    if receiver_email is not None:
        cursor.execute (f'''SELECT * FROM users where email=\"{receiver_email}\"''')

    elif receiver_phone is not None:
        cursor.execute (f'''SELECT * FROM users where phone=\"{receiver_phone}\"''')

    else:
        data["msg"] = "Either email or phone must be given for receiver!"
        return jsonify (data), 400

    receivers      = cursor.fetchall ()
    if len (receivers) <= 0:
        data["msg"] = "No user matching the receiver could be found!"
        return jsonify (data), 400
    receiver_uuid   = receivers[0][4]

    cursor.execute (f'''SELECT * FROM friend_requests WHERE
                        sender=\"{sender_uuid}\" AND receiver=\"{receiver_uuid}\";''')
    reqs = cursor.fetchall ()

    if len (reqs) > 0:
        data["msg"] = "Already pending request!"
        return jsonify (data), 401

    cursor.execute (f'''SELECT * FROM friend_requests WHERE
                        sender=\"{receiver_uuid}\" AND receiver=\"{sender_uuid}\";''')
    reqs = cursor.fetchall ()

    if len (reqs) > 0:
        data["msg"] = "Accept incoming request instead!"
        return jsonify (data), 401

    cursor.execute (f'''INSERT INTO friend_requests VALUES (
                        \"{sender_uuid}\",
                        \"{receiver_uuid}\"
    );''')
    con.commit ()

    data["msg"] = "Success!"
    return jsonify (data), 201

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


if __name__ == "__main__":
    app.run (host = "localhost", debug = True)
    con.commit ()
    con.close ()
