import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:upato/UI.dart';
import 'package:upato/detailpage.dart';
import 'package:upato/style.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity/connectivity.dart';

class Ecole_Page extends StatefulWidget {
  const Ecole_Page({super.key});

  @override
  State<Ecole_Page> createState() => _Ecole_PageState();
}

class _Ecole_PageState extends State<Ecole_Page> {
  List<dynamic> post = [];
  bool _isLoading = false;
  bool _hasInternet = true; // Ajout de la variable pour vérifier l'état de la connexion

  @override
  void initState() {
    super.initState();
    checkInternetConnection();
    fetchPosts();
  }

  Future<void> checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        _hasInternet = false;
      });
    }
  }

  fetchPosts() async {
    if (!_hasInternet) return; // Si pas de connexion, ne pas exécuter la requête
    setState(() {
      _isLoading = true;
    });
    var url = 'http://$Adress_IP/goma/ecole.php';
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
            :!_hasInternet
            ? Center(
                child: Image.asset(
                  'assets/no_internet_image.png', // Chemin de votre image
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
                    (index) => GestureDetector(
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
                            );
                          }),
                        );
                      },
                      child: Widget_UI(
                        desc: post[index]['detail'],
                        titre: post[index]['nom'],
                        image: post[index]['image1'],
                      ),
                    ),
                  ),
                ),
              );
  }
}
