import 'package:eventy/ui/common/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EventStatusBadge extends StatelessWidget {
  final String status;

  const EventStatusBadge({
    Key? key,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _getStatusColor(),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        _getStatusText(),
        style: GoogleFonts.inter(
          color: kcTextPrimaryColor,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  Color _getStatusColor() {
    switch (status) {
      case 'LIVE':
        return kcSuccessColor.withOpacity(0.2);
      case 'ARCHIVED':
        return kcTextTertiaryColor.withOpacity(0.2);
      default:
        return ComponentColors.priceTagBackground;
    }
  }

  String _getStatusText() {
    switch (status) {
      case 'LIVE':
        return 'Live';
      case 'ARCHIVED':
        return 'Ended';
      default:
        return 'Upcoming';
    }
  }
}
