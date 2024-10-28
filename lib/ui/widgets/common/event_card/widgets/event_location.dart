import 'package:eventy/ui/common/app_colors.dart';
import 'package:eventy/ui/common/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_octicons/flutter_octicons.dart';
import 'package:google_fonts/google_fonts.dart';

class EventLocation extends StatelessWidget {
  final String location;

  const EventLocation({
    Key? key,
    required this.location,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          OctIcons.location_16,
          size: 16,
          color: kcTextTertiaryColor,
        ),
        horizontalSpaceTiny,
        Flexible(
          child: Text(
            location,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.inter(
              color: kcTextTertiaryColor,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
