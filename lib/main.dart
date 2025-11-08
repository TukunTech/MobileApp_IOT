import 'package:flutter/material.dart';
import 'package:tukuntech/features/history/presentation/pages/history_page.dart';
import 'package:tukuntech/features/home/presentation/pages/home_page.dart';
import 'package:tukuntech/features/login/presentation/login_page.dart';
import 'package:tukuntech/features/register/presentation/registerPatient_page.dart';
import 'package:tukuntech/features/register/presentation/registerAccount_page.dart';
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
  // ... tus props
  routes: {
    '/login': (_) => const LoginPage(),
    '/register-user': (_) => const RegisterUserPage(),
    '/register-patient': (_) => const RegisterPage(),
    '/home': (_) => const HomePage(),
    '/profile': (_) => const ProfilePage(),
    '/support': (_) => const SupportPage(),
    '/subscription': (_) => const SubscriptionPage(),
    '/vitals': (_) => const VitalSignsPage(),
    '/history': (_) => const HistoryPage(),
  },
  onGenerateRoute: (settings) {
    if (settings.name == '/register') {
      // redirige a la nueva ruta
      return MaterialPageRoute(builder: (_) => const RegisterUserPage());
    }
    return null; // deja que 'routes' lo maneje
  },
  onUnknownRoute: (settings) =>
      MaterialPageRoute(builder: (_) => const LoginPage()),
);

  }
}

