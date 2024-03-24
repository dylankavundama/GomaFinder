import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upato/UI.dart';
import 'package:upato/detailpage.dart';
import 'package:upato/Util/style.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart'; // Ajout de la bibliothèque de géolocalisation

class Entreprise_Page extends StatefulWidget {
  const Entreprise_Page({Key? key});

  @override
  State<Entreprise_Page> createState() => _Entreprise_PageState();
}

class _Entreprise_PageState extends State<Entreprise_Page> {
  List<dynamic> post = [];
  bool _isLoading = false;
  Position? _currentPosition; // Position actuelle

  fetchPosts() async {
    setState(() {
      _isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final cachedData = prefs.getString('entreprise_data');
    if (cachedData != null) {
      setState(() {
        post = jsonDecode(cachedData);
        _isLoading = false;
      });
      return;
    }
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
      // Cache the data
      prefs.setString('entreprise_data', response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchPosts();
    _getCurrentLocation(); // Obtenir la position actuelle lors de l'initialisation
  }

  // Méthode pour obtenir la position actuelle
  void _getCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentPosition = position;
    });
  }

  // Méthode pour calculer la distance entre deux coordonnées géographiques
  double _calculateDistance(String latString, String longString) {
    if (_currentPosition != null) {
      double lat =
          double.tryParse(latString) ?? 0.0; // Convertit la latitude en double
      double long = double.tryParse(longString) ??
          0.0; // Convertit la longitude en double
      double distanceInMeters = Geolocator.distanceBetween(
          _currentPosition!.latitude, _currentPosition!.longitude, lat, long);
      return distanceInMeters;
    }
    return double
        .infinity; // Retourne une distance infinie si la position actuelle n'est pas disponible
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
            : SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                    post.length,
                    (index) {
                      double distance = _calculateDistance(
                          post[index]['lat'], post[index]['log']);
                      // Filtrer les entreprises qui se trouvent à moins de 1000 mètres
                      if (distance <= 1000) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return DetailPage(
                                  lat: post[index]['lat'],
                                  long: post[index]['log'],
                                  titre: post[index]['nom'],
                                  site: post[index]['site'],
                                  tel: post[index]['tel'],
                                  desc: post[index]['detail'],
                                  image1: post[index]['image1'],
                                      image2: post[index]['image2'],
     auteur: post[index]['auteur'],                            );
                              }),
                            );
                          },
                          child: Widget_UI(
                            desc: post[index]['detail'],
                            titre: post[index]['nom'],
                            image: post[index]['image1'],
                          ),
                        );
                      } else {
                        return Container(); // Retourne un conteneur vide si l'entreprise est à plus de 100 mètres
                      }
                    },
                  ),
                ),
              );
  }
}
