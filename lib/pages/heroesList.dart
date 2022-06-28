import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class HeroesList extends StatefulWidget {
  const HeroesList({Key? key}) : super(key: key);

  @override
  State<HeroesList> createState() => _HeroesList();
}

class _HeroesList extends State<HeroesList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/animeList');
          },
          child: Text("Heroes List"),
        ),
      ),
    );
  }
}
