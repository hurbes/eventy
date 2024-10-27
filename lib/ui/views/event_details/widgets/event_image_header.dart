import 'package:flutter/material.dart';
import 'package:eventy/ui/common/app_colors.dart';
import 'package:eventy/ui/common/shared/eventy_network_image.dart';
import 'package:eventy/core/models/event/event.dart';
import 'event_details_card.dart';

class EventImageHeader extends StatelessWidget {
  final Event event;
  final String imageUrl;

  const EventImageHeader({
    Key? key,
    required this.event,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        Hero(
          tag: 'event_image_${event.id}',
          child: EventyNetworkImage(
            imageUrl: imageUrl,
            height: MediaQuery.of(context).size.height * 0.4,
            width: double.infinity,
            borderRadius: BorderRadius.zero,
          ),
        ),
        const Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: GradientColors.imageOverlayGradient,
                stops: GradientColors.imageOverlayStops,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: -80,
          left: 16,
          right: 16,
          child: EventDetailsCard(event: event),
        ),
      ],
    );
  }
}
