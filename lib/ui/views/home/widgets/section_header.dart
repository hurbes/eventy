import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eventy/ui/common/app_colors.dart';

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: kcTextPrimaryColor,
          ),
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            'See All',
            style: GoogleFonts.inter(color: kcPrimaryColor),
          ),
        ),
      ],
    );
  }
}
