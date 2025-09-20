import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  final int currentIndex;

  const BottomBar({super.key, required this.currentIndex});

  void _navigate(BuildContext context, int index) {
    if (index == currentIndex) return;
    
  }

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color(0xFF1C1C1C); 
    const activeBackground = Color(0xFF3A3A3A);

    return Container(
      color: backgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _navItem(context, asset: "assets/home_icon.png", index: 0, activeBackground: activeBackground),
          _navItem(context, asset: "assets/vitalsigns_icon.png", index: 1, activeBackground: activeBackground),
          _navItem(context, asset: "assets/history_icon.png", index: 2, activeBackground: activeBackground),
          _navItem(context, asset: "assets/profile_icon.png", index: 3, activeBackground: activeBackground),
        ],
      ),
    );
  }

  Widget _navItem(
    BuildContext context, {
    required String asset,
    required int index,
    required Color activeBackground,
  }) {
    final bool isActive = index == currentIndex;

    return GestureDetector(
      onTap: () => _navigate(context, index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isActive ? activeBackground : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Image.asset(
          asset,
          width: 28,
          height: 28,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
