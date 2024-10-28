import 'package:animations/animations.dart';
import 'package:eventy/core/models/event/event.dart';
import 'package:eventy/ui/views/event_details/event_details_view.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:eventy/ui/common/app_colors.dart';
import 'package:eventy/ui/common/shared/eventy_network_image.dart';
import 'package:eventy/ui/common/ui_helpers.dart';

import 'event_card_model.dart';
import 'widgets/event_status_badge.dart';
import 'widgets/event_location.dart';
import 'widgets/event_title.dart';

class EventCard extends StatelessWidget {
  final Event event;

  const EventCard({
    Key? key,
    required this.event,
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
      openColor: withOpacity(Colors.white, 0.05),
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
        width: double.infinity,
        height: 100,
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
                width: 84,
                height: 84,
                borderRadius: BorderRadius.circular(12),
                shimmerBaseColor: ShimmerColors.baseColor,
                shimmerHighlightColor: ShimmerColors.highlightColor,
              ),
            ),
            horizontalSpaceSmall,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  EventTitle(title: viewModel.eventTitle),
                  verticalSpaceTiny,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: EventLocation(location: viewModel.eventLocation),
                      ),
                      horizontalSpaceSmall,
                      EventStatusBadge(status: viewModel.event.status),
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
}
