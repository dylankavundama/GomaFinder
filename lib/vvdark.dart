import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:upato/actu/actualiter.dart';
import 'package:upato/event/event.dart';
import 'package:upato/Screen/podecast/Podcast_Page.dart';
import 'package:upato/style.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void toggleDarkMode() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return MaterialApp(
          theme: themeProvider.isDarkMode ? ThemeData.dark() : ThemeData.light(),
          debugShowCheckedModeBanner: false,
          home: MyHomePage(),
        );
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My App'),
      ),
      body: Drawers(),
    );
  }
}

class Drawers extends StatelessWidget {
  const Drawers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

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
        // Autres éléments de la liste de votre tiroir ici...

        // Ajout du bouton de changement de mode
        Card(
          child: ListTile(
            onTap: () => themeProvider.toggleDarkMode(),
            title: Text(
              themeProvider.isDarkMode ? 'Mode Clair' : 'Mode Sombre',
              style: TitreStyle,
            ),
            trailing: Icon(Icons.lightbulb, color: themeProvider.isDarkMode ? Colors.white : Colors.black), // Icône du bouton
          ),
        ),
      ]),
      width: 250,
    );
  }
}
