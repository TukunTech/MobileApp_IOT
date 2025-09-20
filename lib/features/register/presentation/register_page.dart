import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    const beige = Color(0xFFF0E8D5);

    return Scaffold(
      backgroundColor: beige,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              right: 12,
              top: 8,
              child: Text(
                'REGISTER',
                style: GoogleFonts.josefinSans(
                  color: const Color(0xFF1B1B1B),
                  fontSize: 12,
                  letterSpacing: 1.2,
                ),
              ),
            ),

            // Contenido
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 380),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset('assets/icon.png', height: 56),
                      const SizedBox(height: 6),
                      Text(
                        'TUKUNTECH',
                        style: GoogleFonts.josefinSans(
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.1,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'WELCOME',
                        style: GoogleFonts.josefinSans(
                          fontSize: 36,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.0,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Please complete all fields',
                        style: GoogleFonts.darkerGrotesque(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const _DarkFieldBox(hint: 'name', icon: Icons.person_outline),
                      const SizedBox(height: 12),
                      const _DarkFieldBox(hint: 'password', icon: Icons.lock_outline, obscure: true),
                      const SizedBox(height: 12),
                      const _DarkFieldBox(hint: 'password', icon: Icons.lock_outline, obscure: true),
                      const SizedBox(height: 12),
                      const _DarkFieldBox(hint: 'password', icon: Icons.lock_outline, obscure: true),
                      const SizedBox(height: 12),
                      const _DarkFieldBox(hint: 'password', icon: Icons.lock_outline, obscure: true),
                      const SizedBox(height: 12),
                      const _DarkFieldBox(hint: 'password', icon: Icons.lock_outline, obscure: true),
                      const SizedBox(height: 12),
                      const _DarkFieldBox(hint: 'password', icon: Icons.lock_outline, obscure: true),
                      const SizedBox(height: 12),
                      const _DarkFieldBox(hint: 'password', icon: Icons.lock_outline, obscure: true),

                      const SizedBox(height: 18),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushNamedAndRemoveUntil('/login', (r) => false);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            shape: const StadiumBorder(),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            elevation: 0,
                          ),
                          child: Text(
                            'Create',
                            style: GoogleFonts.josefinSans(
                              fontWeight: FontWeight.w800,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DarkFieldBox extends StatelessWidget {
  final String hint;
  final IconData? icon;
  final bool obscure;

  const _DarkFieldBox({
    super.key,
    required this.hint,
    this.icon,
    this.obscure = false,
  });

  @override
  Widget build(BuildContext context) {
    const field = Color(0xFF3A3A3A);

    return Container(
      decoration: BoxDecoration(
        color: field,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 3,
            offset: Offset(0, 1.5),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: TextField(
        obscureText: obscure,
        style: GoogleFonts.darkerGrotesque(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        decoration: InputDecoration(
          icon: icon != null ? Icon(icon, color: Colors.white70) : null,
          hintText: hint,
          hintStyle: GoogleFonts.darkerGrotesque(
            color: Colors.white70,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          border: InputBorder.none,
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }
}
