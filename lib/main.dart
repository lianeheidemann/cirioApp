import 'package:flutter/material.dart';

import 'features/map/presentation/pages/map_page.dart';

// Inicializa o aplicativo
void main() {
  runApp(
    const MyApp(),
  );
}

// Widget/Classe principal do projeto
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Nome do aplicativo
      title: 'Círio Map',

      // Remove banner de debug
      debugShowCheckedModeBanner:
          false,

      // Define página inicial
      home: const MapPage(),
    );
  }
}