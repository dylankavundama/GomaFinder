import 'package:firebase_auth_example/HomePage.dart';
import 'package:flutter/material.dart';

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
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomSheet: screen[currentindex],
        bottomNavigationBar: NavigationBar(
          backgroundColor: Colors.white,
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
              icon: Icon(Icons.home_max),
              selectedIcon: Icon(Icons.home),
              label: 'Acceuil',
            ),
            NavigationDestination(
              icon: Icon(Icons.search),
              selectedIcon: Icon(Icons.find_in_page),
              label: 'Recherche',
            ),
            // NavigationDestination(
            //   icon: Icon(Icons.fastfood),
            //   selectedIcon: Icon(Icons.receipt),
            //   label: 'Reservation',
            // ),
            NavigationDestination(
              selectedIcon: Icon(Icons.account_box),
              icon: Icon(Icons.person),
              label: 'Compte',
            ),
          ],
        ),
      ),
    );
  }
}
