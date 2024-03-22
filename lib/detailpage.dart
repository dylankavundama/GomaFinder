import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:upato/style.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPage extends StatefulWidget {
  DetailPage(
      {required this.desc,
      required this.image1,
      required this.image2,
      required this.titre,
      required this.tel,
      required this.site,
      required this.lat,
      required this.long,
      super.key});
  String image1;
  String image2;
  String desc;
  String titre;
  String tel;
  String lat;
  String long;
  String site;
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool fav = false;

  //banniere actu
  BannerAd? _bannerAd;

  bool _isLoaded = false;

  final String _adUnitId = Platform.isAndroid
      ? 'ca-app-pub-7329797350611067/5003791578'
      : 'ca-app-pub-7329797350611067/5003791578';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _isLoaded = false;
    _loadAd();
  }

  void _loadAd() async {
    final size = await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
        MediaQuery.of(context).size.width.truncate());

    if (size == null) {
      return;
    }

    BannerAd(
      adUnitId: _adUnitId,
      request: const AdRequest(),
      size: size,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _bannerAd = ad as BannerAd;
            _isLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
        },
        onAdOpened: (Ad ad) {},
        onAdClosed: (Ad ad) {},
        onAdImpression: (Ad ad) {},
      ),
    ).load();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(4.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 300,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          "http://$Adress_IP/goma/entreprise/" +
                                              widget.image1,
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            height: 300,
                            child: Image.network(
                              "http://$Adress_IP/goma/entreprise/" +
                                  widget.image1,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 300,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            "http://$Adress_IP/goma/entreprise/" +
                                                widget.image2),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            height: 300,
                            child: Image.network(
                              "http://$Adress_IP/goma/entreprise/" +
                                  widget.image2,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 5.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.titre, style: TitreStyle),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      const Text("Description",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 18)),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        widget.desc,
                        style: const TextStyle(fontWeight: FontWeight.w300),
                        textAlign: TextAlign.start,
                      ),
                      const Divider(
                        thickness: 1,
                      ),
                      CustomListTile(
                        leadingIcon: Icons.call,
                        titleText: widget.tel,
                        trailingText: 'follow',
                        onTap: () {
                          // ignore: deprecated_member_use
                          launch('tel:${widget.tel}');
                        },
                      ),
                      ListTile(
                        onTap: () {
                          // ignore: deprecated_member_use
                          launch('https://${widget.site}');
                        },
                        leading: Icon(Icons.web),
                        title: Text(
                          widget.site,
                          style: DescStyle,
                        ),
                        trailing: Text('follow'),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Stack(
                        children: [
                          if (_bannerAd != null && _isLoaded)
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: SafeArea(
                                child: SizedBox(
                                  width: _bannerAd!.size.width.toDouble(),
                                  height: _bannerAd!.size.height.toDouble(),
                                  child: AdWidget(ad: _bannerAd!),
                                ),
                              ),
                            ),
                        ],
                      ),
                      Text("Localisation",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 18)),
                      SizedBox(
                        height: 8,
                      ),
                      Tooltip(
                        message: 'clic',
                        preferBelow: false,
                        child: InkWell(
                          onTap: () {
                            String lat = widget.lat;
                            String long = widget.long;
                            String url =
                                'http://www.google.com/maps/search/?api=1&query=$lat,$long';
                            launch(url);
                          },
                          child: Container(
                            height: 200,
                            width: MediaQuery.of(context).size.width - 60,
                            decoration: BoxDecoration(color: Colors.green),
                            child: Image(
                                image: AssetImage("assets/newark.png"),
                                fit: BoxFit.cover),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 73,
        child: BottomAppBar(
          color: Colors.white,
          elevation: 0.0,
          child: FittedBox(
            fit: BoxFit.none,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                onTap: () {},
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(bottom: 6.0),
                  height: 46,
                  width: 186,
                  decoration: BoxDecoration(
                    color: CouleurPrincipale,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 1.0),
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                  child: GestureDetector(
                    onTap: () {
                      String lat = widget.lat;
                      String long = widget.long;
                      String url =
                          'http://www.google.com/maps/search/?api=1&query=$lat,$long';
                      launch(url);
                    },
                    child: Text(
                      "GPS",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  final IconData leadingIcon;
  final String titleText;
  final String trailingText;
  final VoidCallback onTap;

  CustomListTile({
    required this.leadingIcon,
    required this.titleText,
    required this.trailingText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(leadingIcon),
      title: Text(
        titleText,
        style: DescStyle,
      ),
      trailing: Text(trailingText),
    );
  }
}
