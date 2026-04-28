//Punto de entrada principal de la app
import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const MyApp()); // Iniciar la aplicación
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Monitor ECG', //Título de la app
      debugShowCheckedModeBanner: false, //Se oculta etiqueta "Debug"
      theme: ThemeData(
        primarySwatch: Colors.red, //Color principal rojo
        useMaterial3: true,
      ),
      home: const LoginScreen(), //Pantalla que se muestra al abrir la app
    );
  }
}