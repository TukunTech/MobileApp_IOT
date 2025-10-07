import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tukuntech/core/base_screen.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});


  static const _bg = Color(0xFF1B1B1B);
  static const _panel = Color(0xFF242424);
  static const _text = Color(0xFFF0E8D5);
  static const _divider = Color(0xFFF0E8D5);
  static const _cardBeige = Color(0xFFEFE3CC);

  @override
  Widget build(BuildContext context) {
    final days = const [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
    ];

    return BaseScreen(
      currentIndex: 2,                  
      title: "Alert History",
      child: Container(
        color: _bg,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle("Reports & Trends"),

            const SizedBox(height: 22),

            Container(
              decoration: BoxDecoration(
                color: _panel,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.fromLTRB(12, 16, 12, 4),
              child: Column(
                children: [
                  for (final d in days) ...[
                    _DayAccordion(
                      label: d,
                      headerColor: _cardBeige,
                      contentBg: const Color(0xFF1B1B1B),
                      titleStyle: GoogleFonts.darkerGrotesque(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF1C1C1C),
                      ),
                      bodyTitleStyle: GoogleFonts.darkerGrotesque(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: _text,
                      ),
                      bodyTextStyle: GoogleFonts.darkerGrotesque(
                        fontSize: 12,
                        color: const Color(0xFFB2A895),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.josefinSans(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: _text,
          ),
        ),
        const Divider(thickness: 1, color: _divider),
      ],
    );
  }
}

class _DayAccordion extends StatefulWidget {
  final String label;
  final Color headerColor;
  final Color contentBg;
  final TextStyle titleStyle;
  final TextStyle bodyTitleStyle;
  final TextStyle bodyTextStyle;

  const _DayAccordion({
    required this.label,
    required this.headerColor,
    required this.contentBg,
    required this.titleStyle,
    required this.bodyTitleStyle,
    required this.bodyTextStyle,
  });

  @override
  State<_DayAccordion> createState() => _DayAccordionState();
}

class _DayAccordionState extends State<_DayAccordion>
    with SingleTickerProviderStateMixin {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final header = Container(
      decoration: BoxDecoration(
        color: widget.headerColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, .18),
            blurRadius: 14,
            offset: Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        children: [
          const Icon(Icons.calendar_month_rounded,
              size: 20, color: Color(0xFF333333)),
          const SizedBox(width: 10),
          Expanded(
            child: Text(widget.label, style: widget.titleStyle),
          ),
          AnimatedRotation(
            duration: const Duration(milliseconds: 180),
            turns: _expanded ? 0.5 : 0.0,
            child:
                const Icon(Icons.expand_more, size: 22, color: Color(0xFF1C1C1C)),
          ),
        ],
      ),
    );

    
    final content = Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 6),
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
      decoration: BoxDecoration(
        color: widget.contentBg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.notifications_none,
              color: Color(0xFFF1EADC), size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('No alerts', style: widget.bodyTitleStyle),
                const SizedBox(height: 4),
                Text(
                  'There are no alerts recorded for ${widget.label.toLowerCase()}.',
                  style: widget.bodyTextStyle,
                ),
              ],
            ),
          ),
        ],
      ),
    );

    return AnimatedSize(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeInOut,
      child: GestureDetector(
        onTap: () => setState(() => _expanded = !_expanded),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            header,
            if (_expanded) content,
          ],
        ),
      ),
    );
  }
}
