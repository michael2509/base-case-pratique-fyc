import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class StarList extends StatefulWidget {
  const StarList({Key? key}) : super(key: key);

  @override
  State<StarList> createState() => _StarList();
}

class _StarList extends State<StarList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Text("Star List"),
        ),
      ),
    );
  }
}
