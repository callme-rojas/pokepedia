import 'package:pokepedia1/login_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Agregar un temporizador para esperar 3 segundos y luego navegar a la pantalla de inicio de sesión
    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white, // Fondo blanco
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Deja solo la imagen en el Container
              Container(
                width: 200, // Ancho deseado
                height: 200, // Alto deseado
                child: Image.asset(
                  'assets/images/pokewikilog.png',
                  fit: BoxFit.contain, // Ajustar la imagen al contenedor
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Text(
                  '¡Bienvenido a la Enciclopedia Pokémon!',
                  style: TextStyle(fontSize: 14, color: Colors.black),
                  textAlign:
                      TextAlign.center, // Alinear al centro horizontalmente
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
