import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:serenity_u/Screens/Graph.dart';
import 'package:serenity_u/Screens/Notes.dart';
import 'package:serenity_u/Screens/homepage.dart';
import 'package:serenity_u/Screens/signup.dart';
import 'package:serenity_u/Screens/splahscreen.dart';
import 'Auth/firebaseOptions.dart';
import 'Screens/anxiety_history.dart';
import 'Screens/loginpage.dart';
import 'dart:ui';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Initialize AuthService
  await Firebase.initializeApp(options: firebaseOptions);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => SplashScreen(),
        '/login': (context) => LoginPage(),
        '/home': (context) => homepage(),
        '/notes': (context) => notes(),
        '/history': (context) => AnxietyHistory(),
        '/graph': (context) => graphs(),
        '/signup': (context) => signup(),
      },
    );
  }
}

