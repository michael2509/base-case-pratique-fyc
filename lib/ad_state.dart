import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdState {
  Future<InitializationStatus> initialization;

  AdState(this.initialization);

  String get bannerAdUnitId => Platform.isAndroid
      ? 'ca-app-pub-3544977035867186/8476856861'
      : 'ca-app-pub-3544977035867186/1249760078';

  BannerAdListener get adListener => _adListener;

  final BannerAdListener _adListener = BannerAdListener(
    onAdLoaded: (ad) => print('Ad loaded ${ad.adUnitId}'),
    onAdClosed: (ad) => print('Ad closed ${ad.adUnitId}'),
    onAdFailedToLoad: (ad, error) => print('Ad failed to load ${ad.adUnitId}'),
    onAdOpened: (ad) => print('Ad opened ${ad.adUnitId}'),
    
  );
}
