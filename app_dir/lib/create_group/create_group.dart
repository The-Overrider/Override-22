import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _State createState() => _State();
}


class _State extends State<MyApp> {
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

              Text("Select the members for this group: ", textAlign: TextAlign.left, style: TextStyle(color: Colors.blueAccent),),


              /*Padding(
                padding: EdgeInsets.all(20),
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Contact Name',
                  ),
                ),
              ),*/


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
              )



            ]
        )
    );
  }
}