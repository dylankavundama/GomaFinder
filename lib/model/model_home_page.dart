import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:upato/UI.dart';
import 'package:upato/detailpage.dart';
import 'package:upato/style.dart';
import 'package:http/http.dart' as http;

class Mode_Home_Page extends StatefulWidget {
  const Mode_Home_Page({super.key});

  @override
  State<Mode_Home_Page> createState() => _Mode_Home_PageState();
}

class _Mode_Home_PageState extends State<Mode_Home_Page> {
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

    return _isLoading
        ? Center(
            child: CircularProgressIndicator(
              color: CouleurPrincipale,
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
                          desc: post[index]['desc'],
                          image1: post[index]['image1'],
                          image2: post[index]['image2'],
                        );
                      }),
                    );
                  },
                  child: Widget_UI(
                    desc: post[index]['desc'],
                    titre: post[index]['nom'],
                    image: post[index]['image1'],
                  ),
                ),
              ),
            ),
          );
  }
}
