import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eventy/ui/common/app_colors.dart';
import 'package:eventy/ui/common/ui_helpers.dart';

class AboutSection extends StatefulWidget {
  final String description;

  const AboutSection({Key? key, required this.description}) : super(key: key);

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection>
    with SingleTickerProviderStateMixin {
  bool _expanded = false;
  late AnimationController _controller;
  late Animation<double> _heightFactor;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      lowerBound: 0.5,
    );
    _heightFactor = _controller.drive(CurveTween(curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleExpanded() {
    setState(() {
      _expanded = !_expanded;
      if (_expanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About',
          style: GoogleFonts.inter(
            color: kcTextPrimaryColor,
            fontSize: getResponsiveFontSize(context, fontSize: 50),
            fontWeight: FontWeight.bold,
          ),
        ),
        verticalSpaceSmall,
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return ClipRect(
              child: Align(
                heightFactor: _heightFactor.value,
                alignment: Alignment.topCenter,
                child: child,
              ),
            );
          },
          child: HtmlWidget(
            widget.description,
            textStyle: GoogleFonts.inter(
              color: kcTextSecondaryColor,
              fontSize: getResponsiveFontSize(context, fontSize: 36),
            ),
          ),
        ),
        TextButton(
          onPressed: _toggleExpanded,
          child: Text(
            _expanded ? 'See Less' : 'See More',
            style: GoogleFonts.inter(color: kcPrimaryColor),
          ),
        ),
      ],
    );
  }
}
