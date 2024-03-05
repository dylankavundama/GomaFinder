import 'dart:async';
import 'dart:io';

import 'package:firebase_auth_example/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    super.initState();

    super.initState();
    _startNewGame();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _interstitialAd?.dispose();
    super.dispose();
    super.dispose();
  }

  InterstitialAd? _interstitialAd;
  final _gameLength = 5;
  late var _counter = _gameLength;
//intertial rj
  final String _adUnitIdd = Platform.isAndroid
      ? 'ca-app-pub-7329797350611067/7003775471'
      : 'ca-app-pub-7329797350611067/7003775471';
  @override
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
        ));
  }

  void _starTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() => _counter--);

      if (_counter == 0) {
        _interstitialAd?.show();
        timer.cancel();
      }
    });
  }

  @override
  void go() {
    setState(() {
      _interstitialAd?.show();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(children: [
          DrawerHeader(
            child: Image.asset('assets/images/logo.png'),
          ),
        ]),
        width: 250,
      ),
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
            Tab(text: 'Bureau'),
            Tab(text: 'Tech'),
            Tab(text: 'Restaurant'),
            Tab(text: 'Commerce'), //
            Tab(text: 'Hotel'), //
            Tab(text: 'Loisir'), //
            Tab(text: 'Eglise'), //
            Tab(text: 'ONG'), //
            Tab(text: 'Media'), //
            Tab(text: 'Fashion Habillement'), //
            Tab(text: 'Super marcher'), //
            Tab(text: 'Voyage'), // transport
            Tab(text: 'Banque'), //finance
            Tab(text: 'Communication'),
            Tab(text: 'Santer'), //hopital clinic
            Tab(text: 'Saloon'), //beaute
            Tab(text: 'Ecole'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          MyWidget1(),
          Center(child: Text('Content of Tab 1')),
          Center(child: Text('Content of Tab 2')),
          Center(child: Text('Content of Tab 3')),
          Center(child: Text('Content of Tab 3')),
        ],
      ),
      floatingActionButton: SpeedDial(
        // both default to 16
        // marginRight: 18,
        // marginBottom: 20,
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 22.0),
        // this is ignored if animatedIcon is non null
        // child: Icon(Icons.add),
        // If true user is forced to close dial manually
        // by tapping main button and overlay is not rendered.
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
            child: Icon(Icons.accessibility),
            backgroundColor: Colors.red,
            label: 'First',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () => print('FIRST CHILD'),
            onLongPress: () => print('FIRST CHILD LONG PRESS'),
          ),
          SpeedDialChild(
            child: Icon(Icons.brush),
            backgroundColor: Colors.blue,
            label: 'Second',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () => print('SECOND CHILD'),
            onLongPress: () => print('SECOND CHILD LONG PRESS'),
          ),
          SpeedDialChild(
            child: Icon(Icons.brush),
            backgroundColor: Colors.amberAccent,
            label: 'Second',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () => print('SECOND CHILD'),
            onLongPress: () => print('SECOND CHILD LONG PRESS'),
          ),
          SpeedDialChild(
            child: Icon(Icons.keyboard_voice),
            backgroundColor: Colors.green,
            label: 'Third',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () {},
            onLongPress: () => print('THIRD CHILD LONG PRESS'),
          ),
        ],
      ),
    );
  }
}

class MyWidget1 extends StatefulWidget {
  const MyWidget1({super.key});

  @override
  State<MyWidget1> createState() => _MyWidget1State();
}

class _MyWidget1State extends State<MyWidget1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
           
            Widget_UI(image: 'https://thumbor.forbes.com/thumbor/fit-in/900x510/https://www.forbes.com/home-improvement/wp-content/uploads/2022/07/download-23.jpg',),
            Widget_UI(image: 'https://robbreport.com/wp-content/uploads/2023/02/10644BellagioRoad193_2-1.jpg?w=1000',),
            Widget_UI(image: 'https://www.nesto.ca/wp-content/uploads/2022/05/type-of-houses-in-ca.jpg',),
    
          ],
        ),
      ),
    );
  }
}

class Detail_UI extends StatelessWidget {
  const Detail_UI({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
class Widget_UI extends StatelessWidget {
  const Widget_UI({

    required this.image,
    super.key,
  });

  final String image;
  @override
  Widget build(BuildContext context) {
    final ww = MediaQuery.of(context).size.width;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(
          color: Colors.white10, // Specify your desired border color here.
          width: 2.0,
        ),
      ),
      child: Column(
        //mainAxisSize: MainAxisSize.min,
        children: <Widget>[
 Container(
          // Prend toute la taille de l'écran
          width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.23,
          // Enfant : Image
          child: Image.network(
           image,// URL de l'image
            fit: BoxFit.cover, // Ajustement de l'image pour couvrir tout le container
          ),
        ),

          ButtonBar(
            children: <Widget>[
              SizedBox(
                height: 30,
                child: Padding(
                  padding: const EdgeInsets.only(right: 200),
                  child: Text("Airtrade Company Aviation",style: TitreStyle,),
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    color: CouleurPrincipale,
                    size: 18,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 110),
                    child: Text("Chez mode pret du rond pont ",style: SousTStyle,
              ),
                  ),
                  Text('Call',)
                ],
              ),
              // ElevatedButton(
              //   child: Text('Button 2'),
              //   onPressed: () {},
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
