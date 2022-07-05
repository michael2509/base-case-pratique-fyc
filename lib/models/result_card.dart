import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Result extends StatefulWidget {
  const Result({Key? key}) : super(key: key);

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  final Stream<QuerySnapshot> _stream =
      FirebaseFirestore.instance.collection('avatar_result').snapshots();

  List<Map<String, dynamic>> list = [];

  @override
  Widget build(BuildContext context) {
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
          list.sort((a, b) => b['true']!.compareTo(a['true']!));

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
                                child: Text(_element['name'] + " " +
                                    _element['true'].toString()),
                              ),
                            ),
                        Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Column(
                            children: const [
                              Text("button1 result"),
                              Text("button2 result"),
                            ],
                          ),
                        ),
                      ],
                    )),
              ));
        });
  }
}
