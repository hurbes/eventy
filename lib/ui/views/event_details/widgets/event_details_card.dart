import 'package:eventy/ui/common/shared/avatar_stack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_octicons/flutter_octicons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eventy/ui/common/app_colors.dart';
import 'package:eventy/ui/common/ui_helpers.dart';
import 'package:eventy/ui/common/date_helpers.dart';
import 'package:eventy/core/models/event/event.dart';
import 'event_info_row.dart';

class EventDetailsCard extends StatelessWidget {
  final Event event;

  const EventDetailsCard({
    Key? key,
    required this.event,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: kcBackgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: ComponentColors.cardBorder,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: ShadowColors.defaultShadow,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  event.title,
                  style: GoogleFonts.inter(
                    color: kcTextPrimaryColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.share, color: ComponentColors.iconPrimary),
                onPressed: () {},
              ),
            ],
          ),
          verticalSpaceSmall,
          EventInfoRow(
            icon: OctIcons.location_16,
            text:
                event.settings.target?.locationDetails.target?.venueName ?? '',
          ),
          verticalSpaceTiny,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: EventInfoRow(
                  icon: OctIcons.calendar_16,
                  text: DateHelpers.formatEventDate(event.startDate),
                ),
              ),
              horizontalSpaceSmall,
              const AvatarStack(),
            ],
          ),
        ],
      ),
    );
  }
}
