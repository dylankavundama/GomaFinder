import 'package:flutter/material.dart';
import 'package:upato/Screen/podecast/Podcast_Page.dart';
import 'package:upato/actu/actualiter.dart';
import 'package:upato/event/event.dart';
import 'package:upato/style.dart';

class Drawers extends StatefulWidget {
  const Drawers({Key? key}) : super(key: key);

  @override
  _DrawersState createState() => _DrawersState();
}

class _DrawersState extends State<Drawers> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 250,
      child: ListView(children: [
        DrawerHeader(
          child: Image.asset('assets/images/logo.png'),
        ),
        Card(
          child: ListTile(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const Actu_Home()),
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
                MaterialPageRoute(
                    builder: (context) => const Event_Home_Page()),
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
                  builder: (context) => const Podcast(),
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
      ]),
    );
  }
}
