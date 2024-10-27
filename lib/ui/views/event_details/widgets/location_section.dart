import 'package:flutter/material.dart';
import 'package:flutter_octicons/flutter_octicons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eventy/ui/common/app_colors.dart';
import 'package:eventy/ui/common/ui_helpers.dart';
import 'package:eventy/ui/common/shared/eventy_network_image.dart';

class LocationSection extends StatelessWidget {
  const LocationSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Location',
          style: GoogleFonts.inter(
            color: kcTextPrimaryColor,
            fontSize: getResponsiveLargeFontSize(context),
            fontWeight: FontWeight.bold,
          ),
        ),
        verticalSpaceSmall,
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              EventyNetworkImage(
                imageUrl: 'https://picsum.photos/800/400?grayscale',
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 16,
                left: 16,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: kcTextPrimaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'See Location',
                    style: GoogleFonts.inter(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 16,
                right: 16,
                child: Text(
                  'TROUSDALE ESTATES',
                  style: GoogleFonts.inter(
                    color: kcTextPrimaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Center(
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: const BoxDecoration(
                    color: kcPrimaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    OctIcons.location_16,
                    color: ComponentColors.iconPrimary,
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
