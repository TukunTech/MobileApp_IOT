import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'bottom_nav_bar.dart';
import 'toggle_sidebar.dart';

class BaseScreen extends StatelessWidget {
  final Widget child;
  final int currentIndex;
  final String title;

  const BaseScreen({
    super.key,
    required this.child,
    required this.currentIndex,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1B1B1B),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1B1B1B),
        elevation: 0,
        leading: const ToggleSidebar(), // 👈 ahora está en la esquina
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.darkerGrotesque(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: const Color(0xFFF0E8D5),
              ),
            ),
            const SizedBox(height: 4),
            Container(
              height: 3,
              width: 140,
              color: const Color(0xFFF0E8D5),
            ),
          ],
        ),
        centerTitle: false, // 👈 asegura que se alinee a la izquierda
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Image.asset(
              "assets/icon.png",
              width: 42,
              height: 42,
            ),
          ),
        ],
      ),
      body: SafeArea(child: child),
      bottomNavigationBar: BottomBar(currentIndex: currentIndex),
    );
  }
}