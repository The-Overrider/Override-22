import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(
      MaterialApp(
          home: CalendarApp()
      )
  );
}

String EMAIL  = "";
String PHONE  = "";
String NAME   = "";

class CalendarApp extends StatefulWidget {
  @override
  _CalendarAppState createState() => _CalendarAppState();
}

class _CalendarAppState extends State<CalendarApp> {
  TextEditingController textController1 = TextEditingController();
  TextEditingController textController2 = TextEditingController();
  
  String email = "";
  String pwd = "";

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Container(
              //   width: width,
              //   height: height*0.45,
              //   child: Image.asset('assets/Calendar.jpg',fit: BoxFit.fill,),
              // ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Login', style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
              SizedBox(height: 25.0,),
              TextField(
                controller: textController1,
                decoration: InputDecoration(
                  hintText: 'Email',
                  suffixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              SizedBox(height: 20.0,),
              TextField(
                obscureText: true,
                controller: textController2,
                decoration: InputDecoration(
                  hintText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              SizedBox(height: 25.0,),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      child: Text('Login'),
                      onPressed: (){
                        setState((){
                          email = textController1.text;
                          pwd = textController2.text;
        
                        });

                        EMAIL = textController1.text;
                        PHONE = textController2.text;

                        // Navigator.push(
                        //      context,
                        //       MaterialPageRoute(
                        //      builder: (context)=>Calendar()),
                        // );
                        var response = http.get(Uri.parse('http://localhost:5000/login?password=${pwd}&email=${email}'));
                        response.then((resp) {
                          if (resp.statusCode == 201) {
                          // If the server did return a 201 OK response,
                          // then parse the JSON.
                          print("Success");
                          Navigator.push(
                            context,
                             MaterialPageRoute(
                            builder: (context)=>Calendar()),
                          );
                        }
                        else if (resp.statusCode == 400) {
                          print('User does not exist');
                          showAlertDialog(BuildContext context) {
                            // set up the button
                            Widget okButton = TextButton(
                              child: Text("OK"),
                              onPressed: () { },
                            );

                            // set up the AlertDialog
                            AlertDialog alert = AlertDialog(
                              title: Text("Error"),
                              content: Text("User does not exist."),
                              actions: [
                                okButton,
                              ],
                            );
                            // show the dialog
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return alert;
                              },
                            );
                          }
                        }

                        else if (resp.statusCode == 401) {
                          print("Incorrect Details");
                        }
                          showAlertDialog(BuildContext context) {
                            // set up the button
                            Widget okButton = TextButton(
                              child: Text("OK"),
                              onPressed: () {},
                            );

                            // set up the AlertDialog
                            AlertDialog alert = AlertDialog(
                              title: Text("Error"),
                              content: Text("Incorrect details entered."),
                              actions: [
                                okButton,
                              ],
                            );

                            // show the dialog
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return alert;
                              },
                            );
                          }
                        }
                      );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height:20.0),
              GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context)=>Register()
                    ),
                  );
                },
                child: Text.rich(
                  TextSpan(
                      text: "Don't have an account?",
                      children: [
                        TextSpan(
                          text: ' Sign Up',
                          style: TextStyle(
                              color: Color(0xff0390fc)
                          ),

                        ),
                      ]
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController textController1 = TextEditingController();
  TextEditingController textController2 = TextEditingController();
  TextEditingController textController3 = TextEditingController();
  TextEditingController textController4 = TextEditingController();
  String email = "";
  int phone = 0;
  String name = "";
  String pwd = "";

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Container(
              //   width: width,
              //   height: height*0.45,
              //   child: Image.asset('assets/Calendar.jpg', fit: BoxFit.fill,),
              // ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Register',style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
              SizedBox(height: 20.0,),
              TextField(
                controller: textController1,
                decoration: InputDecoration(
                  hintText: 'Email',
                  suffixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              SizedBox(height: 20.0,),
              TextField(
                controller: textController2,
                decoration: InputDecoration(
                  hintText: 'Phone Number',
                  suffixIcon: Icon(Icons.call),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              SizedBox(height: 20.0,),
              TextField(
                controller: textController3,
                decoration: InputDecoration(
                  hintText: 'Name',
                  suffixIcon: Icon(Icons.call),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              SizedBox(height: 20.0,),
              TextField(
                controller: textController4,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              SizedBox(height: 25.0,),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      child: Text('Sign Up'),
                      onPressed: (){
                        setState(() {
                          email = textController1.text;
                          phone = int.parse(textController2.text);
                          name = textController3.text;
                          pwd = textController4.text;
                        });
                        
                        var response = http.post(Uri.parse('http://localhost:5000/register?name=${name}&password=${pwd}&email=${email}&phone=${phone}'));
                        response.then((resp) {
                          if (resp.statusCode == 201) {
                          // If the server did return a 201 OK response,
                          // then parse the JSON.
                          print("Success");
                          Navigator.push(
                            context,
                             MaterialPageRoute(
                            builder: (context)=>CalendarApp()),
                          );
                        }
                        else {
                          // If the server did not return a 201 OK response,
                          // then throw an exception.
                          print("Failed. User exists");
                          showAlertDialog(BuildContext context) {
                            // set up the button
                            Widget okButton = TextButton(
                              child: Text("OK"),
                              onPressed: () { },
                            );

                            // set up the AlertDialog
                            AlertDialog alert = AlertDialog(
                              title: Text("Error"),
                              content: Text("User already exists."),
                              actions: [
                                okButton,
                              ],
                            );

                            // show the dialog
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return alert;
                              },
                            );
                          }
                        }
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height:20.0),
              GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context)=>CalendarApp()
                  ),
                  );
                },
                child: Text.rich(
                  TextSpan(
                      text: 'Already have an account?',
                      children: [
                        TextSpan(
                          text: ' Log In',
                          style: TextStyle(
                              color: Color(0xff0390fc)
                          ),
                        ),
                      ]
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class Album {
//   final String email;
//   final int phone;
//   final String name;
//   final String pwd;

//   const Album({
//     required this.email,
//     required this.phone,
//     required this.name,
//     required this.pwd,
//   });

//   factory Album.fromJson(Map<String, dynamic> json) {
//     return Album(
//       email: json['email'],
//       phone: json['phone'],
//       name: json['name'],
//       pwd: json['pwd'],
//     );
//   }
// }

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOn;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('Your Calendar'),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:[
                    Column(
                        children:[
                          TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                                fixedSize: Size(150,50),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                    builder: (context)=>FriendsPage()),
                                );
                              },
                              child: Text('Friends'))
                        ]
                    ),
                    Column(
                      children: [
                        TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                              fixedSize: Size(150,50),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context)=>GroupsPage()),
                              );
                            },
                            child: Text('Groups'))
                      ],
                    )
                  ]
              ),
              Padding(
                padding: const EdgeInsets.all(30),
                child: Text('Your Calendar For This Month',
                    style: TextStyle(fontSize:24, fontWeight: FontWeight.bold), textAlign: TextAlign.center),

              ),

              TableCalendar(
                firstDay: DateTime.utc(2022, 10, 01),
                lastDay: DateTime.utc(2022, 11, 01),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                rangeStartDay: _rangeStart,
                rangeEndDay: _rangeEnd,
                calendarFormat: _calendarFormat,
                rangeSelectionMode: _rangeSelectionMode,
                onDaySelected: (selectedDay, focusedDay) {
                  if (!isSameDay(_selectedDay, selectedDay)) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                      _rangeStart = null; // Important to clean those
                      _rangeEnd = null;
                      _rangeSelectionMode = RangeSelectionMode.toggledOff;
                    });
                  }
                },
                onRangeSelected: (start, end, focusedDay) {
                  setState(() {
                    _selectedDay = null;
                    _focusedDay = focusedDay;
                    _rangeStart = start;
                    _rangeEnd = end;
                    _rangeSelectionMode = RangeSelectionMode.toggledOn;
                  });
                },

                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay;
                },
              ),

              Text('At the start of every month, you will recieve an email with a list of days where you are free',
                style: TextStyle(fontSize:14), ),
            ],
          )
      ),
    );
  }
}

