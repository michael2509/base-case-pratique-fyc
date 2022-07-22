import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/ad_state.dart';
import 'package:flutter_application_1/check_auth.dart';
import 'package:flutter_application_1/pages/lists/animeList.dart';
import 'package:flutter_application_1/pages/lists/heroesList.dart';
import 'package:flutter_application_1/pages/lists/rapList.dart';
import 'package:flutter_application_1/pages/lists/starList.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final initFuture = MobileAds.instance.initialize();
  final adState = AdState(initFuture);
  await Firebase.initializeApp();
  runApp(
    Provider.value(value: adState, builder: (context, child) => const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      title: 'Flutter Firebase',
      home: const HomePage(),
      routes: {
        '/home':(context) => const HomePage(),
        '/starList': (context) => const StarList(),
        '/animeList': (context) => const AnimeList(),
        '/heroesList': (context) => const HeroesList(),
        '/rapfr':(context) => const RapList(),
        //'/carousel': (context) => AwesomeCarousel(),
      },
    ); // MaterialAppI
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  Scaffold(body: Check()); // Scaffold
  }
}