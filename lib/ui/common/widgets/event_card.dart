import 'package:eventy/core/models/event/event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_octicons/flutter_octicons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:animations/animations.dart';
import 'package:eventy/ui/views/event_details/event_details_view.dart';

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
      closedBuilder: (context, openContainer) => _buildEventCard(openContainer),
    );
  }

  Widget _buildEventCard(VoidCallback openContainer) {
    return GestureDetector(
      onTap: openContainer,
      child: Container(
        width: isUpcoming ? 350 : double.infinity,
        height: isUpcoming ? null : 100,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Hero(
              tag: 'event_image_${event.id}',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  imageUrl:
                      'https://picsum.photos/200/300', // Replace with actual image URL
                  width: isUpcoming ? 80 : 84,
                  height: isUpcoming ? 80 : 84,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: Colors.grey[800]!,
                    highlightColor: Colors.grey[700]!,
                    child: Container(
                      width: isUpcoming ? 80 : 84,
                      height: isUpcoming ? 80 : 84,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    event.title,
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
                                event.settings.target?.locationDetails.target
                                        ?.venueName ??
                                    '',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.inter(
                                    color: Colors.grey, fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (isUpcoming) ...[
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
        '\$${event.currency}',
        style: GoogleFonts.inter(
          color: const Color(0xFFFF4E8D),
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}
