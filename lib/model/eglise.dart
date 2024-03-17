import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:upato/UI.dart';
import 'package:upato/detailpage.dart';
import 'package:upato/style.dart';
import 'package:http/http.dart' as http;

class Eglise_Page extends StatefulWidget {
  const Eglise_Page({super.key});

  @override
  State<Eglise_Page> createState() => _Eglise_PageState();
}

class _Eglise_PageState extends State<Eglise_Page> {
  List<dynamic> post = [];
  bool _isLoading = false;

  fetchPosts() async {
    setState(() {
      _isLoading = true;
    });
    const url = 'http://192.168.0.13/goma/eglise.php';
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
            :SingleChildScrollView(
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
