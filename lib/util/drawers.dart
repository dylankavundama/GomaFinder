import 'package:flutter/material.dart';
import 'package:upato/actu/actualiter.dart';
import 'package:upato/event/event.dart';
import 'package:upato/podecast/Podcast_Page.dart';
import 'package:upato/style.dart';

class Drawers extends StatefulWidget {
  const Drawers({Key? key}) : super(key: key);

  @override
  _DrawersState createState() => _DrawersState();
}

class _DrawersState extends State<Drawers> {
  bool _isDarkMode = false;

  void _toggleDarkMode() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(children: [
        DrawerHeader(
          child: Image.asset('assets/images/logo.png'),
        ),
        Card(
          child: ListTile(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => Actu_Home()),
              );
            },
            title: Text(
              'Actualité',
              style: TitreStyle,
            ),
            trailing: Icon(Icons.arrow_circle_right, color: CouleurPrincipale),
          ),
        ),
        Card(
          child: ListTile(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => Event_Home_Page()),
              );
            },
            title: Text(
              'Evénement',
              style: TitreStyle,
            ),
            trailing: Icon(Icons.arrow_circle_right, color: CouleurPrincipale),
          ),
        ),
        Card(
          child: ListTile(
            title: Text(
              'Live Tv',
              style: TitreStyle,
            ),
            trailing: Icon(Icons.arrow_circle_right, color: CouleurPrincipale),
          ),
        ),
        Card(
          child: ListTile(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Podcast(),
                ),
              );
            },
            title: Text(
              'Live Radio',
              style: TitreStyle,
            ),
            trailing: Icon(Icons.arrow_circle_right, color: CouleurPrincipale),
          ),
        ),
        Card(
          child: ListTile(
            title: Text(
              'Visite Goma',
              style: TitreStyle,
            ),
            trailing: Icon(Icons.arrow_circle_right, color: CouleurPrincipale),
          ),
        ),
        Card(
          child: ListTile(
            title: Text(
              'Artiste & Influenceur',
              style: TitreStyle,
            ),
            trailing: Icon(Icons.arrow_circle_right, color: CouleurPrincipale),
          ),
        ),
        Card(
          child: ListTile(
            onTap: _toggleDarkMode,
            title: Text(
              _isDarkMode ? 'Mode Clair' : 'Mode Sombre',
              style: TitreStyle,
            ),
            trailing: Icon(Icons.lightbulb, color: _isDarkMode ? Colors.white : Colors.black),
          ),
        ),
      ]),
      width: 250,
    );
  }
}
