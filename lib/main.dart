import 'package:flutter/material.dart';
import 'package:tukuntech/features/home/presentation/pages/home_page.dart';
import 'package:tukuntech/features/login/presentation/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
  debugShowCheckedModeBanner: false,
  title: 'Tukuntech',
  theme: ThemeData(useMaterial3: true),
  initialRoute: '/login',
  routes: {
    '/login': (_) => const LoginPage(),
    '/home': (_) => const HomePage(),
  
  },
);
  }
}
