import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterScreen extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _register(BuildContext context) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      // Registro exitoso, redirige a la pantalla de inicio de sesión.
      Navigator.pushReplacementNamed(context, '/login');
    } catch (e) {
      print(e.toString());
    }
  }

  void _goToLogin(BuildContext context) {
    // Redirige al usuario a la pantalla de inicio de sesión.
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Agregamos una imagen desde un asset arriba de los campos de texto
            Image.asset('assets/images/pokewikilog.png', height: 100),
            SizedBox(height: 20),
            // Campo de correo electrónico con un icono
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Correo Electrónico',
                prefixIcon: Icon(Icons.email),
              ),
            ),
            // Campo de contraseña con un icono de candado
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                prefixIcon: Icon(Icons.lock),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _register(context),
              child: Text('Registrar'),
            ),
            SizedBox(height: 10), // Espacio entre los botones
            TextButton(
              onPressed: () => _goToLogin(context),
              child: Text('¿Ya tienes una cuenta? Iniciar sesión'),
            ),
          ],
        ),
      ),
    );
  }
}
