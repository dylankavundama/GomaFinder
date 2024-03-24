import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:upato/UI.dart';
import 'package:upato/detailpage.dart';
import 'package:upato/Util/style.dart';

class Entreprise_Page extends StatefulWidget {
  const Entreprise_Page({super.key});

  @override
  State<Entreprise_Page> createState() => _Entreprise_PageState();
}

class _Entreprise_PageState extends State<Entreprise_Page> {
  List<dynamic> post = [];
  bool _isLoading = false;
  Position? _currentPosition;

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
    } else {
      throw Exception('Failed to load data');
    }
  }

  // Function to get current position
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
            : SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                    post.length,
                    (index) {
                      double lat = double.parse(post[index]['lat']);
                      double log = double.parse(post[index]['log']);
                      // Check if _currentPosition is not null before accessing its properties
                      if (_currentPosition != null) {
                        // Calculate distance between current position and company's position
                        double distanceInMeters = Geolocator.distanceBetween(
                            _currentPosition!.latitude,
                            _currentPosition!.longitude,
                            lat,
                            log);

                        // Display only companies within 10 meters
                        if (distanceInMeters <= 100) {
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
                                    auteur: post[index]['auteur'],
                                  );
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
                          return SizedBox(); // Company is not within 10 meters, so don't display it
                        }
                      } else {
                        return SizedBox();
                      }
                    },
                  ),
                ),
              );
  }
}
