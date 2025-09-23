import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tukuntech/core/base_screen.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      currentIndex: 3,
      title: "Patient",
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "User Data",
              style: GoogleFonts.josefinSans(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: const Color(0xFFF0E8D5),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 12),
              height: 2,
              width: 120,
              color: const Color(0xFFD1AA10),
            ),
            const SizedBox(height: 10),
            _buildUserRow("Name", "Pedro Angulo"),
            _divider(),
            _buildUserRow("Last Name", "Diaz Pedrez"),
            _divider(),
            _buildUserRow("DNI", "71233333"),
            _divider(),
            _buildUserRow("Age", "46"),
            _divider(),
            _buildUserRow("Gender", "Male"),
            _divider(),
            _buildUserRow("Blood Group", "O+"),
            _divider(),
            _buildUserRow("Nationality", "Brazilian"),
            _divider(),
            _buildUserRow("Allergies", "Mentirosas"),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EditProfilePage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF0E8D5),
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 18,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  "Update",
                  style: GoogleFonts.josefinSans(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$label:",
            style: GoogleFonts.darkerGrotesque(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: const Color(0xFFF0E8D5),
            ),
          ),
          Text(
            value,
            style: GoogleFonts.darkerGrotesque(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: const Color(0xFFF0E8D5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() {
    return const Divider(
      color: Color(0xFF555555),
      thickness: 1,
      height: 16,
    );
  }
}

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _nameController = TextEditingController(text: "Pedro Angulo");
  final _lastNameController = TextEditingController(text: "Diaz Pedrez");
  final _dniController = TextEditingController(text: "71233333");
  final _ageController = TextEditingController(text: "46");
  final _genderController = TextEditingController(text: "Male");
  final _bloodGroupController = TextEditingController(text: "O+");
  final _nationalityController = TextEditingController(text: "Brazilian");
  final _allergiesController = TextEditingController(text: "Mentirosas");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1B1B1B),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1B1B1B),
        elevation: 0,
        title: Text(
          "Edit Profile",
          style: GoogleFonts.darkerGrotesque(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: const Color(0xFFF0E8D5),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            _buildTextField("Name", _nameController),
            _buildTextField("Last Name", _lastNameController),
            _buildTextField("DNI", _dniController),
            _buildTextField("Age", _ageController,
                keyboardType: TextInputType.number),
            _buildTextField("Gender", _genderController),
            _buildTextField("Blood Group", _bloodGroupController),
            _buildTextField("Nationality", _nationalityController),
            _buildTextField("Allergies", _allergiesController),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF0E8D5),
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 18,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                "Save",
                style: GoogleFonts.josefinSans(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        style: GoogleFonts.darkerGrotesque(
          fontSize: 20,
          color: const Color(0xFFF0E8D5),
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: GoogleFonts.josefinSans(
            fontSize: 18,
            color: const Color(0xFFF0E8D5),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFF0E8D5)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFD1AA10)),
          ),
        ),
      ),
    );
  }
}
