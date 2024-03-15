import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:upato/UI.dart';
import 'package:upato/detailpage.dart';
import 'package:http/http.dart' as http;
import 'package:upato/style.dart';

class EcolePage extends StatefulWidget {
  const EcolePage({Key? key}) : super(key: key);

  @override
  State<EcolePage> createState() => _EcolePageState();
}

class _EcolePageState extends State<EcolePage> {
  List<dynamic> story = [];
  List<dynamic> post = [];
  bool _isLoading = false;

  fetchPosts() async {
    setState(() {
      _isLoading = true;
    });

    const url = 'http://192.168.1.76/goma/goma.php';
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
    double screenH = MediaQuery.of(context).size.height;
    double screenW = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xFF2D2E33),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(color: CouleurPrincipale,)
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: screenH * 0.04),
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
                                        lat: post[index]['lat'],
                          long: post[index]['log'],
                          titre: post[index]['nom'],
                          site: post[index]['site'],
                          tel: post[index]['tel'],
                          desc: post[index]['desc'],
                          image1: post[index]['image1'],
                          image2: post[index]['image2'],
                                  // postedBy: post[index]['postedBy'],
                                );
                              }));
                            },
                            child: Widget_UI(
                              desc: post[index]['desc'],
                              titre: post[index]['nom'],
                              image: post[index]['image1'],

                              // date: post[index]['PostingDate'],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
