import 'package:flutter/material.dart';
import 'package:flutter_octicons/flutter_octicons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eventy/ui/common/app_colors.dart';
import 'package:eventy/ui/common/ui_helpers.dart';
import 'package:eventy/ui/common/shared/eventy_network_image.dart';

class OrganizersSection extends StatelessWidget {
  final String organizerName;

  const OrganizersSection({
    Key? key,
    required this.organizerName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Organizers and Attendees',
          style: GoogleFonts.inter(
            color: kcTextPrimaryColor,
            fontSize: getResponsiveFontSize(context, fontSize: 40),
            fontWeight: FontWeight.bold,
          ),
        ),
        verticalSpaceSmall,
        Row(
          children: [
            const OrganizerAvatarStack(),
            horizontalSpaceSmall,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Organizers',
                    style: GoogleFonts.inter(
                      color: kcTextSecondaryColor,
                      fontSize: getResponsiveFontSize(context, fontSize: 35),
                    ),
                  ),
                  verticalSpaceTiny,
                  Text(
                    organizerName,
                    style: GoogleFonts.inter(
                      color: kcTextPrimaryColor,
                      fontSize: getResponsiveFontSize(context, fontSize: 36),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: ComponentColors.cardBackground,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                OctIcons.comment_16,
                color: kcPrimaryColor,
                size: 24,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class OrganizerAvatarStack extends StatelessWidget {
  const OrganizerAvatarStack({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      height: 48,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: kcBackgroundColor, width: 2),
              ),
              child: ClipOval(
                child: EventyNetworkImage(
                  imageUrl: 'https://picsum.photos/seed/organizer/100/100',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: kcPrimaryColor,
                shape: BoxShape.circle,
                border: Border.all(color: kcBackgroundColor, width: 2),
              ),
              child: Center(
                child: Text(
                  '+15',
                  style: GoogleFonts.inter(
                    color: kcTextPrimaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
