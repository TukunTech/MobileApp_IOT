import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tukuntech/core/base_screen.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    final questions = [
      {
        "title": "What vital signs does TukunTech measure?",
        "content":
            "It currently measures heart rate, oxygen saturation (SpO₂), and body temperature. These parameters are key to the prevention and early detection of cardiovascular and respiratory problems."
      },
      {
        "title": "Is it necessary to have an internet connection to use the system?",
        "content":
            "Yes, TukunTech relies on internet connectivity to send device data to the cloud so it can be viewed in real time on the web or mobile app."
      },
      {
        "title": "Who can access patient information?",
        "content":
            "In the Individual Plan, only the primary user can access the patient’s data.\nIn the Family Plan, up to three family members or caregivers can simultaneously access the patient’s data from the app."
      },
      {
        "title": "What do I do if I receive a red alert?",
        "content":
            "You must follow the protocol prescribed by your primary care physician and, if an emergency is confirmed, immediately contact health services. The system simulates this process with a red LED and critical notifications to train and prepare the user."
      },
    ];

    return BaseScreen(
      currentIndex: 4,
      title: "Support",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          Container(
            margin: const EdgeInsets.only(left: 16, top: 8,bottom: 16),
            height: 3,
            width: 200,
            color: const Color(0xFFF0E8D5),
          ),
          const SizedBox(height: 20),

         
          Text(
            "FREQUENTLY QUESTIONS",
            style: GoogleFonts.josefinSans(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: const Color(0xFFF0E8D5),
              letterSpacing: 1,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 20),

          
          Expanded(
            child: PageView.builder(
              itemCount: questions.length,
              controller: PageController(viewportFraction: 0.9),
              itemBuilder: (context, index) {
                final q = questions[index];
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2B2B2B),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        q["title"]!,
                        style: GoogleFonts.darkerGrotesque(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFFF0E8D5),
                        ),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        q["content"]!,
                        style: GoogleFonts.darkerGrotesque(
                          fontSize: 18,
                          height: 1.6,
                          color: const Color(0xFFF0E8D5),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