class GroupsPage extends StatefulWidget {
  const GroupsPage({super.key});

  @override
  State<GroupsPage> createState() => _GroupsPageState();
}

class _GroupsPageState extends State<GroupsPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: Column(children: [
              Text('Groups',
                  style: TextStyle(fontSize: 25,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                Column(children: [
                  TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        fixedSize: Size(150, 50),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                            builder: (context)=>CreateGroup()),
                        );
                      },
                      child: Text('Create Group'))
                ]),
                Column(
                  children: [
                    TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          fixedSize: Size(150, 50),
                        ),
                        onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                            builder: (context)=>GroupInvites()),
                        );},
                        child: Text('View Group Invites'))
                  ],
                )
              ]),
              // Text("Friend 1"),
              // Text("Friend 1"),
              // Text("Friend 1"),
              // Text("Friend 1")
            ])));
  }
}

class CreateGroup extends StatefulWidget {
  @override
  CreateGroup_State createState() => CreateGroup_State();
}

class CreateGroup_State extends State<CreateGroup> {
  bool? firstvalue = false;
  bool? secondvalue = false;

  final List<String> names = <String>['Aby', 'Aish', 'Ayan', 'Ben', 'Bob', 'Charlie', 'Cook', 'Carline'];
  final List<int> msgCount = <int>[2, 0, 10, 6, 52, 4, 0, 2];
  TextEditingController nameController = TextEditingController();

