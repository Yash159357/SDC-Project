import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project/screens/auth.dart';
import 'package:project/screens/auth2.dart';

import 'package:project/firebase_options.dart';
import 'package:project/screens/home.dart';

// yash@gmail.com 159357
final kColorScheme =
    ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 255, 0, 0));
final kDarkColorScheme =
    ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 255, 0, 0));

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(ProviderScope(
    child: MaterialApp(
      theme: ThemeData().copyWith(
        colorScheme: kColorScheme,
      ),
      themeMode: ThemeMode.light,
      // home: StreamBuilder(
      //     stream: FirebaseAuth.instance.authStateChanges(),
      //     builder: (ctx, snapshot) {
      //       // if (snapshot.connectionState == ConnectionState.waiting) {
      //       //   return const SplashScreen();
      //       // }
  
      //       if (snapshot.hasData) {
      //         return const HomeScreen();
      //       }
  
      //       return const Auth2Screen();
      //     }),
      home: HomeScreen(),
    ),
  ));
}
