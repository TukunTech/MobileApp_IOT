import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:tukuntech/core/auth_session.dart';

class RegisterUserPage extends StatefulWidget {
  const RegisterUserPage({super.key});

  @override
  State<RegisterUserPage> createState() => _RegisterUserPageState();
}

class _RegisterUserPageState extends State<RegisterUserPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();

  bool _isLoading = false;
  bool _obscure = true;

  // Si tus roles están definidos, ajusta esta lista.
  static const List<String> _roles = ['ADMINISTRATOR', 'ATTENDANT', 'PATIENT'];
  String _role = _roles.first;

  static const _registerUrl =
      'https://tukuntech-back.onrender.com/api/v1/auth/register';

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
  if (!_formKey.currentState!.validate()) return;

  setState(() => _isLoading = true);
  try {
    final body = {
      "email": _emailCtrl.text.trim(),
      "password": _passCtrl.text,
      "role": _role, // ej: PATIENT
    };

    // 1) REGISTRO
    final regRes = await http.post(
      Uri.parse('https://tukuntech-back.onrender.com/api/v1/auth/register'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(body),
    ).timeout(const Duration(seconds: 20));

    if (regRes.statusCode < 200 || regRes.statusCode >= 300) {
      String message = 'No se pudo crear el usuario';
      try {
        final err = jsonDecode(regRes.body);
        message = (err['message'] ?? err['error'] ?? message).toString();
      } catch (_) {}
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
      setState(() => _isLoading = false);
      return;
    }

    // 2) LOGIN AUTOMÁTICO PARA OBTENER TOKEN
    final loginRes = await http.post(
      Uri.parse('https://tukuntech-back.onrender.com/api/v1/auth/login'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({
        "email": _emailCtrl.text.trim(),
        "password": _passCtrl.text,
      }),
    ).timeout(const Duration(seconds: 20));

    if (loginRes.statusCode >= 200 && loginRes.statusCode < 300) {
      final data = jsonDecode(loginRes.body);
      final token = (data['token'] ??
                     data['access_token'] ??
                     data['accessToken'] ??
                     (data['data'] is Map ? data['data']['token'] : null))
          ?.toString();

      if (token == null || token.isEmpty) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No se recibió token de autenticación.'))
        );
        setState(() => _isLoading = false);
        return;
      }

      // Guarda el token en memoria (o secure storage si prefieres)
      AuthSession.setToken(token);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Usuario creado. Continuemos con tu perfil'))
      );

      // 3) IR A REGISTRAR PACIENTE (perfil)
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/register-patient', (_) => false);
    } else {
      String message = 'Registro ok, pero no se pudo iniciar sesión';
      try {
        final err = jsonDecode(loginRes.body);
        message = (err['message'] ?? err['error'] ?? message).toString();
      } catch (_) {}
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
    }
  } catch (e) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Error de conexión.'))
    );
  } finally {
    if (mounted) setState(() => _isLoading = false);
  }
}

  @override
  Widget build(BuildContext context) {
    const beige = Color(0xFFF0E8D5);
    const field = Color(0xFF3A3A3A);

    InputDecoration _darkDecoration({
      required String hint,
      IconData? icon,
      Widget? suffix,
    }) {
      return InputDecoration(
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
        suffixIcon: suffix,
      );
    }

    BoxDecoration _darkBox() => BoxDecoration(
          color: field,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 3,
              offset: Offset(0, 1.5),
            ),
          ],
        );

    TextStyle _fieldStyle() => GoogleFonts.darkerGrotesque(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        );

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
                  Image.asset('assets/icon.png', height: 80),
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
                    'CREATE ACCOUNT',
                    style: GoogleFonts.josefinSans(
                      fontSize: 32,
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

                  // ===== FORM =====
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // Email
                        Container(
                          decoration: _darkBox(),
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: TextFormField(
                            controller: _emailCtrl,
                            keyboardType: TextInputType.emailAddress,
                            style: _fieldStyle(),
                            validator: (v) {
                              final value = v?.trim() ?? '';
                              if (value.isEmpty) return 'Ingresa tu correo';
                              final emailRe = RegExp(r'^\S+@\S+\.\S+$');
                              if (!emailRe.hasMatch(value)) {
                                return 'Correo no válido';
                              }
                              return null;
                            },
                            decoration: _darkDecoration(
                              hint: 'email',
                              icon: Icons.alternate_email_outlined,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Password
                        Container(
                          decoration: _darkBox(),
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: TextFormField(
                            controller: _passCtrl,
                            obscureText: _obscure,
                            style: _fieldStyle(),
                            validator: (v) {
                              final t = v ?? '';
                              if (t.isEmpty) return 'Ingresa tu contraseña';
                              if (t.length < 6) {
                                return 'Mínimo 6 caracteres';
                              }
                              return null;
                            },
                            decoration: _darkDecoration(
                              hint: 'password',
                              icon: Icons.lock_outline,
                              suffix: IconButton(
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
                        const SizedBox(height: 12),

                        // Role
                        Container(
                          decoration: _darkBox(),
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: DropdownButtonFormField<String>(
                            value: _role,
                            isExpanded: true,
                            dropdownColor: const Color(0xFF3A3A3A),
                            iconEnabledColor: Colors.white70,
                            style: _fieldStyle(),
                            decoration: _darkDecoration(
                              hint: 'role',
                              icon: Icons.verified_user_outlined,
                            ),
                            items: _roles
                                .map((r) => DropdownMenuItem(
                                      value: r,
                                      child: Text(r),
                                    ))
                                .toList(),
                            onChanged: (r) =>
                                setState(() => _role = r ?? _roles.first),
                            validator: (v) =>
                                (v == null || v.isEmpty) ? 'Selecciona un rol' : null,
                          ),
                        ),
                        const SizedBox(height: 18),

                        // Submit
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _submit,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                              shape: const StadiumBorder(),
                              padding:
                                  const EdgeInsets.symmetric(vertical: 14),
                              elevation: 0,
                            ),
                            child: _isLoading
                                ? const SizedBox(
                                    height: 18,
                                    width: 18,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Text(
                                    'Create',
                                    style: GoogleFonts.josefinSans(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 16,
                                    ),
                                  ),
                          ),
                        ),

                        const SizedBox(height: 10),
                        TextButton(
                          onPressed: _isLoading
                              ? null
                              : () => Navigator.of(context)
                                  .pushNamedAndRemoveUntil('/login', (_) => false),
                          child: Text(
                            'Already have an account? Sign in',
                            style: GoogleFonts.darkerGrotesque(
                              fontSize: 14,
                              color: Colors.black87,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
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
