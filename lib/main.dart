import 'dart:ui';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_application_1/pages/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class Image {
  late String image;
  late String name;

  Image({
    required this.image,
    required this.name,
  });
  
  static Map<String, dynamic> from(Object? value) {
    if (value == null) return {};
    if (value is Image) return from(value.toJson());
    if (value is Map) {
      return {
        'image': value['image'],
        'name': value['name'],
      };
    }
    throw Exception('Invalid object type: ${value.runtimeType}');
  }
  
  Object? toJson() {
    return {
      'image': image,
      'name': name,
    };
  }
}

class _MyHomePageState extends State<MyHomePage> {
  final _database = FirebaseDatabase.instance.ref();
  List<Map<String, dynamic>> list = [];

  @override
  void initState() {
    super.initState();
    showData();
  }

  showData() async {
    var i = 0;
    var index = 0;
    while (i == 0) {
      final snapshot = await _database.child("home_card/$index").get();
      if (snapshot.exists) {
        print(snapshot.value);
        list.add(Image.from(snapshot.value));
        index++;
      } else {
        print("No data");
        i++;
      }
    }

    /*_database.child("home_card").onValue.listen((event) {
      final list2 = event.snapshot.value;
      setState(() {
        list = list2;
        print(list.runtimeType);
      });
    });*/
  }
  //item = event.snapshot.value;

  //return item;

  //List<Image> images = [];

  List<Image> data = [
    Image(
      name: "image 1",
      image:
          "https://cdn.dribbble.com/users/3281732/screenshots/8159457/media/9e7bfb83b0bd704e941baa7a44282b22.jpg?compress=1&resize=600x600",
    ),
    Image(
      name: "image 2",
      image:
          "https://cdn.dribbble.com/users/3281732/screenshots/7012328/media/bcd672685071ca4da27d5f3ea44ac5db.jpg?compress=1&resize=600x600",
    ),
    Image(
      name: "image 3",
      image:
          "https://cdn.dribbble.com/users/3281732/screenshots/6727912/samji_illustrator.jpeg?compress=1&resize=600x600",
    ),
    Image(
      name: "image 4",
      image:
          "https://cdn.dribbble.com/users/3281732/screenshots/10940512/media/b2a8ea95c550e5f09d0ca07682a3c0da.jpg?compress=1&resize=600x600",
    ),
    Image(
      name: "image 5",
      image:
          "https://cdn.dribbble.com/users/3281732/screenshots/8616916/media/a7e39b15640f8883212421d134013e38.jpg?compress=1&resize=600x600",
    ),
    Image(
      name: "image 6",
      image:
          "https://cdn.dribbble.com/users/3281732/screenshots/6590709/samji_illustrator.jpg?compress=1&resize=600x600",
    ),
  ];

  int _currentPage = 0;
  @override
  Widget build(BuildContext context) {
    //showData();
    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedSwitcher(
          duration: Duration(milliseconds: 500),
          child: Container(
            key: ValueKey<String>(data[_currentPage].image),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(data[_currentPage].image),
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
          heightFactor: 0.7,
          child: PageView.builder(
            itemCount: data.length,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            itemBuilder: (BuildContext context, int index) {
              return FractionallySizedBox(
                widthFactor: 0.8,
                child: Container(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 400,
                        ),
                        Text(
                          list[_currentPage]['name'],
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              decoration: TextDecoration.none),
                        ),
                      ]),
                  //margin: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(data[index].image),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(32),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 5,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
