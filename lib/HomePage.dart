import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:upato/Models/autres.dart';
import 'package:upato/Models/banque.dart';
import 'package:upato/Models/bureau.dart';
import 'package:upato/Models/commerce.dart';
import 'package:upato/Models/ecole.dart';
import 'package:upato/Models/eglise.dart';
import 'package:upato/Models/entreprise.dart';
import 'package:upato/Models/hopital.dart';
import 'package:upato/Models/hotel.dart';
import 'package:upato/Models/media.dart';
import 'package:upato/Models/mode.dart';
import 'package:upato/Models/ong.dart';
import 'package:upato/Models/resto.dart';
import 'package:upato/Models/salle.dart';
import 'package:upato/Models/tech.dart';
import 'package:upato/Models/voyage.dart';
import 'package:upato/Util/style.dart';
import 'package:upato/util/drawers.dart';

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

  final String _adUnitIdd = Platform.isAndroid
      ? 'ca-app-pub-7329797350611067/7003775471'
      : 'ca-app-pub-7329797350611067/7003775471';

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
            onAdClicked: (ad) {},
          );

          _interstitialAd = ad;
        },
        onAdFailedToLoad: (LoadAdError error) {},
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
    // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.green,
        statusBarBrightness: Brightness.light,
      ),
    );
    return Scaffold(
      drawer: Container(
          width: MediaQuery.of(context).size.width * 0.6, child: Drawers()),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              iconTheme: IconThemeData(color: CouleurPrincipale),
              backgroundColor: Colors.white,
              title: Row(
                children: [
                  Text(
                    'U',
                    style: TextStyle(color: CouleurPrincipale),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 0),
                  ),
                  const Text(
                    'PATO',
                    style: TextStyle(color: Colors.black),
                  ),
                  const Icon(
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
                tabs: const [
                  Tab(text: 'Tous'),
                  Tab(text: 'Ecole'),
                  Tab(text: 'Bureau'),
                  Tab(text: 'Salle'),
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
                  Tab(text: 'Autres'), //
                ],
              ),
              floating: true,
              pinned: true,
              expandedHeight: 111.0,
              flexibleSpace: const FlexibleSpaceBar(
                  //   background: Image.network(
                  //     "",
                  //  //  "https://images.pexels.com/photos/1670045/pexels-photo-1670045.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
                  //     fit: BoxFit.cover,
                  //   ),

                  // background: Container(
                  //   child: Image.asset('assets/images/logo.png'),
                  // ),
                  ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: const [
            Entreprise_Page(),
            Ecole_Page(),
            Bureau_Page(),
            Salle_Page(),
            Resto_Page(),
            Commerce_Page(),
            Hotel_Page(),
            Hopital_Page(),
            Banque_Page(),
            Mode_Page(),
            Voyage_Page(),
            Tech_Page(),
            Ong_Page(),
            Media_Page(),
            Eglise_Page(),
            Autres_Page(),
            Center(child: Text('Content of Tab 1')),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Floating_Widget(),
    );
  }
}

class Floating_Widget extends StatefulWidget {
  const Floating_Widget({
    Key? key,
  }) : super(key: key);

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
      shape: const CircleBorder(),
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
          child: const Icon(Icons.handyman),
          backgroundColor: Colors.amber,
          label: "Main d'oeuvre",
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () {},
          onLongPress: () => print('THIRD CHILD LONG PRESS'),
        ),
        SpeedDialChild(
          child: const Icon(Icons.camera),
          backgroundColor: Colors.teal,
          label: 'Photographe',
          labelStyle: const TextStyle(fontSize: 18.0),
          onTap: () => print('SECOND CHILD'),
          onLongPress: () => print('SECOND CHILD LONG PRESS'),
        ),
      ],
    );
  }
}
