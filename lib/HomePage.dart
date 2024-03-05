import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  Color CouleurPrincipale = Colors.green;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(children: [
          DrawerHeader(
            child: Image.asset('assets/images/logo.png'),
          ),
        ]),
        width: 250,
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: CouleurPrincipale),
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Text(
              'U',
              style: TextStyle(color: CouleurPrincipale),
            ),
            Padding(
              padding: EdgeInsets.only(right: 0),
            ),
            Text(
              'PATO',
              style: TextStyle(color: Colors.black),
            ),
            Icon(
              Icons.location_on_outlined,
              color: Colors.black,
              size: 18,
            )
          ],
        ),
        bottom: TabBar(
          indicatorColor: CouleurPrincipale,
          labelColor: Colors.black,
          controller: _tabController,
          isScrollable: true,
          tabs: [
            Tab(text: 'Bureau'),
            Tab(text: 'Tech'),
            Tab(text: 'Restaurant'),
            Tab(text: 'Commerce'), //
            Tab(text: 'Hotel'), //
            Tab(text: 'Loisir'), //
            Tab(text: 'Eglise'), //
            Tab(text: 'ONG'), //
            Tab(text: 'Media'), //
            Tab(text: 'Fashion Habillement'), //
            Tab(text: 'Super marcher'), //
            Tab(text: 'Voyage'), // transport
            Tab(text: 'Banque'), //finance
            Tab(text: 'Communication'),
            Tab(text: 'Santer'), //hopital clinic
            Tab(text: 'Saloon'), //beaute
            Tab(text: 'Ecole'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          MyWidget1(),
          Center(child: Text('Content of Tab 1')),
          Center(child: Text('Content of Tab 2')),
          Center(child: Text('Content of Tab 3')),
          Center(child: Text('Content of Tab 3')),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: CouleurPrincipale,
          child: Icon(Icons.menu),
          onPressed: () {}),
    );
  }
}

class MyWidget1 extends StatefulWidget {
  const MyWidget1({super.key});

  @override
  State<MyWidget1> createState() => _MyWidget1State();
}

class _MyWidget1State extends State<MyWidget1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
