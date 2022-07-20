import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/home.dart';
import 'package:flutter_application_1/pages/login_register/login.dart';

class Check extends StatelessWidget {
  Check({Key? key}) : super(key: key);
  final fb = FirebaseDatabase.instance;

  @override
  void initState() async {
    print("initState");
    final ref = fb.ref().child('users');
    final snapshot = await ref.get();
    if (snapshot.exists) {
      print(snapshot.value);
    } else {
      print('No data available.');
    }
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print(snapshot.data?.email);
              return const HomeCardsInformations();
            } else {
              return Login();
            }
          }), // StreamBuilder
    ); // Scaffold
  }
}
