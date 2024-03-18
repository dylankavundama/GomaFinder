import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:upato/UI.dart';
import 'package:upato/detailpage.dart';
import 'package:upato/style.dart';

class Search_Page extends StatefulWidget {
  const Search_Page({Key? key}) : super(key: key);

  @override
  State<Search_Page> createState() => _Search_PageState();
}

class _Search_PageState extends State<Search_Page> {
  List<dynamic> post = [];
  List<dynamic> filteredPost = [];
  bool _isLoading = false;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  fetchPosts() async {
    setState(() {
      _isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final cachedData = prefs.getString('entreprise_data');
    if (cachedData != null) {
      setState(() {
        post = jsonDecode(cachedData);
        filteredPost = post;
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
        filteredPost = post;
        _isLoading = false;
      });
      // Cache the data
      prefs.setString('entreprise_data', response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  void filterSearchResults(String query) async {
    List<dynamic> dummySearchList = [];
    dummySearchList.addAll(post);
    if (query.isNotEmpty) {
      List<dynamic> dummyListData = [];
      dummySearchList.forEach((item) {
        if (item['nom'].toLowerCase().contains(query.toLowerCase()) ||
            item['detail'].toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      });
      setState(() {
        filteredPost.clear();
        filteredPost.addAll(dummyListData);
      });
    } else {
      setState(() {
        filteredPost.clear();
        filteredPost.addAll(post);
      });
    }

    // Vérifie si la liste filtrée est vide
    if (filteredPost.isEmpty) {
      // Si la liste filtrée est vide, recharge les données
      await fetchPosts();
    }
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.green,
        statusBarBrightness: Brightness.light,
      ),
    );

    return _isLoading
        ? Center(
            child: CircularProgressIndicator(
              color: CouleurPrincipale,
            ),
          )
        : Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: TextField(
                  autofocus: true,
                  cursorColor: CouleurPrincipale,
                  controller: searchController,
                  onChanged: filterSearchResults,
                  decoration: InputDecoration(
                    labelText: "Rechercher",
                    hintText: "Rechercher",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(4.0),
                      ),
                    ),
                    // Modification de la couleur du texte
                    labelStyle: TextStyle(color: CouleurPrincipale),
                    hintStyle: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              searchController.text.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                        itemCount: filteredPost.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return DetailPage(
                                    lat: filteredPost[index]['lat'],
                                    long: filteredPost[index]['log'],
                                    titre: filteredPost[index]['nom'],
                                    site: filteredPost[index]['site'],
                                    tel: filteredPost[index]['tel'],
                                    desc: filteredPost[index]['detail'],
                                    image1: filteredPost[index]['image1'],
                                    image2: filteredPost[index]['image2'],
                                  );
                                }),
                              );
                            },
                            child: Widget_UI(
                              desc: filteredPost[index]['detail'],
                              titre: filteredPost[index]['nom'],
                              image: filteredPost[index]['image1'],
                            ),
                          );
                        },
                      ),
                    )
                  : Container(
                      child: Image.asset('assets/find.webp'),
                    )
            ],
          );
  }
}