  void addItemToList(){
    setState(() {
      names.insert(0,nameController.text);
      msgCount.insert(0, 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Create a New Group'),
        ),
        body: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(20),
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter a Group name',
                  ),
                ),
              ),

              Text(
                "Select the members for this group: ",
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.blueAccent),
              ),

             Row(
                 children: <Widget>[
                    Text("friend1"),
                    Checkbox(
                      value: firstvalue,
                      checkColor: Colors.white,
                      activeColor: Colors.green,
                      onChanged: (bool? value1){
                        setState(() {
                          firstvalue = value1;
                        });
                      },
                    ),

                  ]
              ),

              Row(
                  children: <Widget>[
                    Text("friend2"),
                    Checkbox(
                      value: secondvalue,
                      checkColor: Colors.white,
                      activeColor: Colors.green,
                      onChanged: (bool? value1){
                        setState(() {
                          secondvalue = value1;
                        });
                      },
                    ),
                  ]
              ),

              Padding(
                padding: EdgeInsets.all(32),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(200,40),
                    textStyle: TextStyle(fontSize: 16),

                  ),
                  child: Text("Create Group"),
                  onPressed: () {
                    // Respond to button press
                  },
                ),
              ),
            ]
        )
    );
  }
}

class FriendsPage extends StatefulWidget {
  const FriendsPage({super.key});

  @override
  State<FriendsPage> createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: Column(children: [
              Text('Friends',
                  style: TextStyle(fontSize: 24,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                Column(children: [
                  TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        fixedSize: Size(150, 50),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                            builder: (context)=>AddFriends()),
                        );
                      },
                      child: Text('Add Friends'))
                ]),
                Column(
                  children: [
                    TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          fixedSize: Size(150, 50),
                        ),
                        onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                            builder: (context)=>FriendRequestsPage()),
                          );
                        },
                        child: Text('View Requests'))
                  ],
                )
              ]),
            ]
          )
        )
      );
  }
}

class AddFriends extends StatelessWidget {
  const AddFriends({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AddPage(),
    );

  }
}

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  String email = "";
  TextEditingController addFriend = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(' Add Friends '),),
        body: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20),
              
              child: TextField(
                controller: addFriend,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Enter email id",
                  )
              ),
            ),

            Padding(
              padding: EdgeInsets.all(32),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(200,40),
                  textStyle: TextStyle(fontSize: 16),

                ),
                child: Text("Add Friend"),
                onPressed: () {

                  setState((){
                          email = addFriend.text;
                        });
                  var response = http.post(Uri.parse('http://localhost:5000/sendrequest?sender_email=${EMAIL}&receiver_email=${email}'));

                  response.then ((resp) {
                    if (resp.statusCode == 201) {
                      print ("Successfully sent friend request");
                    }
                    else {
                      print ("No such user exists");
                    }
                  });
                },
              ),
            )
          ],
        )
    );
  }
}

class FriendRequestsPage extends StatelessWidget {
  const FriendRequestsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FriendRequests(),
    );

  }
}

class FriendRequests extends StatefulWidget {
  const FriendRequests({Key? key}) : super(key: key);

  @override
  State<FriendRequests> createState() => _FriendRequestsState();
}

