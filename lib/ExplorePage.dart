import 'package:flutter/material.dart';
import 'package:upato/actu/actualiter.dart';
import 'package:upato/podecast/Podcast_Page.dart';
import 'package:upato/podecast/live_radio/main.dart';

class ExplorePage extends StatelessWidget {
  // Liste des éléments à afficher dans la GridView
  final List<Map<String, dynamic>> items = [
    {
      'title': 'Music',
      'image':
          'https://static.vecteezy.com/system/resources/thumbnails/010/160/834/small/music-icon-sign-symbol-design-free-png.png'
    },
    {
      'title': 'Podcast',
      'image': 'https://cdn-icons-png.freepik.com/512/4029/4029013.png'
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
      body: GridView.builder(
        itemCount: items.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                    builder: (context) => Home_Radio(),
                  ),
                );
              } else if (items[index]['title'] == 'Stock') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StockPage(),
                  ),
                );
              } else if (items[index]['title'] == 'Stock') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StockPage(),
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
                    style: TextStyle(fontSize: 18),
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

class MusicPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Music Page'),
      ),
      body: Center(
        child: Text(
          'Music Page',
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}

class StockPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stock Page'),
      ),
      body: Center(
        child: Text(
          'Stock Page',
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}
