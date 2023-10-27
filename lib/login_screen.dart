import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

void _login(BuildContext context) async {
  try {
    await _auth.signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    );
    // Inicio de sesión exitoso, redirige a la pantalla principal (HomeScreen).
    Navigator.pushReplacementNamed(context, '/home');  // Esto redirige al usuario a HomeScreen
  } catch (e) {
    print(e.toString());
  }
}


  void _goToRegister(BuildContext context) {
    // Redirige al usuario a la pantalla de registro.
    Navigator.pushReplacementNamed(context, '/register');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio de Sesión'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Agregamos una imagen desde un asset arriba de los text inputs
            Image.asset('assets/images/pokewikilog.png', height: 100),
            SizedBox(height: 20),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Correo Electrónico',
              prefixIcon: Icon(Icons.email),),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Contraseña',
              prefixIcon: Icon(Icons.lock),),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _login(context);
              },
              child: Text('Iniciar Sesión'),
            ),
            SizedBox(height: 10), // Espacio entre los botones
            TextButton(
              onPressed: () => _goToRegister(context),
              child: Text('¿No tienes una cuenta? Regístrate aquí'),
            ),
          ],
        ),
      ),
    );
  }
}
