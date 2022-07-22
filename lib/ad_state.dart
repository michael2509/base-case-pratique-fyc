import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdState {
  Future<InitializationStatus> initialization;

  AdState(this.initialization);

  String get bannerAdUnitId => Platform.isAndroid
      ? 'ca-app-pub-3544977035867186/8476856861'
      : 'ca-app-pub-3544977035867186/1249760078';
      //:'ca-app-pub-3940256099942544/2934735716';

      

  BannerAdListener get adListener => _adListener;

  final BannerAdListener _adListener = BannerAdListener(
    onAdLoaded: (ad) => print('Ad loaded ${ad.adUnitId}'),
    onAdClosed: (ad) => print('Ad closed ${ad.adUnitId}'),
    onAdFailedToLoad: (ad, error) => print('Ad failed to load ${ad.adUnitId}, error: $error'),
    onAdOpened: (ad) => print('Ad opened ${ad.adUnitId}'),
    
  );
}
