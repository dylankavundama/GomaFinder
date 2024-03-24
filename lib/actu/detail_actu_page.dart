import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:share/share.dart';
import 'package:upato/Util/style.dart';

class DetailPostPage extends StatefulWidget {
  const DetailPostPage(
      {
      //required this.id,
      required this.img,
      required this.titre,
      required this.description,
      Key? key})
      : super(key: key);
  // final int id;
  final String img;
  final String titre;
  final String description;

  @override
  State<DetailPostPage> createState() => _DetailPostPageState();
}

class _DetailPostPageState extends State<DetailPostPage> {
  @override
  void initState() {
    // _blocPost.add(BlocEventFetch());
    _startNewGame();
    super.initState();
  }

  // PostBloc _blocPost = PostBloc();
  InterstitialAd? _interstitialAd;
  final _gameLength = 5;
  late var _counter = _gameLength;

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
  void dispose() {
    _interstitialAd?.dispose();
    super.dispose();
  }

  void go() {
    setState(() {
      _interstitialAd?.show();
    });
  }

  List<dynamic> _videos = [];
  bool _isLoading = false;

  @override
  Future<void> allVideo() async {
    _isLoading = true;
    setState(() {
      _isLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(color: CouleurPrincipale),
          actions: [
            IconButton(
              icon: Icon(Icons.share, color: CouleurPrincipale),
              onPressed: () async {
                final titre = widget.titre;
                final desc = widget.description;

                const lien =
                    "https://play.google.com/store/apps/details?id=com.congocheckcd";
                Share.share(
                    "Titre : $titre \n Artcile: $desc \n Article : Telechare l'Application $lien");
              },
            ),
          ],
          title: Text(
            "Detail Page",
            style: TitreStyle,
          ),
          // centerTitle: true,
          backgroundColor: Colors.white),

      // appBar: AppBar(
      // leading: IconButton(
      //   icon: const Icon(Icons.share),
      //   onPressed: () async {
      //     final titre = widget.titre;
      //     final desc = widget.description;

      //     const lien =
      //         "https://play.google.com/store/apps/details?id=com.congocheckcd";
      //     Share.share(
      //         "Titre : $titre \n Artcile: $desc \n Article : Telechare l'Application $lien");
      //   },
      // ),
      //   backgroundColor: Colors.white,
      //   title: Padding(
      //     padding: const EdgeInsets.only(left: 60),
      //     child: Row(children: const [
      //       Text(
      //         'CONGO',
      //         style: TextStyle(color: Colors.orange),
      //       ),
      //       Text(
      //         'CHECK',
      //         style: TextStyle(color: Colors.lightBlue),
      //       ),
      //     ]),
      //   ),
      //   centerTitle: true,
      //   elevation: 1,
      // ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: screenHeight * 0.4,
                  width: screenWidth,
                  child: InteractiveViewer(
                    boundaryMargin: EdgeInsets.all(20.0),
                    minScale: 0.1,
                    maxScale: 2.0,
                    child: Image.network(
                      "http://$Adress_IP/goma/entreprise/" + widget.img,
                      fit: BoxFit.cover,
                      width: screenWidth,
                    ),
                  ),
                ),
                Positioned(
                  left: 8,
                  right: 8,
                  top: 30,
                  bottom: 19,
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 222),
                      ),
                      Container(
                        color: Colors.black45,
                        child: Text(
                          widget.titre,
                          style: GoogleFonts.abel(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.description,
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.abel(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  Divider(
                    color: Colors.black12,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
