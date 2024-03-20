// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:upato/login/authServices.dart';
import 'package:upato/profil/insert_data.dart';
import 'package:upato/style.dart';
import 'package:url_launcher/url_launcher.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool inLoginProcess = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
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
                  'Films,Animations et Documentaires en Illimités',
                  //  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline4?.copyWith(
                        color: Colors.white,
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
                  'Laissez vous emporter',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 55),
              ),
              Image.asset(
                  height: 280.0,
                  width: MediaQuery.of(context).size.width,
                  'assets/brand.png'),
              inLoginProcess
                  ? const Center(child: CircularProgressIndicator())
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () => signIn(context),
                          icon: Image.asset(
                            'assets/g.png', // Remplacez par votre propre icône de Google
                            height: 24.0,
                          ),
                          label: Text('Connectez-vous avec Google'),
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
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.09,
              ),
              const Padding(
                padding: EdgeInsets.all(30.0),
                child: Text(
                    //  "By registering,you agree to gayux Terms of use and privacy policy",
                    "En vous inscrivant,vous acceptez\nLes conditions d'utilisation et la politique de confidentialité de Gayux",
                    style: TextStyle(color: Colors.white54)),
              ),
              GestureDetector(
                // onTap: () {
                //   Navigator.of(context)
                //       .push(MaterialPageRoute(builder: (context) => condition()));
                // },
                onTap: () {
                  launch(
                      'https://github.com/dylankavundama/policy-privacy/blob/main/privacy-policy.md');
                },
                child: Text(
                  //    "Lire les conditions",
                  "PRIVACY POLICY",
                  style: TextStyle(color: CouleurPrincipale),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future signIn(BuildContext context) async {
    if (kIsWeb) {
      setState(() {
        inLoginProcess = true;
        AuthService().signInWithGoogle();
      });
    } else {
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          setState(() async {
            inLoginProcess = true;
            AuthService().signInWithGoogle().then(
              (value) {
                debugPrint("===============================================");
                debugPrint("User : ${value.user!.email}");
                if (value.user != null) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const Inset_Data()),
                  );
                }
              },
            );
          });
        }
      } on SocketException catch (_) {
        showNotification(context, 'Aucune connexion internet');
      }
    }
  }
}

void showNotification(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message)),
  );
}
