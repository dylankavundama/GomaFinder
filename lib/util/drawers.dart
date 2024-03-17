import 'package:flutter/material.dart';
import 'package:upato/actu/actualiter.dart';
import 'package:upato/event/event.dart';
import 'package:upato/style.dart';

class Drawers extends StatelessWidget {
  const Drawers({
    super.key,
  });

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
            title: Text(
              'Football Club',
              style: TitreStyle,
            ),
            trailing: Icon(Icons.arrow_circle_right, color: CouleurPrincipale),
          ),
        ),
        Card(
          child: ListTile(
            title: Text(
              'Podcast',
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
            title: Text(
              'Live Radio',
              style: TitreStyle,
            ),
            trailing: Icon(Icons.arrow_circle_right, color: CouleurPrincipale),
          ),
        ),
      ]),
      width: 250,
    );
  }
}
