import 'package:flutter/material.dart';

void main(){
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TodoList(),
    );

  }
}

class TodoList extends StatefulWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
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
                  // Respond to button press
                },
              ),
            )

          ],
        )




    );


  }
}