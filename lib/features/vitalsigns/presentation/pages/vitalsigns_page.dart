import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:tukuntech/core/base_screen.dart';

class VitalSignsPage extends StatefulWidget {
  const VitalSignsPage({super.key});

  @override
  State<VitalSignsPage> createState() => _VitalSignsPageState();
}

class _VitalSignsPageState extends State<VitalSignsPage> {
  final List<FlSpot> _spots = [];
  Timer? _timer;
  double _xValue = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 150), (timer) {
      setState(() {
        _xValue += 1;
        double yValue = 0;
        if (_xValue % 20 == 0) {
          yValue = 2;
        } else if (_xValue % 20 == 1) {
          yValue = -1;
        } else {
          yValue = 0;
        }
        _spots.add(FlSpot(_xValue, yValue));
        if (_spots.length > 50) _spots.removeAt(0);
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Widget _miniChart(Color color) {
    return SizedBox(
      height: 30,
      child: LineChart(
        LineChartData(
          minX: _spots.isNotEmpty ? _spots.first.x : 0,
          maxX: _spots.isNotEmpty ? _spots.last.x : 50,
          minY: -2.5,
          maxY: 2.5,
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: _spots,
              isCurved: false,
              color: color,
              barWidth: 2,
              dotData: FlDotData(show: false),
            ),
          ],
        ),
      ),
    );
  }

  Widget _vitalCard({
  required String bellAsset,
  required String iconAsset,
  required String value,
  required String unit,
  required String label,
  required bool dark,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: dark ? Colors.black : const Color(0xFFF0E8D5), // negro puro
      borderRadius: BorderRadius.circular(16),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          label,
          style: GoogleFonts.darkerGrotesque(
            fontSize: 14,
            color: dark ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              bellAsset,
              width: 20,
              height: 20,
            ),
            const SizedBox(width: 16),
            Image.asset(
              iconAsset,
              width: 40,
              height: 40,
            ),
            const SizedBox(width: 16),
            Text(
              value,
              style: GoogleFonts.darkerGrotesque(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: dark ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(width: 6),
            Text(
              unit,
              style: GoogleFonts.darkerGrotesque(
                fontSize: 16,
                color: dark ? Colors.white70 : Colors.black87,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        _miniChart(dark ? Colors.white : Colors.black),
      ],
    ),
  );
}

  Widget _alertCard(String text) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.amber[700],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(Icons.warning, color: Colors.black, size: 24),
          const SizedBox(width: 8),
          Text(
            text,
            style: GoogleFonts.darkerGrotesque(
              fontSize: 18,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: "Vital Signs",
      currentIndex: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            _vitalCard(
              bellAsset: "assets/noti2.png",
              iconAsset: "assets/hearth.png",
              value: "179",
              unit: "Bpm",
              label: "Bpm",
              dark: false,
            ),
            _vitalCard(
              bellAsset: "assets/noti2.png",
              iconAsset: "assets/SpO2.png",
              value: "90%",
              unit: "",
              label: "SpO₂",
              dark: false,
            ),
            _vitalCard(
              bellAsset: "assets/noti1.png",
              iconAsset: "assets/temp2.png",
              value: "37.0",
              unit: "°C",
              label: "Temp",
              dark: true,
            ),
            const SizedBox(height: 16),
            Text(
              "Alerts",
              style: GoogleFonts.darkerGrotesque(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            _alertCard("Low oxygenation"),
            _alertCard("Low oxygenation"),
          ],
        ),
      ),
    );
  }
}
