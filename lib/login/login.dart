import 'package:flutter/material.dart';
import 'package:upato/login/authServices.dart';
import 'package:upato/profil/insert_data.dart';
import 'package:upato/style.dart';

class LoginHome extends StatefulWidget {
  const LoginHome({Key? key}) : super(key: key);

  @override
  _LoginHomeState createState() => _LoginHomeState();
}

class _LoginHomeState extends State<LoginHome> {
  bool _isLoggedIn = false;
  bool _inLoginProcess = false;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    // Vérifier si l'utilisateur est déjà connecté (implémentation dépendante de votre système d'authentification)
    bool isLoggedIn = await AuthService().isLoggedIn(); // Exemple hypothétique

    if (isLoggedIn) {
      // Si l'utilisateur est déjà connecté, naviguez vers la page de profil
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const Inset_Data()));
    } else {
      // Sinon, l'utilisateur doit se connecter
      setState(() {
        _isLoggedIn = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(children: [
          Text(
            'U',
            style: TextStyle(color: CouleurPrincipale),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 0),
          ),
          const Text(
            'PATO',
            style: TextStyle(color: Colors.black),
          ),
          const Icon(
            Icons.location_on_outlined,
            color: Colors.black,
            size: 18,
          )
        ]),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Text(
                  '',
                  style: Theme.of(context).textTheme.headline4?.copyWith(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10),
              ),
              const Center(
                child: Text(
                  " ",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 55),
              ),
              Image.asset(
                'assets/images/image3.png',
                height: 280.0,
                width: MediaQuery.of(context).size.width,
              ),
              _inLoginProcess
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton.icon(
                      onPressed: () => signIn(context),
                      icon: Image.asset(
                        'assets/g.png', // Remplacez par votre propre icône de Google
                        height: 24.0,
                      ),
                      label: const Text('Veuillez vous identifier'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        onPrimary: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> signIn(BuildContext context) async {
    setState(() {
      _inLoginProcess = true;
    });

    await AuthService().signInWithGoogle();

    setState(() {
      _inLoginProcess = false;
    });

    // Vérifier à nouveau l'état de connexion après la connexion
    await checkLoginStatus();
  }
}
