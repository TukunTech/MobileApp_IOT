import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tukuntech/core/base_screen.dart';

class SubscriptionPage extends StatelessWidget {
  const SubscriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: "Subscription",
      currentIndex: 1,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black, // 👈 negro puro
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "YOUR PLAN",
                    style: GoogleFonts.josefinSans(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFF0E8D5),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Individual plan",
                    style: GoogleFonts.darkerGrotesque(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFF0E8D5),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Focused on people who want to maintain personal and preventive control of their health status, whether an older adult or someone with heart problems.\n\nIncluye:",
                    style: GoogleFonts.darkerGrotesque(
                      fontSize: 16,
                      color: const Color(0xFFF0E8D5),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _bullet("Acceso a la aplicación móvil y web."),
                      _bullet("Monitoreo en tiempo real de frecuencia cardiaca, saturación de oxígeno y temperatura."),
                      _bullet("Notificaciones inmediatas de alertas."),
                      _bullet("Historial de registros y gráficos de evolución."),
                      _bullet("Vigencia mensual o anual."),
                      _bullet("Conexión de 1 dispositivo."),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black, // 👈 negro puro
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "RENEW SUBSCRIPTION",
                    style: GoogleFonts.josefinSans(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFF0E8D5),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "You are currently paying:",
                    style: GoogleFonts.darkerGrotesque(
                      fontSize: 16,
                      color: const Color(0xFFF0E8D5),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "20\$",
                    style: GoogleFonts.darkerGrotesque(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFF0E8D5),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Do you want to continue with us?",
                    style: GoogleFonts.darkerGrotesque(
                      fontSize: 16,
                      color: const Color(0xFFF0E8D5),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF0E8D5),
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      "renew",
                      style: GoogleFonts.darkerGrotesque(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        "• $text",
        style: GoogleFonts.darkerGrotesque(
          fontSize: 16,
          color: const Color(0xFFF0E8D5),
        ),
      ),
    );
  }
}
