import 'dart:async';
import 'dart:io';
import 'package:upato/model/banque.dart';
import 'package:upato/model/bureau.dart';
import 'package:upato/model/commerce.dart';
import 'package:upato/model/hopital.dart';
import 'package:upato/model/hotel.dart';
import 'package:upato/model/mode.dart';
import 'package:upato/model/resto.dart';
import 'package:upato/model/tech.dart';
import 'package:upato/model/voyage.dart';
import 'package:upato/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:upato/util/drawers.dart';

import 'model_home_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 18, vsync: this);
    super.initState();

    super.initState();
    _startNewGame();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _interstitialAd?.dispose();

    super.dispose();
  }

  InterstitialAd? _interstitialAd;
  final _gameLength = 5;
  late var _counter = _gameLength;
//intertial cd
  final String _adUnitIdd = Platform.isAndroid
      ? 'ca-app-pub-7329797350611067/7003775471'
      : 'ca-app-pub-7329797350611067/7003775471';
  //ca-app-pub-7329797350611067/6013028323
  void _startNewGame() {
    setState(() => _counter = _gameLength);

    _loadAdd();
    _starTimer();
  }

  void _loadAdd() {
    InterstitialAd.load(
      adUnitId: _adUnitIdd,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
              onAdShowedFullScreenContent: (ad) {},
              onAdImpression: (ad) {},
              onAdFailedToShowFullScreenContent: (ad, err) {
                ad.dispose();
              },
              onAdDismissedFullScreenContent: (ad) {
                ad.dispose();
              },
              onAdClicked: (ad) {});

          _interstitialAd = ad;
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('InterstitialAd failed to load: $error');
        },
      ),
    );
  }

  void _starTimer() {
    Timer.periodic(const Duration(seconds: 60), (timer) {
      setState(() => _counter--);

      if (_counter == 0) {
        _interstitialAd?.show();
        timer.cancel();
      }
    });
  }

  void go() {
    setState(() {
      _interstitialAd?.show();
    });
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return Scaffold(
      drawer: Drawers(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: CouleurPrincipale),
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Text(
              'U',
              style: TextStyle(color: CouleurPrincipale),
            ),
            Padding(
              padding: EdgeInsets.only(right: 0),
            ),
            Text(
              'PATO',
              style: TextStyle(color: Colors.black),
            ),
            Icon(
              Icons.location_on_outlined,
              color: Colors.black,
              size: 18,
            )
          ],
        ),
        bottom: TabBar(
          indicatorColor: CouleurPrincipale,
          labelColor: Colors.black,
          controller: _tabController,
          isScrollable: true,
          tabs: [
            Tab(text: 'Ecole'),
            Tab(text: 'Bureau'),
            Tab(text: 'Restaurant'),
            Tab(text: 'Hotel'), //
            Tab(text: 'Commerce'), //
            Tab(text: 'Hopital (Sante)'), //hopital clinic
            Tab(text: 'Banque'), //finance
            Tab(text: 'Mode & Bien etre'), // fasghion maquillage
            Tab(text: 'Voyage & Transport'), // transport
            Tab(text: 'Tech & Formation'),
            Tab(text: 'ONG'), //
            Tab(text: 'Communication(Media)'),
            Tab(text: 'Eglise'), //
            Tab(text: 'Super marcher'), //
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Mode_Home_Page(),
          Bureau_Page(),
          Resto_Page(),
          Commerce_Page(),
          Hotel_Page(),
          Hopital_Page(),
          Banque_Page(),
          Mode_Page(),
          Voyage_Page(),
          Tech_Page(),
          Center(child: Text('Content of Tab 3')),
          Center(child: Text('Content of Tab 1')),
          Center(child: Text('Content of Tab 2')),
          Center(child: Text('Content of Tab 3')),
          Center(child: Text('Content of Tab 3')),
          Center(child: Text('Content of Tab 1')),
          Center(child: Text('Content of Tab 2')),
          Center(child: Text('Content of Tab 3')),
          Center(child: Text('Content of Tab 3')),
          Center(child: Text('Content of Tab 1')),
          Center(child: Text('Content of Tab 2')),
          Center(child: Text('Content of Tab 3')),
          Center(child: Text('Content of Tab 3')),
          Center(child: Text('Content of Tab 3')),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Floating_Widget(),
    );
  }
}

class Floating_Widget extends StatefulWidget {
  const Floating_Widget({
    super.key,
  });

  @override
  State<Floating_Widget> createState() => _Floating_WidgetState();
}

class _Floating_WidgetState extends State<Floating_Widget> {
  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      animatedIcon: AnimatedIcons.view_list,
      animatedIconTheme: IconThemeData(size: 22.0),
      closeManually: false,
      curve: Curves.bounceIn,
      overlayColor: Colors.black,
      overlayOpacity: 0.5,
      onOpen: () => print('OPENING DIAL'),
      onClose: () => print('DIAL CLOSED'),
      tooltip: 'Speed Dial',
      heroTag: 'speed-dial-hero-tag',
      backgroundColor: CouleurPrincipale,
      foregroundColor: Colors.white,
      elevation: 8.0,
      shape: CircleBorder(),
      children: [
        SpeedDialChild(
          child: Icon(Icons.keyboard_voice),
          backgroundColor: Colors.lightBlueAccent,
          label: 'MC',
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () {},
          onLongPress: () => print('THIRD CHILD LONG PRESS'),
        ),
        SpeedDialChild(
          child: Icon(Icons.work),
          backgroundColor: Colors.blue,
          label: 'Djema',
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () => print('SECOND CHILD'),
          onLongPress: () => print('SECOND CHILD LONG PRESS'),
        ),
        SpeedDialChild(
          child: Icon(Icons.hail_outlined),
          backgroundColor: Colors.brown,
          label: "Decorateur",
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () {},
          onLongPress: () => print('THIRD CHILD LONG PRESS'),
        ),
        SpeedDialChild(
          child: Icon(Icons.handyman),
          backgroundColor: Colors.amber,
          label: "Main d'oeuvre",
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () {},
          onLongPress: () => print('THIRD CHILD LONG PRESS'),
        ),
        SpeedDialChild(
          child: Icon(Icons.camera),
          backgroundColor: Colors.teal,
          label: 'Photographe',
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () => print('SECOND CHILD'),
          onLongPress: () => print('SECOND CHILD LONG PRESS'),
        ),
      ],
    );
  }
}
