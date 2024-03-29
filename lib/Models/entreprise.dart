import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upato/UI.dart';
import 'package:upato/detailpage.dart';
import 'package:upato/Util/style.dart';

class Entreprise_Page extends StatefulWidget {
  const Entreprise_Page({Key? key}) : super(key: key);

  @override
  State<Entreprise_Page> createState() => _Entreprise_PageState();
}

class _Entreprise_PageState extends State<Entreprise_Page> {
  List<dynamic> post = [];
  bool _isLoading = false;
  Position? _currentPosition;
  double _distanceFilter = 10000; // Default filter distance

  // Fonction pour récupérer les données depuis le cache
  Future<void> _fetchCachedData() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedData = prefs.getString('cachedData');
    if (cachedData != null) {
      setState(() {
        post = jsonDecode(cachedData);
      });
    }
  }

  // Fonction pour sauvegarder les données en cache
  Future<void> _cacheData(List<dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('cachedData', jsonEncode(data));
  }

  fetchPosts() async {
    setState(() {
      _isLoading = true;
    });

    var url = "http://$Adress_IP/goma/entreprise.php";
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final List resultat = jsonDecode(response.body);
      resultat.sort((a, b) => b["id"].compareTo(a["id"]));
      setState(() {
        post = resultat;
        _isLoading = false;
      });
      // Sauvegarder les données en cache
      await _cacheData(resultat);
    } else {
      throw Exception('Failed to load data');
    }
  }

  // Fonction pour récupérer la position actuelle
  void _getCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentPosition = position;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchCachedData(); // Charger les données en cache au démarrage de l'application
    fetchPosts();
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(
              color: CouleurPrincipale,
            ),
          )
        : post.isEmpty
            ? Center(
                child: Image.asset(
                  'assets/error.png', // Chemin de votre image
                  width: 200,
                  height: 200,
                ),
              )
            : RefreshIndicator(
                onRefresh: () => _refresh(),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Distance Filter (meters):"),
                          SizedBox(width: 10),
                          Container(
                            width: 100,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                setState(() {
                                  _distanceFilter = double.parse(value);
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      ...post.map((company) {
                        double lat = double.parse(company['lat']);
                        double log = double.parse(company['log']);
                        if (_currentPosition != null) {
                          double distanceInMeters = Geolocator.distanceBetween(
                              _currentPosition!.latitude,
                              _currentPosition!.longitude,
                              lat,
                              log);

                          if (distanceInMeters <= _distanceFilter) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return DetailPage(
                                      lat: company['lat'],
                                      long: company['log'],
                                      titre: company['nom'],
                                      site: company['site'],
                                      tel: company['tel'],
                                      desc: company['detail'],
                                      image1: company['image1'],
                                      image2: company['image2'],
                                      auteur: company['auteur'],
                                    );
                                  }),
                                );
                              },
                              child: Widget_UI(
                                desc: company['detail'],
                                titre: company['nom'],
                                image: company['image1'],
                              ),
                            );
                          } else {
                            return SizedBox();
                          }
                        } else {
                          return SizedBox();
                        }
                      }).toList(),
                    ],
                  ),
                ),
              );
  }

  Future<void> _refresh() async {
    await fetchPosts();
    _getCurrentLocation();
  }
}
