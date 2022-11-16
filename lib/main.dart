import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:fluttertravelwild/pages/profile_page.dart';
// import 'package:fluttertravelwild/pages/HomePage.dart';
// import 'package:fluttertravelwild/pages/ListplacePage.dart';

import 'package:fluttertravelwild/pages/splash_page.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TravelWild',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('es', 'CO'),
      ],
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: const Splash(),
 
    );
  }
}
