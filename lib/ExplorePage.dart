import 'package:flutter/material.dart';

class ExplorePage extends StatelessWidget {
  // Liste des éléments à afficher dans la GridView
  final List<Map<String, dynamic>> items = [
    {
      'title': 'Music',
      'image':
          'https://static.vecteezy.com/system/resources/thumbnails/010/160/834/small/music-icon-sign-symbol-design-free-png.png'
    },
    {'title': 'Stock', 'image': 'assets/stock_icon.png'}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GridView Example'),
      ),
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
                    builder: (context) => MusicPage(),
                  ),
                );
              } else if (items[index]['title'] == 'Stock') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StockPage(),
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
