import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pokepedia1/resgister_screen.dart';
import 'package:pokepedia1/home_screen.dart';
import 'package:pokepedia1/login_screen.dart';
import 'package:pokepedia1/splash_screen.dart';
import 'package:pokepedia1/favorite_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'POKEPEDIA',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      initialRoute: '/splash', // Establecer la ruta inicial como '/register'
      routes: {
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/home': (context) => HomeScreen(),  // Agrega esta línea
        '/splash':(context) => SplashScreen(),
        '/favorite':(context) => FavoriteScreen(),
      },
    );
  }
}
