import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eventy/ui/common/app_colors.dart';
import 'package:eventy/ui/common/ui_helpers.dart';

class TicketSelectionHeader extends StatelessWidget {
  const TicketSelectionHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            'Select Your Tickets',
            style: GoogleFonts.inter(
              fontSize: getResponsiveFontSize(context, fontSize: 40),
              fontWeight: FontWeight.bold,
              color: kcTextPrimaryColor,
            ),
          ),
          verticalSpaceSmall,
          Text(
            'Choose from our available ticket options',
            style: GoogleFonts.inter(
              fontSize: getResponsiveFontSize(context, fontSize: 35),
              color: kcTextSecondaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
