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
        title: Row(
          children: [
            const ToggleSidebar(), 
            const SizedBox(width: 8),
            Text(
              title,
              style: GoogleFonts.darkerGrotesque(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: const Color(0xFFF0E8D5),
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Image.asset(
              "assets/icon.png",
              width: 50,
              height: 50,
            ),
          ),
        ],
      ),
      body: SafeArea(child: child),
      bottomNavigationBar: BottomBar(currentIndex: currentIndex),
    );
  }
}
