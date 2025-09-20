import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    const beige = Color(0xFFF0E8D5); // fondo completo
    return Scaffold(
      backgroundColor: beige,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 380),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset('assets/icon.png', height: 120),
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
                        'SING IN',
                        style: GoogleFonts.josefinSans(
                          fontSize: 36,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.0,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 18),

                      const _DarkFieldBox(
                        hint: 'username',
                        icon: Icons.person_outline,
                      ),
                      const SizedBox(height: 12),
                      const _DarkFieldBox(
                        hint: 'password',
                        icon: Icons.lock_outline,
                        obscure: true,
                      ),
                      const SizedBox(height: 16),

                      Center(
                        child: SizedBox(
                          width: 160,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                '/home', 
                                (route) => false,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                              shape: const StadiumBorder(),
                              padding:
                                  const EdgeInsets.symmetric(vertical: 12),
                              elevation: 0,
                            ),
                            child: Text(
                              'Log In',
                              style: GoogleFonts.josefinSans(
                                fontWeight: FontWeight.w800,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 18),
                      Text(
                        'ARE YOU NEW?',
                        style: GoogleFonts.josefinSans(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "If you don't have an account, you can create one",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.darkerGrotesque(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: 140,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushReplacementNamed('/register');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            shape: const StadiumBorder(),
                            padding:
                                const EdgeInsets.symmetric(vertical: 12),
                            elevation: 0,
                          ),
                          child: Text(
                            'Create',
                            style: GoogleFonts.josefinSans(
                              fontWeight: FontWeight.w800,
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
