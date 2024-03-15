import 'package:upato/detailpage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:upato/profil/insert_data.dart';
import 'package:upato/style.dart';
import 'onboarding_screen.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await Future.delayed(Duration(seconds: 1));
  FlutterNativeSplash.remove();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top]);
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.green,
        
          buttonColor: CouleurPrincipale,

          fixTextFieldOutlineLabel: true,
           // Primary color for the app
          accentColor: CouleurPrincipale, // Accent color for the app
          useMaterial3: false),
      debugShowCheckedModeBanner: false,
   home: OnboardingScreen(),

    // home:     AddSalaire(),
    );
  }
}
