import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_octicons/flutter_octicons.dart';
import 'map_navigation_viewmodel.dart';

class MapNavigationView extends StackedView<MapNavigationViewModel> {
  const MapNavigationView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    MapNavigationViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: Stack(
        children: [
          // Map placeholder
          Image.network(
            'https://picsum.photos/seed/map/1080/1920',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          // Top gradient for app bar visibility
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.7),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          // App Bar
          Positioned(
            top: 40,
            left: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(OctIcons.arrow_left_24, color: Colors.white),
                  onPressed: () {
                    // Handle back navigation
                  },
                ),
                Text(
                  'Map Direction',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 48), // Placeholder for symmetry
              ],
            ),
          ),
          // User location indicator
          const Positioned(
            bottom: 200,
            right: 20,
            child: CircleAvatar(
              radius: 24,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 22,
                backgroundImage:
                    NetworkImage('https://picsum.photos/seed/user/100/100'),
              ),
            ),
          ),
          // Destination indicator
          Positioned(
            top: 200,
            right: 100,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFFF4E8D),
                shape: BoxShape.circle,
              ),
              child: const Icon(OctIcons.location_24,
                  color: Colors.white, size: 24),
            ),
          ),
          // Route line
          CustomPaint(
            painter: RoutePainter(),
            size: Size.infinite,
          ),
          // Floating bottom card
          Positioned(
            bottom: 32,
            left: 16,
            right: 16,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xff22141a),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: const RecommendationCard(
                title: 'Dance party top town',
                location: 'Party • 1km away',
                imageUrl: 'https://picsum.photos/seed/event/200/200',
                price: '\$56.00',
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  MapNavigationViewModel viewModelBuilder(BuildContext context) =>
      MapNavigationViewModel();
}

class RoutePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFFF4E8D)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..moveTo(size.width * 0.8, size.height * 0.8)
      ..quadraticBezierTo(
        size.width * 0.6,
        size.height * 0.6,
        size.width * 0.4,
        size.height * 0.3,
      );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class RecommendationCard extends StatelessWidget {
  final String title;
  final String location;
  final String imageUrl;
  final String price;

  const RecommendationCard({
    Key? key,
    required this.title,
    required this.location,
    required this.imageUrl,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              imageUrl,
              width: 76,
              height: 76,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const Spacer(),
                Row(
                  children: [
                    const Icon(OctIcons.location_16,
                        size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      location,
                      style:
                          GoogleFonts.inter(color: Colors.grey, fontSize: 14),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF4E8D).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        price,
                        style: GoogleFonts.inter(
                          color: const Color(0xFFFF4E8D),
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
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
