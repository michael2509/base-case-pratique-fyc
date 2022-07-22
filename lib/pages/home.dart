import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/result_card.dart';
import 'package:flutter_application_1/models/tinder_card.dart';

class HomeCardsInformations extends StatefulWidget {
  const HomeCardsInformations({Key? key}) : super(key: key);

  @override
  State<HomeCardsInformations> createState() => _HomeCardsInformationsState();
}

class _HomeCardsInformationsState extends State<HomeCardsInformations> {
  final Stream<QuerySnapshot> _stream =
      FirebaseFirestore.instance.collection('home_card').snapshots();

  //int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _stream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          List? slideList = snapshot.data?.docs.map((doc) {
            return doc.data();
          }).toList();

          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('Loading...');
          }

          return PageView.builder(
            itemCount: slideList?.length,
            itemBuilder: (BuildContext context, int index) {
              return _buildStoryPage(slideList?[index]);
            },
          );
        });
  }

  _buildStoryPage(Map data) {
    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 000),
          child: Container(
            key: ValueKey<String>(data['name']),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(data['image']),
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 15,
                sigmaY: 15,
              ),
              child: Container(
                color: Colors.black.withOpacity(0.2),
              ),
            ),
          ),
        ),
        FractionallySizedBox(
            widthFactor: 0.9,
            heightFactor: 0.7,
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, data['route']);
                print("data['name'], ${data['name']}");
              },
              child: Container(
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(data['image']),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 5,
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
              ),
            )),
        if (data['name'] == 'Anime List')
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                margin: const EdgeInsets.all(50),
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.grey,
                      fixedSize: const Size(90, 100),
                      shape: const CircleBorder(),
                    ),
                    child: const Text('SignOut'))),
          )
      ],
    );
  }
}
