import 'package:animations/animations.dart';
import 'package:eventy/core/models/event/event.dart';
import 'package:eventy/ui/views/event_details/event_details_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_octicons/flutter_octicons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';
import 'package:eventy/ui/common/app_colors.dart';
import 'package:eventy/ui/common/shared/eventy_network_image.dart';

import 'event_card_model.dart';

class EventCard extends StatelessWidget {
  final Event event;
  final bool isUpcoming;

  const EventCard({
    Key? key,
    required this.event,
    this.isUpcoming = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      transitionType: ContainerTransitionType.fadeThrough,
      openBuilder: (context, _) => EventDetailsView(event: event),
      closedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      closedElevation: 0,
      closedColor: Colors.transparent,
      openColor: Colors.white.withOpacity(0.05),
      middleColor: Colors.transparent,
      transitionDuration: const Duration(milliseconds: 300),
      closedBuilder: (context, openContainer) => EventCardBody(
        openContainer: openContainer,
        event: event,
      ),
    );
  }
}

class EventCardBody extends StackedView<EventCardModel> {
  const EventCardBody({
    super.key,
    required this.openContainer,
    required this.event,
  });

  final VoidCallback openContainer;
  final Event event;

  @override
  EventCardModel viewModelBuilder(BuildContext context) =>
      EventCardModel(event: event);

  @override
  Widget builder(
    BuildContext context,
    EventCardModel viewModel,
    Widget? child,
  ) {
    return GestureDetector(
      onTap: openContainer,
      child: Container(
        width: viewModel.isUpcoming ? 350 : double.infinity,
        height: viewModel.isUpcoming ? null : 100,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: ComponentColors.cardBackground,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Hero(
              tag: 'event_image_${viewModel.event.id}',
              child: EventyNetworkImage(
                imageUrl: viewModel.eventImage,
                width: viewModel.isUpcoming ? 80 : 84,
                height: viewModel.isUpcoming ? 80 : 84,
                borderRadius: BorderRadius.circular(12),
                shimmerBaseColor: ShimmerColors.baseColor,
                shimmerHighlightColor: ShimmerColors.highlightColor,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    viewModel.eventTitle,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(OctIcons.location_16,
                                size: 16, color: Colors.grey),
                            const SizedBox(width: 4),
                            Flexible(
                              child: Text(
                                viewModel.eventLocation,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.inter(
                                    color: Colors.grey, fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (viewModel.isUpcoming) ...[
                        const SizedBox(width: 8),
                        _buildJoinButton(),
                      ] else
                        _buildPriceTag(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildJoinButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFFF4E8D),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        'Join',
        style: GoogleFonts.inter(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildPriceTag() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFFF4E8D).withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        '100',
        style: GoogleFonts.inter(
          color: const Color(0xFFFF4E8D),
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}
