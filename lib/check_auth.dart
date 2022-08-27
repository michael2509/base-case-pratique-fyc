import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/home.dart';
import 'package:flutter_application_1/pages/login_register/login.dart';

class Check extends StatelessWidget {
  Check({Key? key}) : super(key: key);
  final fb = FirebaseDatabase.instance;

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
