import 'package:flutter/material.dart';

void main() => runApp(FriendsPage());

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
                  onPressed: () {},
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
                    onPressed: () {},
                    child: Text('View Requests'))
              ],
            )
          ]),
    ])));
  }
}