class _FriendRequestsState extends State<FriendRequests> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Friend Requests'),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[

            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:<Widget>[
                  Padding(padding: EdgeInsets.all(0),),
                  Text("Friend 1", style: TextStyle(fontSize: 22),),

                  ElevatedButton(
                      style:ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.green),
                        padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                        textStyle: MaterialStateProperty.all(TextStyle(fontSize: 16)),
                      ),
                      onPressed: (){},
                      child: Text('accept')),

                  ElevatedButton(
                      style:ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blueGrey),
                        padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                        textStyle: MaterialStateProperty.all(TextStyle(fontSize: 16)),
                      ),
                      onPressed: (){},
                      child: Text('decline')),


                ]

            ),

            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:<Widget>[
                  Padding(padding: EdgeInsets.all(0),),
                  Text("Friend 2", style: TextStyle(fontSize: 22),),

                  ElevatedButton(
                      style:ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.green),
                        padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                        textStyle: MaterialStateProperty.all(TextStyle(fontSize: 16)),
                      ),
                      onPressed: (){},
                      child: Text('accept')),

                  ElevatedButton(
                      style:ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blueGrey),
                        padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                        textStyle: MaterialStateProperty.all(TextStyle(fontSize: 16)),
                      ),
                      onPressed: (){},
                      child: Text('decline')),


                ]

            ),

            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:<Widget>[
                  Padding(padding: EdgeInsets.all(0),),
                  Text("Friend 3", style: TextStyle(fontSize: 22),),

                  ElevatedButton(
                      style:ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.green),
                        padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                        textStyle: MaterialStateProperty.all(TextStyle(fontSize: 16)),
                      ),
                      onPressed: (){},
                      child: Text('accept')),


                  ElevatedButton(
                      style:ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blueGrey),
                        padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                        textStyle: MaterialStateProperty.all(TextStyle(fontSize: 16)),
                      ),
                      onPressed: (){},
                      child: Text('decline')),


                ]

            ),

            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:<Widget>[
                  Padding(padding: EdgeInsets.all(0),),
                  Text("Friend 4", style: TextStyle(fontSize: 22),),

                  ElevatedButton(
                      style:ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.green),
                        padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                        textStyle: MaterialStateProperty.all(TextStyle(fontSize: 16)),
                      ),
                      onPressed: (){},
                      child: Text('accept')),

                  ElevatedButton(
                      style:ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blueGrey),
                        padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                        textStyle: MaterialStateProperty.all(TextStyle(fontSize: 16)),
                      ),
                      onPressed: (){},
                      child: Text('decline')),
                ]
            ),
          ]
      ),
    );
  }
}

class GroupInvites extends StatelessWidget {
  const GroupInvites({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GroupInvitesPage(),
    );

  }
}

class GroupInvitesPage extends StatefulWidget {
  const GroupInvitesPage ({Key? key}) : super(key: key);

  @override
  State<GroupInvitesPage> createState() => _GroupInvitesPageState();
}

class _GroupInvitesPageState extends State<GroupInvitesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Group Invites'),
    ),
          body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[

                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children:<Widget>[
                      Padding(padding: EdgeInsets.all(0),),
                      Text("Group 1", style: TextStyle(fontSize: 22),),

                      ElevatedButton(
                          style:ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.green),
                            padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                            textStyle: MaterialStateProperty.all(TextStyle(fontSize: 16)),
                          ),
                          onPressed: (){},
                          child: Text('accept')),

                      ElevatedButton(
                          style:ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.blueGrey),
                            padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                            textStyle: MaterialStateProperty.all(TextStyle(fontSize: 16)),
                          ),
                          onPressed: (){},
                          child: Text('decline')),
                    ]
                ),

                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children:<Widget>[
                      Padding(padding: EdgeInsets.all(0),),
                      Text("Group 2", style: TextStyle(fontSize: 22),),

                      ElevatedButton(
                          style:ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.green),
                            padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                            textStyle: MaterialStateProperty.all(TextStyle(fontSize: 16)),
                          ),
                          onPressed: (){},
                          child: Text('accept')),

                      ElevatedButton(
                          style:ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.blueGrey),
                            padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                            textStyle: MaterialStateProperty.all(TextStyle(fontSize: 16)),
                          ),
                          onPressed: (){},
                          child: Text('decline')),
                    ]
                ),

                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children:<Widget>[
                      Padding(padding: EdgeInsets.all(0),),
                      Text("Group 3", style: TextStyle(fontSize: 22),),

                      ElevatedButton(
                          style:ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.green),
                            padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                            textStyle: MaterialStateProperty.all(TextStyle(fontSize: 16)),
                          ),
                          onPressed: (){},
                          child: Text('accept')),

                      ElevatedButton(
                          style:ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.blueGrey),
                            padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                            textStyle: MaterialStateProperty.all(TextStyle(fontSize: 16)),
                          ),
                          onPressed: (){},
                          child: Text('decline')),
                    ]
                ),

                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children:<Widget>[
                      Padding(padding: EdgeInsets.all(0),),
                      Text("Group 4", style: TextStyle(fontSize: 22),),

                      ElevatedButton(
                          style:ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.green),
                            padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                            textStyle: MaterialStateProperty.all(TextStyle(fontSize: 16)),
                          ),
                          onPressed: (){},
                          child: Text('accept')),

                      ElevatedButton(
                          style:ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.blueGrey),
                            padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                            textStyle: MaterialStateProperty.all(TextStyle(fontSize: 16)),
                          ),
                          onPressed: (){},
                          child: Text('decline')),
                    ]
                ),
              ]
          ),
    );
  }
}