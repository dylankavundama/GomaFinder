// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:upato/login/authServices.dart';

import 'package:upato/profil/insert_data.dart';
import 'package:upato/style.dart';
import 'package:url_launcher/url_launcher.dart';

class Login_Home extends StatefulWidget {
  const Login_Home({Key? key}) : super(key: key);

  @override
  _Login_HomeState createState() => _Login_HomeState();
}

class _Login_HomeState extends State<Login_Home> {
  bool inLogin_HomeProcess = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                  //  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline4?.copyWith(
                        color: Colors.black
                        ,
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
                "Veuillez vous identifier avant d'ajouter une entreprise",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 55),
              ),
              Image.asset(
                  height: 280.0,
                  width: MediaQuery.of(context).size.width,
                  'assets/images/image3.png'),
              inLogin_HomeProcess
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
 
  
            ],
          ),
        ),
      ),
    );
  }

  Future signIn(BuildContext context) async {
    if (kIsWeb) {
      setState(() {
        inLogin_HomeProcess = true;
        AuthService().signInWithGoogle();
      });
    } else {
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          setState(() async {
            inLogin_HomeProcess = true;
            AuthService().signInWithGoogle().then(
              (value) {
                debugPrint("===============================================");
                debugPrint("User : ${value.user!.email}");
                if (value.user != null) {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const Inset_Data()),
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
