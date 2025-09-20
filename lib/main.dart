import 'package:flutter/material.dart';
import 'package:tukuntech/features/home/presentation/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Quita el banner de debug
      title: 'Tukuntech',
      theme: ThemeData(
        useMaterial3: true, // Opcional, da estilos más modernos
      ),
      home: const HomePage(), 
    );
  }
}
