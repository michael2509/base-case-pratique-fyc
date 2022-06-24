import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      title: 'Flutter Firebase',
      home: const HomePage(),
    ); // MaterialAppI
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Firebase'),
      ),
      body: HomeCardsInformations(), // AppBar
    ); // Scaffold
  }
}

class HomeCardsInformations extends StatefulWidget {
  HomeCardsInformations({Key? key}) : super(key: key);

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
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(data['image']),
        ), // Decoration Image
      ), // BoxDecoration
      child: Center(
        child: Text(
          data['name'],
          style: TextStyle(fontSize: 40, color: Colors.white),
        ), // Text
      ), // Center
    );
  }
}
