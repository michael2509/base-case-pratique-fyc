import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_application_1/models/tinder_card.dart';
import 'package:flutter_swipable/flutter_swipable.dart';

class AnimeList extends StatefulWidget {
  const AnimeList({Key? key}) : super(key: key);

  @override
  State<AnimeList> createState() => _AnimeList();
}

class _AnimeList extends State<AnimeList> {
  final Stream<QuerySnapshot> _stream =
      FirebaseFirestore.instance.collection('avatars').snapshots();
  List<TinderCard> card_list = [];
  List<Map<String, dynamic>> list = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: StreamBuilder(
              stream: _stream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                List? slideList = snapshot.data?.docs.map((doc) {
                  return doc.data();
                }).toList();

                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text('Loading...');
                }
                list.clear();
                snapshot.data!.docs.map((doc) {
                  list.add(doc.data()! as Map<String, dynamic>);
                }).toList();

                list.sort((a, b) => b['true'].compareTo(a['true']));

                print(list);

                list.map((item) {
                  card_list.add(TinderCard(
                    image: item['image'],
                    name: item['name'],
                  ));
                }).toList();
                return Container(
                    child: Stack(
                  alignment: Alignment.center,
                  children: [
                    GestureDetector(
                      onDoubleTap: () {
                        setState(() {});
                        /*Navigator.pushNamed(context, '/home');
                        Navigator.pushNamed(context, '/animeList');*/
                      },
                      child: Container(
                          height: 500,
                          width: 300,
                          child: Center(
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.purple[400]),
                                height: 400,
                                width: 300,
                                //color: Colors.amber,
                                child: ListView(
                                  padding: const EdgeInsets.all(30),
                                  children: <Widget>[
                                    const Padding(
                                      padding: EdgeInsets.only(bottom: 20),
                                      child: Text(
                                        "PODIUM",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                    for (var _element in list)
                                      if (list.indexOf(_element) < 3)
                                        Container(
                                          height: 50,
                                          width: 100,
                                          color: Colors.amber[(300 +
                                                  list.indexOf(_element) * 100)
                                              .toInt()],
                                          child: Center(
                                            child: Text(_element['name'] +
                                                _element['true'].toString()),
                                          ),
                                        ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 20),
                                      child: Column(
                                        children: const [
                                          Text("button1"),
                                          Text("button2"),
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                          )),
                    ),
                    //for (var element in card_list) element
                  ],
                ));
              })),
    );
  }
}
