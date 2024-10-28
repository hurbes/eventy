import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eventy/ui/common/app_colors.dart';
import 'package:eventy/ui/common/ui_helpers.dart';
import 'package:eventy/ui/common/shared/eventy_network_image.dart';
import 'package:eventy/ui/common/date_helpers.dart';
import 'package:eventy/core/models/event/event.dart';
import 'timer_widget.dart';

class TopCard extends StatelessWidget {
  final Event event;
  final String eventImage;

  const TopCard({
    Key? key,
    required this.event,
    required this.eventImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          EventyNetworkImage(
            imageUrl: eventImage,
            width: double.infinity,
            height: 200,
            borderRadius: BorderRadius.circular(16),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: GradientColors.imageOverlayGradient,
                  stops: GradientColors.imageOverlayStops,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.title,
                  style: GoogleFonts.inter(
                    color: kcTextPrimaryColor,
                    fontSize: getResponsiveFontSize(context, fontSize: 30),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                verticalSpaceSmall,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      DateHelpers.formatEventDate(event.startDate),
                      style: GoogleFonts.inter(
                        color: kcTextPrimaryColor,
                        fontSize: getResponsiveFontSize(context, fontSize: 30),
                      ),
                    ),
                    const TimerWidget(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
