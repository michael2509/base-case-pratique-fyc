import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final collection;
  Result({required this.collection});

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _stream =
        FirebaseFirestore.instance.collection(collection).snapshots();

    List<Map<String, dynamic>> list = [];
    return StreamBuilder(
        stream: _stream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
          list.sort((a, b) => b['like']!.compareTo(a['like']!));

          return Container(
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
                              color: Colors.amber[
                                  (300 + list.indexOf(_element) * 100).toInt()],
                              child: Center(
                                child: Text(_element['name'] +
                                    " " +
                                    _element['like'].toString()),
                              ),
                            ),
                        Padding(
                          padding: EdgeInsets.only(top: 30),
                          child: Column(
                            children: [
                              const Text(
                                "Double tap pour recommencer ou",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              Padding(
                                  padding: EdgeInsets.all(20),
                                  child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.grey,
                                        fixedSize: const Size(80, 70),
                                        shape: const CircleBorder(),
                                      ),
                                      child: Icon(Icons.home))),
                            ],
                          ),
                        ),
                      ],
                    )),
              ));
        });
  }
}
