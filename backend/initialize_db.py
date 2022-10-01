#! IMPORTANT
# create a database called override along with a user (with the same name) that is privileged to access the override database before running this program

import mysql.connector

hashlen = 64

db      = mysql.connector.connect (
    host        = "localhost",
    user        = "override",
    password    = "override",
    database    = "override"

)

cursor  = db.cursor ()

# create a table for storing users
cursor.execute (f'''CREATE TABLE users (
                    email       TEXT,
                    phone       VARCHAR (10),
                    name        TEXT,
                    password    CHAR ({hashlen}),
                    uuid        CHAR ({hashlen}),
                    PRIMARY KEY (uuid)
);''')

# add index on email and phone number
# cursor.execute (f'''CREATE INDEX user_email ON users (
#                     email
# );''')


# create table for storing group_entries
cursor.execute (f'''CREATE TABLE group_entries (
                    name        TEXT,
                    creator     CHAR ({hashlen}),
                    guid        CHAR ({hashlen}),
                    PRIMARY KEY (guid),
                    FOREIGN KEY (creator) REFERENCES users(uuid)
);''')


# create table for storing friends
cursor.execute (f'''CREATE TABLE friends (
                    uuid1       CHAR ({hashlen}),
                    uuid2       CHAR ({hashlen}),
                    FOREIGN KEY (uuid1) REFERENCES users(uuid),
                    FOREIGN KEY (uuid2) REFERENCES users(uuid),
                    PRIMARY KEY (uuid1, uuid2)
);''')


# create table for storing group information
cursor.execute (f'''CREATE TABLE group_members (
                    uuid        CHAR ({hashlen}),
                    guid        CHAR ({hashlen}),
                    FOREIGN KEY (uuid) REFERENCES users(uuid),
                    FOREIGN KEY (guid) REFERENCES group_entries(guid),
                    PRIMARY KEY (uuid, guid)
);''')

# add index for uuids to quickly query the groups of each user
cursor.execute (f'''CREATE INDEX user_groups ON group_members (
                    uuid
);''')


# create table for storing friend requests
cursor.execute (f'''CREATE TABLE friend_requests (
                    sender      CHAR ({hashlen}),
                    receiver    CHAR ({hashlen}),
                    FOREIGN KEY (sender) REFERENCES users(uuid),
                    FOREIGN KEY (receiver) REFERENCES users(uuid),
                    PRIMARY KEY (sender, receiver)
);''')

# add index for quickly querying the requests recieved by a user
cursor.execute (f'''CREATE INDEX requests_recieved ON friend_requests (
                    receiver
);''')


# create table for storing group requests
cursor.execute (f'''CREATE TABLE group_requests (
                    receiver    CHAR ({hashlen}),
                    guid        CHAR ({hashlen}),
                    FOREIGN KEY (receiver) REFERENCES users(uuid),
                    FOREIGN KEY (guid) REFERENCES group_entries(guid),
                    PRIMARY KEY (receiver, guid)
);''')

# add index for quickly querying the requests recieved by a user
cursor.execute (f'''CREATE INDEX group_requests_recieved ON group_requests (
                    receiver
);''')

db.commit ()
db.close ()
