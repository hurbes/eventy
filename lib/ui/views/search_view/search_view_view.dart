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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SearchBar(),
            verticalSpaceMedium,
            _buildCurrentLocationButton(),
            verticalSpaceMedium,
          ],
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
