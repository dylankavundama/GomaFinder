import 'package:flutter/material.dart';


class ExplorePage extends StatelessWidget {
  // Liste des éléments à afficher dans la GridView
  final List<String> items = ['Client', 'Stock', 'Item 1', 'Item 2', 'Item 3', 'Item 4', 'Item 5', 'Item 6', 'Item 7', 'Item 8', 'Item 9', 'Item 10'];

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
              if (items[index] == 'Client') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ClientPage(),
                  ),
                );
              } else if (items[index] == 'Stock') {
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
                    builder: (context) => DetailsPage(item: items[index]),
                  ),
                );
              }
            },
            child: Card(
              child: Center(
                child: Text(items[index]),
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

class ClientPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Client Page'),
      ),
      body: Center(
        child: Text(
          'Client Page',
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
