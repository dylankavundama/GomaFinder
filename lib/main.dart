import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:upato/NavBarPage.dart';
import 'package:upato/Screen/radio.dart';
import 'package:upato/detailpage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:upato/event/event.dart';
import 'package:upato/podecast/live_radio/main.dart';
import 'package:upato/profil/insert_data.dart';
import 'package:upato/profil/list_insert.dart';
import 'package:upato/style.dart';
import 'onboarding_screen.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  AssetsAudioPlayer.setupNotificationsOpenAction((notification) {
    return true;
  });

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Future.delayed(Duration(seconds: 1));
  FlutterNativeSplash.remove();
  await Supabase.initialize(
      url: 'https://rggeeykubskxurwxclwl.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJnZ2VleWt1YnNreHVyd3hjbHdsIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTg4NzQ4NzIsImV4cCI6MjAxNDQ1MDg3Mn0.G9wWmL6bFPFFrO3tTvYtRjqwrNkr26RVWGskSxSAHx4');
  //   OneSignal.shared.setAppId("955d05bf-3ef9-4287-8e23-9bc3e68cb057");

  // OneSignal.shared.setNotificationWillShowInForegroundHandler(
  //     (OSNotificationReceivedEvent event) {});
  // OneSignal.shared
  //     .promptUserForPushNotificationPermission()
  //     .then((accepted) {});
  //   SystemChrome.setEnabledSystemUIMode(
  //   SystemUiMode.manual,
  //   overlays: [],
  // );

  //       SystemChrome.setSystemUIOverlayStyle(
  //   SystemUiOverlayStyle(
  //     statusBarColor: Colors.green,
  //     statusBarBrightness: Brightness.light,
  //   ),
  // );
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
      // home: Actualite_Page(),
//home: Event_Home_Page(),
    home:     OnboardingScreen(),
    //  home: Home_Radio(),
    );
  }
}
