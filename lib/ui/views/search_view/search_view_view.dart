import 'package:eventy/ui/common/ui_helpers.dart';
import 'package:eventy/ui/views/search_view/search_view_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_octicons/flutter_octicons.dart';

class SearchView extends StackedView<SearchViewViewModel> {
  const SearchView({Key? key}) : super(key: key);

  @override
  Widget builder(
      BuildContext context, SearchViewViewModel viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: const Color(0xff22141a),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SearchBar(),
              verticalSpaceMedium,
              _buildCurrentLocationButton(),
              verticalSpaceMedium,
              Expanded(
                child: ListView.builder(
                  itemCount: 4,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: RecommendationCard(
                      title: 'Event Name ${index + 1}',
                      location: 'Location ${index + 1}',
                      imageUrl:
                          'https://picsum.photos/seed/event$index/200/300',
                      price: index % 2 == 0 ? '\$30.00' : 'Free',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCurrentLocationButton() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFFF4E8D).withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(OctIcons.location_16, color: Color(0xFFFF4E8D), size: 20),
          horizontalSpaceSmall,
          Text(
            'My Current Location',
            style: GoogleFonts.inter(
              color: const Color(0xFFFF4E8D),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  @override
  SearchViewViewModel viewModelBuilder(BuildContext context) =>
      SearchViewViewModel();
}

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(OctIcons.search_16, color: Colors.grey, size: 18),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Search',
              style: GoogleFonts.inter(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
          ),
          const Icon(OctIcons.sliders_16, color: Colors.grey, size: 18),
        ],
      ),
    );
  }
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
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white.withOpacity(0.05),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                imageUrl,
                width: 84,
                height: 84,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
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
          ),
        ],
      ),
    );
  }
}
