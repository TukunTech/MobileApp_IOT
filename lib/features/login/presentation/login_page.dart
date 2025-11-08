import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _secure = const FlutterSecureStorage();

  bool _isLoading = false;
  bool _obscure = true;

  static const _loginUrl =
      'https://tukuntech-back.onrender.com/api/v1/auth/login';

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final res = await http
          .post(
            Uri.parse(_loginUrl),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            body: jsonEncode({
              'email': _emailCtrl.text.trim(),
              'password': _passCtrl.text,
            }),
          )
          .timeout(const Duration(seconds: 20));

      if (res.statusCode >= 200 && res.statusCode < 300) {
        // Parse flexible del token según posibles formatos del backend.
        final data = jsonDecode(res.body);
        String? token;

        // Intentos comunes
        token = (data['token'] ??
                data['access_token'] ??
                data['accessToken'] ??
                (data['data'] is Map ? data['data']['token'] : null))
            ?.toString();

        // Guarda token si existe (opcional, pero útil para futuras llamadas)
        if (token != null && token.isNotEmpty) {
          await _secure.write(key: 'auth_token', value: token);
        }

        if (!mounted) return;
        // Navega al home
        Navigator.of(context).pushNamedAndRemoveUntil('/home', (_) => false);
      } else {
        // Intenta extraer mensaje de error del backend
        String message = 'Credenciales inválidas';
        try {
          final err = jsonDecode(res.body);
          message = (err['message'] ??
                  err['error'] ??
                  err['detail'] ??
                  'Error de autenticación')
              .toString();
        } catch (_) {}
        if (!mounted) return;
        _showSnack(message);
      }
    } catch (e) {
      if (!mounted) return;
      _showSnack('No se pudo conectar con el servidor. Revisa tu conexión.');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }

  @override
  Widget build(BuildContext context) {
    const beige = Color(0xFFF0E8D5); // fondo completo
    const field = Color(0xFF3A3A3A);

    return Scaffold(
      backgroundColor: beige,
      body: SafeArea(
        child: Center(
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
                    'SIGN IN',
                    // corregido "SING" -> "SIGN"
                    style: GoogleFonts.josefinSans(
                      fontSize: 36,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.0,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 18),

                  // FORM
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // Email
                        Container(
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
                          child: TextFormField(
                            controller: _emailCtrl,
                            keyboardType: TextInputType.emailAddress,
                            style: GoogleFonts.darkerGrotesque(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            validator: (v) {
                              final value = v?.trim() ?? '';
                              if (value.isEmpty) {
                                return 'Ingresa tu correo';
                              }
                              // Validación simple de email
                              final emailRe = RegExp(r'^\S+@\S+\.\S+$');
                              if (!emailRe.hasMatch(value)) {
                                return 'Correo no válido';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              icon: const Icon(Icons.person_outline,
                                  color: Colors.white70),
                              hintText: 'email',
                              hintStyle: GoogleFonts.darkerGrotesque(
                                color: Colors.white70,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 14),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Password
                        Container(
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
                          child: TextFormField(
                            controller: _passCtrl,
                            obscureText: _obscure,
                            style: GoogleFonts.darkerGrotesque(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            validator: (v) {
                              if ((v ?? '').isEmpty) {
                                return 'Ingresa tu contraseña';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              icon: const Icon(Icons.lock_outline,
                                  color: Colors.white70),
                              hintText: 'password',
                              hintStyle: GoogleFonts.darkerGrotesque(
                                color: Colors.white70,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 14),
                              suffixIcon: IconButton(
                                onPressed: () =>
                                    setState(() => _obscure = !_obscure),
                                icon: Icon(
                                  _obscure
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  color: Colors.white70,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  Center(
                    child: SizedBox(
                      width: 160,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          shape: const StadiumBorder(),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          elevation: 0,
                        ),
                        child: _isLoading
                            ? const SizedBox(
                                height: 18,
                                width: 18,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              )
                            : Text(
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
                      onPressed: _isLoading
                          ? null
                          : () => Navigator.of(context)
                              .pushReplacementNamed('/register'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        shape: const StadiumBorder(),
                        padding: const EdgeInsets.symmetric(vertical: 12),
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
      ),
    );
  }
}
