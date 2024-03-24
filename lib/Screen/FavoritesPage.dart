import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upato/detailpage.dart';
import 'dart:convert';

import '../Util/style.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<dynamic> favorites = [];

  // Function to fetch favorites from SharedPreferences
  fetchFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final favs = prefs.getStringList('favorites') ?? [];
    setState(() {
      favorites = favs.map((fav) => jsonDecode(fav)).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    fetchFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: CouleurPrincipale),
        backgroundColor: Colors.white,
        title: Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(right: 0),
            ),
            Text(
              'Mes favoris',
              style: TitreStyle,
            ),
          ],
        ),
      ),
      body: favorites.isEmpty
          ? const Center(
              child: Text(
                  'Vous n\'avez pas encore ajouté d\'entreprises aux favoris.'),
            )
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        // You should replace DetailPage with the name of your detail page
                        return DetailPage(
                          lat: favorites[index]['lat'] != null
                              ? favorites[index]['lat'].toString()
                              : '0.0',
                          long: favorites[index]['long'] != null
                              ? favorites[index]['long'].toString()
                              : '0.0',
                          titre: favorites[index]['nom'] ?? '',
                          site: favorites[index]['site'] ?? '',
                          tel: favorites[index]['tel'] ?? '',
                          desc: favorites[index]['detail'] ?? '',
                          image1: favorites[index]['image1'] ?? '',
                          image2: favorites[index]['image2'] ?? '',
                        );
                      }),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black12,
                          style: BorderStyle.solid,
                        ),
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(favorites[index]['nom'] ?? '',
                                  maxLines: 1,
                                  textAlign: TextAlign.start,
                                  style: TitreStyle),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Text(
                                '',
                                style: GoogleFonts.abel(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                ),
                                maxLines: 5,
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(0.0),
                              child: Image.network(
                                // ignore: prefer_interpolation_to_compose_strings
                                "http://$Adress_IP/goma/entreprise/" +
                                    (favorites[index]['image1'] ?? ''),
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Row(
                              children: [
                                // IconButton(
                                //   color: CouleurPrincipale,
                                //   onPressed: () {},
                                //   icon: Icon(Icons.share),
                                // ),
                                TextButton(
                                    child: Text(
                                      "Réservation",
                                      style: TitreStyle,
                                    ),
                                    onPressed: () {}),
                                TextButton(
                                    child: Text(
                                      "Appeler",
                                      style: TitreStyle,
                                    ),
                                    onPressed: () {}),

                                TextButton.icon(
                                    icon: Icon(
                                      Icons.share_outlined,
                                      color: CouleurPrincipale,
                                    ),
                                    label: Text(
                                      "Partager",
                                      style: TitreStyle,
                                    ),
                                    onPressed: () {})
                              ],
                            ),
                          ]),
                    ),
                  ),
                );
                // return ListTile(
                //   title: Text(favorites[index]['nom'] ?? ''),
                //   subtitle: Text(favorites[index]['detail'] ?? ''),
                //   onTap: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(builder: (context) {
                //         // You should replace DetailPage with the name of your detail page
                //         return DetailPage(
                //           lat: favorites[index]['lat'] != null
                //               ? favorites[index]['lat'].toString()
                //               : '0.0',
                //           long: favorites[index]['long'] != null
                //               ? favorites[index]['long'].toString()
                //               : '0.0',
                //           titre: favorites[index]['nom'] ?? '',
                //           site: favorites[index]['site'] ?? '',
                //           tel: favorites[index]['tel'] ?? '',
                //           desc: favorites[index]['detail'] ?? '',
                //           image1: favorites[index]['image1'] ?? '',
                //           image2: favorites[index]['image2'] ?? '',
                //         );
                //       }),
                //     );
                //   },
                // );
              },
            ),
    );
  }
}
