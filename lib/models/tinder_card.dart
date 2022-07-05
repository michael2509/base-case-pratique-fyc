import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipable/flutter_swipable.dart';

class TinderCard extends StatelessWidget {
  final image;
  final name;
  final List card_list;
  final profession;
  final collection;
  TinderCard(
      {required this.image,
      required this.name,
      required this.card_list,
      required this.profession,
      required this.collection});

  @override
  Widget build(BuildContext context) {
    final doc = FirebaseFirestore.instance.collection(collection).doc(name);

    return Container(
        height: 600,
        width: 300,
        child: Center(
            child: Swipable(
          onSwipeRight: (finalPosition) {
            //print('right');
            doc.update({'true': FieldValue.increment(1)});
            //card_list.removeWhere((item) => item.name == name);
            //print(card_list);
          },
          onSwipeLeft: (finalPosition) {
            //print('left');
            //doc.update({'false': FieldValue.increment(1)});
            //card_list.removeWhere((item) => item.name == name);
            //print(card_list);
          },
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.amber,
                  image: DecorationImage(
                    image: NetworkImage(image.toString()),
                    fit: BoxFit.cover,
                  )),
              height: 500,
              width: 300,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: const EdgeInsets.all(5),
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.grey,
                      fixedSize: const Size(70, 70),
                      shape: const CircleBorder(),
                    ),
                    onPressed: () => showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                                title: Text(profession),
                                actions: <Widget>[
                                  TextButton(
                                    style: TextButton.styleFrom(
                                        primary: Colors.green),
                                    onPressed: () =>
                                        Navigator.pop(context, 'OK'),
                                    child: const Text('OK'),
                                  ),
                                ])),
                    child: const Icon(Icons.question_mark_outlined),
                  ),
                ),
              )),
        )));
  }
}
