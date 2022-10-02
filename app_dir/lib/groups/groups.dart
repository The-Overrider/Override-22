import 'package:flutter/material.dart';

void main() => runApp(GroupsPage());

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
                  onPressed: () {},
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
                    onPressed: () {},
                    child: Text('View Group Invites'))
              ],
            )
          ]),
          Text('Hello'),
    ])));
  }
}