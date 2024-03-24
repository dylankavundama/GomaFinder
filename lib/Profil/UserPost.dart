import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:upato/UI.dart';
import 'package:upato/detailpage.dart';
import 'package:upato/style.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';

class UserPost extends StatefulWidget {
  const UserPost({Key? key}) : super(key: key);

  @override
  State<UserPost> createState() => _UserPostState();
}

class _UserPostState extends State<UserPost> {
  List<dynamic> post = [];
  bool _isLoading = false;

  fetchPosts() async {
    setState(() {
      _isLoading = true;
    });

    // Get current user
    User? user = FirebaseAuth.instance.currentUser;

    // Check if user is logged in
    if (user != null) {
      var url = 'http://$Adress_IP/goma/entreprise.php';
      final uri = Uri.parse(url);
      final reponse = await http.get(uri);
      final List resultat = jsonDecode(reponse.body);

      // Filter the posts based on current user's ID
      post = resultat
          .where((entreprise) => entreprise['auteur'] == user.displayName)
          .toList();

      post.sort(
        (a, b) => b["id"].compareTo(a["id"]),
      );
      debugPrint(resultat.toString());
    } else {
      // Handle if user is not logged in
      // For example, navigate to login screen
    }

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
    return Scaffold(
      body: _isLoading
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
                      ),
                    ),
                  ),
                ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_business),
        onPressed: () {},
      ),
    );
  }
}
