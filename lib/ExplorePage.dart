import 'package:flutter/material.dart';
import 'package:upato/Screen/Tv/Tv_Home.dart';
import 'package:upato/Screen/podecast/live_radio/Home_Radio.dart';
import 'package:upato/actu/actualiter.dart';
import 'package:upato/m.dart';
import 'package:upato/style.dart';

class ExplorePage extends StatelessWidget {
  // Liste des éléments à afficher dans la GridView
  final List<Map<String, dynamic>> items = [
    {
      'title': 'Music',
      'image':
          'https://static.vecteezy.com/system/resources/thumbnails/010/160/834/small/music-icon-sign-symbol-design-free-png.png'
    },
    {
      'title': 'Bloc Note',
      'image': 'https://www.shutterstock.com/image-vector/edit-file-icon-sign-vector-600nw-1665705262.jpg'
    },
    {
      'title': 'Television',
      'image':
          'https://static-00.iconduck.com/assets.00/television-icon-2048x2048-q495yz4y.png'
    },
    {
      'title': 'Actu',
      'image':
          'https://as2.ftcdn.net/v2/jpg/02/58/28/13/1000_F_258281322_auDRI2dzo7xOwmJpSJhNsoTOoDqt7YpX.jpg'
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
              style: DescStyle,
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
                    builder: (context) => Tv_Home(),
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        DetailsPage(item: items[index]['title']),
                  ),
                );
              }

              //
            },
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
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

class DetailsPage extends StatelessWidget {
  final String item;

  DetailsPage({required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Item Details'),
      ),
      body: Center(
        child: Text(
          item,
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}




