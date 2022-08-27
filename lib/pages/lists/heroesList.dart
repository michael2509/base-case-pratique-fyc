import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/ad_state.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import '../../models/result_card.dart';
import '../../models/tinder_card.dart';

class HeroesList extends StatefulWidget {
  const HeroesList({Key? key}) : super(key: key);

  @override
  State<HeroesList> createState() => _HeroesList();
}

class _HeroesList extends State<HeroesList> {
    final Stream<QuerySnapshot> _stream =
      FirebaseFirestore.instance.collection('heroes').snapshots();
  List<TinderCard> card_list = [];
  List<Map<String, dynamic>> list = [];
  late BannerAd banner;

   @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final adState = Provider.of<AdState>(context);
    adState.initialization.then((status) {
      setState(() {
        banner = BannerAd(
            size: AdSize.banner,
            adUnitId: adState.bannerAdUnitId,
            request: const AdRequest(),
            listener: adState.adListener)
          ..load();
      });
    });
  }

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
                    profession: item['profession'],
                    card_list: card_list,
                    collection: "heroes_result",
                  ));
                }).toList();

                return Container(
                    child: Stack(
                  alignment: Alignment.center,
                  children: [
                    GestureDetector(
                      onDoubleTap: () {
                        setState(() {});
                      },
                      child: Result( collection: 'heroes_result'),
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
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        width: 320, height: 100,
                        child: AdWidget(ad: banner),
                      ),
                    )
                  ],
                ));
              })),
    );
  }

}
