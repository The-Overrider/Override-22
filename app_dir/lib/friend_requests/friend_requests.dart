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