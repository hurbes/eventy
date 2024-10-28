import 'package:flutter/material.dart';
import 'package:flutter_octicons/flutter_octicons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eventy/ui/common/app_colors.dart';
import 'package:eventy/ui/common/ui_helpers.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Location',
              style: GoogleFonts.inter(
                color: kcTextPrimaryColor,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            verticalSpaceTiny,
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 6, right: 4),
                  child: Icon(
                    OctIcons.location_16,
                    color: kcPrimaryColor,
                    size: 20,
                  ),
                ),
                Text(
                  'Ahmedabad, Gujarat',
                  style: GoogleFonts.inter(
                    color: kcTextSecondaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ],
        ),
        const NotificationButton(),
      ],
    );
  }
}

class NotificationButton extends StatelessWidget {
  const NotificationButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
      decoration: BoxDecoration(
        color: ComponentColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child:
          Icon(OctIcons.bell_16, color: ComponentColors.iconPrimary, size: 20),
    );
  }
}
