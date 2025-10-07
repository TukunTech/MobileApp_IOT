import 'package:flutter/material.dart';
import 'package:tukuntech/features/history/presentation/pages/history_page.dart';
import 'package:tukuntech/features/home/presentation/pages/home_page.dart';
import 'package:tukuntech/features/login/presentation/login_page.dart';
import 'package:tukuntech/features/register/presentation/register_page.dart';
import 'package:tukuntech/features/profile/presentation/profile_page.dart';
import 'package:tukuntech/features/support/presentation/pages/support_page.dart';
import 'package:tukuntech/features/subscription/presentation/pages/subscription_page.dart';
import 'package:tukuntech/features/vitalsigns/presentation/pages/vitalsigns_page.dart';
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
        '/register': (_) => const RegisterPage(),
        '/home': (_) => const HomePage(),
        '/profile': (_) => const ProfilePage(),
        '/support':(_) => const SupportPage(),
        '/subscription': (context) => const SubscriptionPage(),
        '/vitals': (context) => const VitalSignsPage(),
        '/history': (context) => const HistoryPage(),
      },
    );
  }
}

