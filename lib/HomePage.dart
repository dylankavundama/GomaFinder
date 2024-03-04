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
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Text(
              'Goma',
              style: TextStyle(color: Colors.black),
            ),
            Padding(
              padding: EdgeInsets.only(right: 3),
            ),
            Text(
              'Finder',
              style: TextStyle(color: CouleurPrincipale),
            ),
            Icon(
              Icons.location_on_outlined,
              color: Colors.blue,
            )
          ],
        ),
        bottom: TabBar(
          indicatorColor: CouleurPrincipale,
          labelColor: Colors.black,
          controller: _tabController,
          tabs: [
            Tab(text: 'Acceuil'),
            Tab(text: 'Tab 2'),
            Tab(text: 'Tab 3'),
                        Tab(text: 'Tab 3'),
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
    return const Placeholder();
  }
}
