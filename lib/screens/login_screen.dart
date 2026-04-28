//Pantalla de inicio de sesión
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //Controladores para leer el texto de los campos
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _handleLogin() {
    //Función que se inicia al presionar el botón de iniciar sesión
    final username = _usernameController.text.trim(); //Elimina espacios al inicio y al final
    final password = _passwordController.text;

    if (username.isEmpty || password.isEmpty) { //Validar si ambos campos tiene contenido
      _showError('Por favor ingresa usuario y contraseña');
      //Despues, aquí senavegará a la pantalla principal
    } else {
      // Por ahora solo muestra un mensaje de éxito
      _showSuccess('Bienvenido $username');
    }
  }

  void _showError(String message) {
    //Muestra mensjae de error en rojo
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  void _showSuccess(String message) {
    //Muestra mensaje de éxito en verde
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.green),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0), //margen interior 
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, //centra verticalmente 
          children: [
            const Icon(Icons.favorite, size: 80, color: Colors.red), //icono de corazón rojo
            const SizedBox(height: 20),
            const Text('Monitor ECG', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)), //Título de la app
            const SizedBox(height: 40),
            TextField( //Campo de texto para ingresar el usuario
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Nombre de usuario',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 16),
            TextField( //Campo de texto para ingresar la contraseña
              controller: _passwordController,
              obscureText: true, //Los caracteres se ven como puntos
              decoration: const InputDecoration(
                labelText: 'Contraseña',
                border: OutlineInputBorder(), 
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton( //Botón de inicio de sesión
              onPressed: _handleLogin,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50), //Ancho completo
                backgroundColor: Colors.red,
              ),
              child: const Text('Iniciar sesión', style: TextStyle(fontSize: 16)),
            ),
            const SizedBox(height: 16),
            TextButton( //Botón para ir al registro (Aún no funciona)
              onPressed: () { //Navegar a pantalla de registro (siguiente paso)
                // TODO: Navegar a registro (próximo paso)
              },
              child: const Text('¿No tienes cuenta? Regístrate'),
            ),
          ],
        ),
      ),
    );
  }
}