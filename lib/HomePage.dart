import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:upato/Detail_UI.dart';
import 'package:upato/UI.dart';
import 'package:upato/detailpage.dart';
import 'package:upato/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
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
    super.dispose();
  }

  InterstitialAd? _interstitialAd;
  final _gameLength = 5;
  late var _counter = _gameLength;
//intertial cd
  final String _adUnitIdd = Platform.isAndroid
      ? 'ca-app-pub-7329797350611067/7003775471'
      : 'ca-app-pub-7329797350611067/7025361747';
  //ca-app-pub-7329797350611067/6013028323
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
          Card(
            child: ListTile(
              title: Text(
                'Actualité',
                style: TitreStyle,
              ),
              trailing:
                  Icon(Icons.arrow_circle_right, color: CouleurPrincipale),
            ),
          ),
          Card(
            child: ListTile(
              title: Text(
                'Evénement',
                style: TitreStyle,
              ),
              trailing:
                  Icon(Icons.arrow_circle_right, color: CouleurPrincipale),
            ),
          ),
          Card(
            child: ListTile(
              title: Text(
                'Visite Goma',
                style: TitreStyle,
              ),
              trailing:
                  Icon(Icons.arrow_circle_right, color: CouleurPrincipale),
            ),
          ),
          Card(
            child: ListTile(
              title: Text(
                'Artiste & Influenceur',
                style: TitreStyle,
              ),
              trailing:
                  Icon(Icons.arrow_circle_right, color: CouleurPrincipale),
            ),
          ),
          Card(
            child: ListTile(
              title: Text(
                'Football Club',
                style: TitreStyle,
              ),
              trailing:
                  Icon(Icons.arrow_circle_right, color: CouleurPrincipale),
            ),
          ),
          Card(
            child: ListTile(
              title: Text(
                'Podcast',
                style: TitreStyle,
              ),
              trailing:
                  Icon(Icons.arrow_circle_right, color: CouleurPrincipale),
            ),
          ),
          Card(
            child: ListTile(
              title: Text(
                'Live Tv',
                style: TitreStyle,
              ),
              trailing:
                  Icon(Icons.arrow_circle_right, color: CouleurPrincipale),
            ),
          ),
          Card(
            child: ListTile(
              title: Text(
                'Live Radio',
                style: TitreStyle,
              ),
              trailing:
                  Icon(Icons.arrow_circle_right, color: CouleurPrincipale),
            ),
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
            Tab(text: 'Restaurant'),
            Tab(text: 'Hotel'), //
            Tab(text: 'Ecole'),
            Tab(text: 'Commerce'), //
            Tab(text: 'Hopital (Sante)'), //hopital clinic
            Tab(text: 'Banque'), //finance
            Tab(text: 'Mode & Bien etre'), // fasghion maquillage
            Tab(text: 'Voyage & Transport'), // transport
            Tab(text: 'Tech'),
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
          MyWidget1(),
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
          Center(child: Text('Content of Tab 1')),
          Center(child: Text('Content of Tab 2')),
          Center(child: Text('Content of Tab 3')),
          Center(child: Text('Content of Tab 3')),
          Center(child: Text('Content of Tab 3')),
        ],
      ),

      // floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SpeedDial(
        // both default to 16
        // marginRight: 18,
        // marginBottom: 20,
        animatedIcon: AnimatedIcons.view_list,
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
  List<dynamic> story = [];
  List<dynamic> post = [];
  bool _isLoading = false;

  fetchPosts() async {
    setState(() {
      _isLoading = true;
    });

    const url = 'https://royalrisingplus.com/upato/bureau/read.php';
    final uri = Uri.parse(url);
    final reponse = await http.get(uri);
    final List resultat = jsonDecode(reponse.body);
    post = resultat;
    resultat.sort(
      (a, b) => b["id"].compareTo(a["id"]),
    );
    debugPrint(resultat.toString());
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();

    fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
    return Scaffold(
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
              color: CouleurPrincipale,
            ))
          :
          //  Padding(
          //   padding: const EdgeInsets.all(5.0),
          //   child: Container(
          //     child: SingleChildScrollView(
          //       child: Column(
          //         children: [

          //           Widget_UI(
          //             image:
          //                 'https://www.nesto.ca/wp-content/uploads/2022/05/type-of-houses-in-ca.jpg',
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),

          Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                      post.length,
                      (index) => GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return DetailPage(
                              titre: post[index]['nom'],
                              desc: post[index]['desc'],
                              image1: post[index]['image1'],
                              image2: post[index]['image2'],
                              // postedBy: post[index]['postedBy'],
                            );
                          }));
                        },
                        child: Widget_UI(
                          desc: post[index]['desc'],

                          // description: post[index]['PostDetails'],
                          // date: post[index]['PostingDate'],
                          // index: index + 1,
                          titre: post[index]['nom'],
                          image: post[index]['image1'],
                          // par: post[index]['postedBy'],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
