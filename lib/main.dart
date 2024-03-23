import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:upato/NavBarPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:upato/Screen/podecast/live_radio/radio.dart';
import 'package:upato/detailpage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:upato/style.dart';
import 'Screen/Tv/Tv_Home.dart';
import 'onboarding_screen.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'channel_id', // Change to your desired channel id
  'Channel Name', // Change to your desired channel name
  'Channel Description', // Change to your desired channel description
  importance: Importance.high,
);

  WidgetsFlutterBinding.ensureInitialized();

  // Initialize timezone data
  tz.initializeTimeZones();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  final InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  // Demander les autorisations de notification
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
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
    OneSignal.shared.setAppId("955d05bf-3ef9-4287-8e23-9bc3e68cb057");

  OneSignal.shared.setNotificationWillShowInForegroundHandler(
      (OSNotificationReceivedEvent event) {});
  OneSignal.shared
      .promptUserForPushNotificationPermission()
      .then((accepted) {});
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
