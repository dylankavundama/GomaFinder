import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upato/UI.dart';
import 'package:upato/detailpage.dart';
import 'package:upato/style.dart';
import 'package:http/http.dart' as http;

class Banque_Page extends StatefulWidget {
  const Banque_Page({super.key});

  @override
  State<Banque_Page> createState() => _Banque_PageState();
}

class _Banque_PageState extends State<Banque_Page> {
  List<dynamic> post = [];
  bool _isLoading = false;
fetchPosts() async {
  setState(() {
    _isLoading = true;
  });
  const url = 'http://192.168.0.13/goma/banque.php';
  final uri = Uri.parse(url);
  final response = await http.get(uri);
  
  try {
    final List resultat = jsonDecode(response.body);
    resultat.sort((a, b) => b["id"].compareTo(a["id"]));

    // Mettre en cache les données
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('banqueData', jsonEncode(resultat));

    setState(() {
      post = resultat;
      _isLoading = false;
    });
  } catch (e) {
    print('Erreur lors de la récupération des données: $e');
    setState(() {
      _isLoading = false;
    });
  }
}

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);

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
