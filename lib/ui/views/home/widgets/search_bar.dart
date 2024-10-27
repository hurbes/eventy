import 'package:flutter/material.dart';
import 'package:flutter_octicons/flutter_octicons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eventy/ui/common/app_colors.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: ComponentColors.inputBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(OctIcons.search_16,
              color: ComponentColors.iconSecondary, size: 18),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Search',
              style: GoogleFonts.inter(
                color: ComponentColors.inputHintText,
                fontSize: 16,
              ),
            ),
          ),
          Icon(OctIcons.sliders_16,
              color: ComponentColors.iconSecondary, size: 18),
        ],
      ),
    );
  }
}
