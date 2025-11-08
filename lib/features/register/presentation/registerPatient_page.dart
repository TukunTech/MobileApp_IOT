import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:tukuntech/core/auth_session.dart';

// ===== Enums requeridos por tu API =====
enum Gender { male, female, other }
enum BloodGroup {
  oPositive,
  oNegative,
  aPositive,
  aNegative,
  bPositive,
  bNegative,
  abPositive,
  abNegative,
}
enum Nationality { peruvian, other }
enum Allergy {
  none,
  penicillin,
  nuts,
  seafood,
  lactose,
  gluten,
  pollen,
  dust,
}

// ===== Extensiones para mapear a texto/API =====
extension GenderApi on Gender {
  String get api => switch (this) {
        Gender.male => 'MALE',
        Gender.female => 'FEMALE',
        Gender.other => 'OTHER',
      };
  String get label => switch (this) {
        Gender.male => 'Male',
        Gender.female => 'Female',
        Gender.other => 'Other',
      };
}

extension BloodGroupApi on BloodGroup {
  String get api => switch (this) {
        BloodGroup.oPositive => 'O_POSITIVE',
        BloodGroup.oNegative => 'O_NEGATIVE',
        BloodGroup.aPositive => 'A_POSITIVE',
        BloodGroup.aNegative => 'A_NEGATIVE',
        BloodGroup.bPositive => 'B_POSITIVE',
        BloodGroup.bNegative => 'B_NEGATIVE',
        BloodGroup.abPositive => 'AB_POSITIVE',
        BloodGroup.abNegative => 'AB_NEGATIVE',
      };
  String get label => api.replaceAll('_', ' ').toUpperCase();
}

extension NationalityApi on Nationality {
  String get api => switch (this) {
        Nationality.peruvian => 'PERUVIAN',
        Nationality.other => 'OTHER',
      };
  String get label => switch (this) {
        Nationality.peruvian => 'Peruvian',
        Nationality.other => 'Other',
      };
}

extension AllergyApi on Allergy {
  String get api => switch (this) {
        Allergy.none => 'NONE',
        Allergy.penicillin => 'PENICILLIN',
        Allergy.nuts => 'NUTS',
        Allergy.seafood => 'SEAFOOD',
        Allergy.lactose => 'LACTOSE',
        Allergy.gluten => 'GLUTEN',
        Allergy.pollen => 'POLLEN',
        Allergy.dust => 'DUST',
      };
  String get label => api[0] + api.substring(1).toLowerCase();
}

// ======= PAGE =======
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final _firstNameCtrl = TextEditingController();
  final _lastNameCtrl = TextEditingController();
  final _dniCtrl = TextEditingController();
  final _ageCtrl = TextEditingController();

  // Dropdown selections (con valores por defecto)
  Gender _gender = Gender.male;
  BloodGroup _bloodGroup = BloodGroup.oPositive;
  Nationality _nationality = Nationality.peruvian;
  Allergy _allergy = Allergy.none;

  bool _isLoading = false;

  static const _profilesUrl =
      'https://tukuntech-back.onrender.com/api/v1/profiles';

  @override
  void dispose() {
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _dniCtrl.dispose();
    _ageCtrl.dispose();
    super.dispose();
  }

