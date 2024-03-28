import 'package:flutter/material.dart';
import 'package:upato/Screen/Tv/Tv_Home.dart';
import 'package:upato/Screen/channel.dart';
import 'package:upato/Screen/podecast/live_radio/Home_Radio.dart';
import 'package:upato/actu/actualiter.dart';
import 'package:upato/bloc_note.dart';
import 'package:upato/Util/style.dart';

class ExplorePage extends StatelessWidget {
  // Liste des éléments à afficher dans la GridView
  final List<Map<String, dynamic>> items = [
    {
      'title': 'Music',
      'image':
          'assets/a.webp'
    },
    {
      'title': 'Bloc Note',
      'image': 'assets/b.webp'
    },
    {
      'title': 'Television',
      'image':
          'assets/c.png'
    },
    {
      'title': 'Actu',
      'image':
          'assets/d.png'
    },
  ];

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
              'Explore',
              style: TitreStyle,
            ),
          ],
        ),
      ),
      body: GridView.builder(
        itemCount: items.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Nombre de colonnes dans la grille
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Rediriger l'utilisateur vers la page appropriée en fonction de l'élément sélectionné
              if (items[index]['title'] == 'Music') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeRadio(),
                  ),
                );
              } else if (items[index]['title'] == 'Bloc Note') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TaskListPage(),
                  ),
                );
              } else if (items[index]['title'] == 'Television') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Channel(),
                  ),
                );
              } else if (items[index]['title'] == 'Actu') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Actu_Home(),
                  ),
                );
              } else {
  
              }

              //
            },
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    items[index]['image'],
                    width: 50,
                    height: 50,
                  ),
                  SizedBox(height: 10),
                  Text(
                    items[index]['title'],
                    style: TitreStyle,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}




