import 'package:cached_network_image/cached_network_image.dart';
import 'package:eventy/core/models/event/event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stacked/stacked.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_octicons/flutter_octicons.dart';

import 'event_details_viewmodel.dart';

class EventDetailsView extends StackedView<EventDetailsViewModel> {
  final Event event;

  const EventDetailsView({Key? key, required this.event}) : super(key: key);

  @override
  Widget builder(
      BuildContext context, EventDetailsViewModel viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: const Color(0xff22141a),
      extendBodyBehindAppBar: true,
      appBar: const EventDetailsAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            EventImageHeader(imageUrl: viewModel.eventImage),
            const SizedBox(height: 84),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AboutSection(description: event.description),
                  const SizedBox(height: 24),
                  const OrganizersSection(),
                  const SizedBox(height: 24),
                  LocationSection(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BuyTicketButton()
          .animate(onPlay: (controller) => controller.repeat())
          .shimmer(duration: 1500.ms)
          .then(delay: 1000.ms)
          .shake(duration: 300.ms, hz: 4),
    );
  }

  @override
  EventDetailsViewModel viewModelBuilder(BuildContext context) =>
      EventDetailsViewModel(event: event);
}

class EventDetailsAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const EventDetailsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.favorite_border, color: Colors.white),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class EventImageHeader extends ViewModelWidget<EventDetailsViewModel> {
  final String imageUrl;

  const EventImageHeader({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context, EventDetailsViewModel viewModel) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        Hero(
          tag: 'event_image_${viewModel.event.id}',
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height * 0.4,
            width: double.infinity,
            errorWidget: (context, url, error) => CachedNetworkImage(
              imageUrl: 'https://picsum.photos/800/400?grayscale',
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height * 0.4,
              width: double.infinity,
            ),
            errorListener: (context) {},
            placeholder: (context, url) => Shimmer(
              gradient: LinearGradient(
                colors: [Colors.grey[800]!, Colors.grey[700]!],
              ),
              child: Container(
                color: Colors.grey[800],
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.7),
                  Colors.transparent,
                  Colors.black.withOpacity(0.3),
                ],
                stops: const [0.0, 0.3, 1.0],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: -80,
          left: 16,
          right: 16,
          child: EventDetailsCard(event: viewModel.event),
        ),
      ],
    );
  }
}

class EventDetailsCard extends ViewModelWidget<EventDetailsViewModel> {
  final Event event;

  const EventDetailsCard({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context, EventDetailsViewModel viewModel) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xff22141a),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.withOpacity(0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
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
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.share, color: Colors.white),
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 16),
          EventInfoRow(
            icon: OctIcons.location_16,
            text: viewModel.eventLocation,
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: EventInfoRow(
                  icon: OctIcons.calendar_16,
                  text: viewModel.eventDate,
                ),
              ),
              SizedBox(width: 8),
              AvatarStack(),
            ],
          ),
        ],
      ),
    );
  }
}

class EventInfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const EventInfoRow({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.grey, size: 18),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            text,
            style: GoogleFonts.inter(
              color: Colors.grey,
              fontSize: 15,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class AboutSection extends StatefulWidget {
  final String description;

  const AboutSection({Key? key, required this.description}) : super(key: key);

  @override
  _AboutSectionState createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection>
    with SingleTickerProviderStateMixin {
  bool _expanded = false;
  late AnimationController _controller;
  late Animation<double> _heightFactor;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      lowerBound: 0.5,
    );
    _heightFactor = _controller.drive(CurveTween(curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleExpanded() {
    setState(() {
      _expanded = !_expanded;
      if (_expanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return ClipRect(
              child: Align(
                heightFactor: _heightFactor.value,
                alignment: Alignment.topCenter,
                child: child,
              ),
            );
          },
          child: HtmlWidget(
            widget.description,
            textStyle: GoogleFonts.inter(
              color: Colors.grey[400],
              fontSize: 16,
            ),
          ),
        ),
        TextButton(
          onPressed: _toggleExpanded,
          child: Text(
            _expanded ? 'See Less' : 'See More',
            style: GoogleFonts.inter(color: const Color(0xFFFF4E8D)),
          ),
        ),
      ],
    );
  }
}

class OrganizersSection extends ViewModelWidget<EventDetailsViewModel> {
  const OrganizersSection({super.key});

  @override
  Widget build(BuildContext context, EventDetailsViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Organizers and Attendees',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            const OrganizerAvatarStack(),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Organizers',
                    style: GoogleFonts.inter(
                      color: Colors.grey[400],
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    viewModel.eventOrganizer,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                OctIcons.comment_16,
                color: Color(0xFFFF4E8D),
                size: 24,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class LocationSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Location',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              Image.network(
                'https://picsum.photos/800/400?grayscale',
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
                    color: Colors.white,
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
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Positioned(
                top: 0,
                bottom: 0,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFF4E8D),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      OctIcons.location_16,
                      color: Colors.white,
                      size: 24,
                    ),
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

class BuyTicketButton extends ViewModelWidget<EventDetailsViewModel> {
  const BuyTicketButton({super.key});

  @override
  Widget build(BuildContext context, EventDetailsViewModel viewModel) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: viewModel.navigateToTicketSelection,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFF4E8D),
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            'Buy Ticket',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class AvatarStack extends StatelessWidget {
  const AvatarStack({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 110,
      height: 32,
      child: Stack(
        children: List.generate(5, (index) {
          if (index == 4) {
            return Positioned(
              right: 0,
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: const Color(0xFFFF4E8D),
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xff22141a), width: 2),
                ),
                child: Center(
                  child: Text(
                    '+40',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          }
          return Positioned(
            right: (4 - index) * 20.0,
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xff22141a), width: 2),
              ),
              child: ClipOval(
                child: Image.network(
                  'https://picsum.photos/seed/face$index/100/100',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        }),
      ),
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
                border: Border.all(color: const Color(0xff22141a), width: 2),
              ),
              child: ClipOval(
                child: Image.network(
                  'https://picsum.photos/seed/organizer/100/100',
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
                color: const Color(0xFFFF4E8D),
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xff22141a), width: 2),
              ),
              child: Center(
                child: Text(
                  '+15',
                  style: GoogleFonts.inter(
                    color: Colors.white,
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
