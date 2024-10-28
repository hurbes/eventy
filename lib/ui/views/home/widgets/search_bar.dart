import 'package:flutter/material.dart';
import 'package:flutter_octicons/flutter_octicons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eventy/ui/common/app_colors.dart';
import 'package:animations/animations.dart';
import 'package:eventy/ui/views/search_view/search_view_view.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      transitionType: ContainerTransitionType.fadeThrough,
      openBuilder: (context, _) => const SearchView(),
      closedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      closedElevation: 0,
      closedColor: ComponentColors.inputBackground,
      openColor: withOpacity(Colors.white, 0.05),
      middleColor: Colors.transparent,
      transitionDuration: const Duration(milliseconds: 300),
      closedBuilder: (context, openContainer) => InkWell(
        onTap: openContainer,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                OctIcons.search_16,
                color: ComponentColors.iconSecondary,
                size: 18,
              ),
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
              const Icon(
                OctIcons.sliders_16,
                color: ComponentColors.iconSecondary,
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
