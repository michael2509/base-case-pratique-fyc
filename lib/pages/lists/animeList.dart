import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/result_card.dart';
import 'package:flutter_application_1/models/tinder_card.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

class AnimeList extends StatefulWidget {
  const AnimeList({Key? key}) : super(key: key);

  @override
  State<AnimeList> createState() => _AnimeList();
}

class _AnimeList extends State<AnimeList> {
  final Stream<QuerySnapshot> _stream =
      FirebaseFirestore.instance.collection('animes').snapshots();
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
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text('Loading...');
                }

                list.clear();
                //print(snapshot.data!.docs);
                snapshot.data!.docs.map((doc) {
                  list.add(doc.data()! as Map<String, dynamic>);
                }).toList();

                //print(list);

                list.map((item) {
                  card_list.add(TinderCard(
                    image: item['image'],
                    name: item['name'],
                    profession: item['infos'],
                    card_list: card_list,
                    collection: "animes_result",
                  ));
                }).toList();

                return Container(
                    child: Stack(
                  alignment: Alignment.center,
                  children: [
                    GestureDetector(
                      onDoubleTap: () {
                        setState(() {});
                        Navigator.pushNamed(context, '/home');
                      },
                      child: Result(collection: 'animes_result'),
                    ),
                    for (var element in card_list)
                      GestureDetector(
                        onDoubleTap: () => showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                                    title: Text(element.profession),
                                    actions: <Widget>[
                                      TextButton(
                                        style: TextButton.styleFrom(
                                            primary: Colors.green),
                                        onPressed: () =>
                                            Navigator.pop(context, 'OK'),
                                        child: const Text('OK'),
                                      ),
                                    ])),
                        child: element,
                      ),
                  ],
                ));
              })),
    );
  }
}
