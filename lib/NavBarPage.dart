import 'package:upato/Screen/ExplorePage.dart';
import 'package:upato/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:upato/Screen/FavoritesPage.dart';
import 'package:upato/Models/search.dart';

import 'package:upato/login/login.dart';

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
    const Search_Page(),
    const FavoritesPage(),
    ExplorePage(),
    const LoginHome(),
  ];

  @override
  Widget build(BuildContext context) {
    //SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    // SystemChrome.setSystemUIOverlayStyle(
    //   SystemUiOverlayStyle(
    //     statusBarColor: Colors.white,
    //     statusBarBrightness: Brightness.dark,
    //   ),
    // );
    return SafeArea(
      child: Scaffold(
        bottomSheet: screen[currentindex],
        bottomNavigationBar: NavigationBar(
          backgroundColor: Color(0xffDCF6E6),
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
              icon: Icon(Icons.youtube_searched_for_rounded),
              selectedIcon: Icon(Icons.search_outlined),
              label: 'Recherche',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.favorite_border),
              icon: Icon(Icons.favorite_outlined),
              //    label: 'Compte',

              label: 'Favories',
            ),
            NavigationDestination(
              icon: Icon(Icons.design_services),
              selectedIcon: Icon(Icons.explore),
              label: 'Explore',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.person_3),
              icon: Icon(Icons.person),
              //    label: 'Compte',

              label: 'Moi',
            ),
          ],
        ),
      ),
    );
  }
}
