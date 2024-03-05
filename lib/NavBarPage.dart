import 'package:firebase_auth_example/ExplorePage.dart';
import 'package:firebase_auth_example/HomePage.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NavBarPage extends StatefulWidget {
  const NavBarPage({super.key});
  @override
  State<NavBarPage> createState() => _NavBarPageState();
}

class _NavBarPageState extends State<NavBarPage> {
  int currentindex = 0;
  NavigationDestinationLabelBehavior labelBehavior =
      NavigationDestinationLabelBehavior.alwaysShow;
  List<Widget> screen = [
    HomePage(),
    HomePage(),
    Explorepage(),
    HomePage(),
  ];

  @override
  Widget build(BuildContext context) {
    //SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white, // Définir la couleur de la barre d'état
      statusBarBrightness:
          Brightness.dark, // Changer la luminosité du texte de la barre d'état
    ));
    return SafeArea(
      child: Scaffold(
        bottomSheet: screen[currentindex],
        bottomNavigationBar: NavigationBar(
          backgroundColor: Color(0xffDCF6E6),
          //  backgroundColor: Colors.grey.shade100,
          labelBehavior: labelBehavior,
          selectedIndex: currentindex,

          onDestinationSelected: (int index) {
            setState(() {
              currentindex = index;
            });
          },
          destinations: const <Widget>[
            NavigationDestination(
              tooltip: 'home',
              icon: Icon(Icons.house),
              selectedIcon: Icon(Icons.home),
              label: 'Acceuil',
            ),
            NavigationDestination(
              icon: Icon(Icons.search),
              selectedIcon: Icon(Icons.youtube_searched_for_rounded),
              label: 'Recherche',
            ),
            NavigationDestination(
              icon: Icon(Icons.design_services),
              selectedIcon: Icon(Icons.explore),
              label: 'Explore',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.person_3),
              icon: Icon(Icons.person),
              label: 'Compte',
            ),
          ],
        ),
      ),
    );
  }
}
