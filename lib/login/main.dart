
import 'package:firebase_auth/firebase_auth.dart' as autt;

import 'package:flutter/material.dart';



import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:upato/login/authServices.dart';
import 'package:upato/login/firebase_api.dart';
import 'package:upato/login/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseApi().initNotifications();
  Supabase.initialize(
    url: 'https://rggeeykubskxurwxclwl.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJnZ2VleWt1YnNreHVyd3hjbHdsIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTg4NzQ4NzIsImV4cCI6MjAxNDQ1MDg3Mn0.G9wWmL6bFPFFrO3tTvYtRjqwrNkr26RVWGskSxSAHx4',
  );

  // runApp(prov.MultiProvider(
  //   providers: [
  //     prov.StreamProvider<autt.User?>.value(
  //       initialData: null,
  //       value: AuthService().user,
  //     ),
  //   ],
  //   child: const HomeLogin(),
  // ));
}
class HomeLogin extends StatefulWidget {
  const HomeLogin({Key? key}) : super(key: key);

  @override
  State<HomeLogin> createState() => _HomeLoginState();
}

class _HomeLoginState extends State<HomeLogin> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<autt.User?>(
      initialData: null,
      stream: AuthService().user,
      builder: (context, snapshot) {
        final user = snapshot.data;
        return MaterialApp(
          title: 'Gayux',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Colors.white,
            textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
            visualDensity: VisualDensity.adaptivePlatformDensity,
            appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
            buttonTheme: const ButtonThemeData(
              buttonColor: Colors.amber,
              textTheme: ButtonTextTheme.primary,
            ),
          ),
        ///  home: user != null ? const HomeScreenPayement() : const Login(),
        /// 
        home: Login(),
        );
      },
    );
  }
}