Future<void> _submit() async {
  if (!_formKey.currentState!.validate()) return;

  final token = AuthSession.getToken();
  if (token == null || token.isEmpty) {
    // Si no hay token, evita 401 y guía al usuario
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Sesión no válida. Inicia sesión de nuevo.')),
    );
    if (!mounted) return;
    Navigator.of(context).pushNamedAndRemoveUntil('/login', (_) => false);
    return;
  }

  setState(() => _isLoading = true);
  try {
    final body = {
      "firstName": _firstNameCtrl.text.trim(),
      "lastName": _lastNameCtrl.text.trim(),
      "dni": _dniCtrl.text.trim(),
      "age": int.parse(_ageCtrl.text.trim()),
      "gender": _gender.api,
      "bloodGroup": _bloodGroup.api,
      "nationality": _nationality.api,
      "allergy": _allergy.api,
    };

    final res = await http.post(
      Uri.parse('https://tukuntech-back.onrender.com/api/v1/profiles'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token', // ← IMPORTANTE
      },
      body: jsonEncode(body),
    ).timeout(const Duration(seconds: 20));

    if (res.statusCode >= 200 && res.statusCode < 300) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Perfil creado correctamente')),
      );
      Navigator.of(context).pushNamedAndRemoveUntil('/home', (_) => false);
    } else {
      String message = 'No se pudo crear el perfil';
      try {
        final err = jsonDecode(res.body);
        message = (err['message'] ?? err['error'] ?? message).toString();
      } catch (_) {}
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
    }
  } catch (_) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Error de conexión.')),
    );
  } finally {
    if (mounted) setState(() => _isLoading = false);
  }
}


  @override
  Widget build(BuildContext context) {
    const beige = Color(0xFFF0E8D5);
    const field = Color(0xFF3A3A3A);

    InputDecoration _darkInputDecoration({
      required String hint,
      IconData? icon,
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
      );
    }

    BoxDecoration _darkBoxDecoration() => BoxDecoration(
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

    TextStyle _fieldTextStyle() => GoogleFonts.darkerGrotesque(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        );

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

                      // ===== FORM =====
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            // First name
                            Container(
                              decoration: _darkBoxDecoration(),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: TextFormField(
                                controller: _firstNameCtrl,
                                style: _fieldTextStyle(),
                                validator: (v) =>
                                    (v == null || v.trim().isEmpty)
                                        ? 'Ingresa tu nombre'
                                        : null,
                                decoration: _darkInputDecoration(
                                  hint: 'first name',
                                  icon: Icons.person_outline,
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),

                            // Last name
                            Container(
                              decoration: _darkBoxDecoration(),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: TextFormField(
                                controller: _lastNameCtrl,
                                style: _fieldTextStyle(),
                                validator: (v) =>
                                    (v == null || v.trim().isEmpty)
                                        ? 'Ingresa tu apellido'
                                        : null,
                                decoration: _darkInputDecoration(
                                  hint: 'last name',
                                  icon: Icons.person_outline,
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),

                            // DNI
                            Container(
                              decoration: _darkBoxDecoration(),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: TextFormField(
                                controller: _dniCtrl,
                                keyboardType: TextInputType.text,
                                style: _fieldTextStyle(),
                                validator: (v) =>
                                    (v == null || v.trim().isEmpty)
                                        ? 'Ingresa tu DNI'
                                        : null,
                                decoration: _darkInputDecoration(
                                  hint: 'DNI',
                                  icon: Icons.badge_outlined,
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),

                            // Age
                            Container(
                              decoration: _darkBoxDecoration(),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: TextFormField(
                                controller: _ageCtrl,
                                keyboardType: TextInputType.number,
                                style: _fieldTextStyle(),
                                validator: (v) {
                                  final t = v?.trim() ?? '';
                                  if (t.isEmpty) return 'Ingresa tu edad';
                                  final n = int.tryParse(t);
                                  if (n == null || n <= 0) {
                                    return 'Edad inválida';
                                  }
                                  if (n > 120) return 'Edad máxima 120';
                                  return null;
                                },
                                decoration: _darkInputDecoration(
                                  hint: 'age',
                                  icon: Icons.cake_outlined,
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),

                            // Gender (Dropdown)
                            Container(
                              decoration: _darkBoxDecoration(),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: DropdownButtonFormField<Gender>(
                                value: _gender,
                                isExpanded: true,
                                dropdownColor: const Color(0xFF3A3A3A),
                                iconEnabledColor: Colors.white70,
                                decoration: _darkInputDecoration(
                                  hint: 'gender',
                                  icon: Icons.wc_outlined,
                                ),
                                style: _fieldTextStyle(),
                                items: Gender.values
                                    .map((g) => DropdownMenuItem(
                                          value: g,
                                          child: Text(g.label),
                                        ))
                                    .toList(),
                                onChanged: (g) => setState(() {
                                  _gender = g ?? Gender.male;
                                }),
                              ),
                            ),
                            const SizedBox(height: 12),

                            // BloodGroup (Dropdown - ENUM)
                            Container(
                              decoration: _darkBoxDecoration(),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: DropdownButtonFormField<BloodGroup>(
                                value: _bloodGroup,
                                isExpanded: true,
                                dropdownColor: const Color(0xFF3A3A3A),
                                iconEnabledColor: Colors.white70,
                                decoration: _darkInputDecoration(
                                  hint: 'blood group',
                                  icon: Icons.bloodtype_outlined,
                                ),
                                style: _fieldTextStyle(),
                                items: BloodGroup.values
                                    .map((b) => DropdownMenuItem(
                                          value: b,
                                          child: Text(b.label),
                                        ))
                                    .toList(),
                                onChanged: (b) => setState(() {
                                  _bloodGroup = b ?? BloodGroup.oPositive;
                                }),
                              ),
                            ),
                            const SizedBox(height: 12),

                            // Nationality (Dropdown - ENUM)
                            Container(
                              decoration: _darkBoxDecoration(),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: DropdownButtonFormField<Nationality>(
                                value: _nationality,
                                isExpanded: true,
                                dropdownColor: const Color(0xFF3A3A3A),
                                iconEnabledColor: Colors.white70,
                                decoration: _darkInputDecoration(
                                  hint: 'nationality',
                                  icon: Icons.flag_outlined,
                                ),
                                style: _fieldTextStyle(),
                                items: Nationality.values
                                    .map((n) => DropdownMenuItem(
                                          value: n,
                                          child: Text(n.label),
                                        ))
                                    .toList(),
                                onChanged: (n) => setState(() {
                                  _nationality = n ?? Nationality.peruvian;
                                }),
                              ),
                            ),
                            const SizedBox(height: 12),

                            // Allergy (Dropdown - ENUM)
                            Container(
                              decoration: _darkBoxDecoration(),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: DropdownButtonFormField<Allergy>(
                                value: _allergy,
                                isExpanded: true,
                                dropdownColor: const Color(0xFF3A3A3A),
                                iconEnabledColor: Colors.white70,
                                decoration: _darkInputDecoration(
                                  hint: 'allergy',
                                  icon: Icons.medical_services_outlined,
                                ),
                                style: _fieldTextStyle(),
                                items: Allergy.values
                                    .map((a) => DropdownMenuItem(
                                          value: a,
                                          child: Text(a.label),
                                        ))
                                    .toList(),
                                onChanged: (a) => setState(() {
                                  _allergy = a ?? Allergy.none;
                                }),
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
                                            strokeWidth: 2),
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
                            const SizedBox(height: 12),
                          ],
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
