import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_octicons/flutter_octicons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';
import 'package:eventy/ui/common/app_colors.dart';
import 'package:eventy/ui/common/ui_helpers.dart';
import '../home_viewmodel.dart';
import 'section_header.dart';
import 'avatar_stack.dart';

class PopularNowSection extends ViewModelWidget<HomeViewModel> {
  const PopularNowSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    final popularEvent = viewModel.popularEvent;
    if (popularEvent == null) return const SizedBox.shrink();

    return Column(
      children: [
        const SectionHeader(title: 'Popular Now'),
        verticalSpaceSmall,
        Container(
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: CachedNetworkImage(
                  imageUrl: 'https://picsum.photos/200/300',
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: ShimmerColors.baseColor,
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: GradientColors.imageOverlayGradient,
                      stops: GradientColors.imageOverlayStops,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 16,
                left: 16,
                child: CategoryChip(label: 'Music'),
              ),
              const Positioned(
                right: 16,
                top: 16,
                child: FavoriteButton(),
              ),
              Positioned(
                bottom: 16,
                left: 16,
                right: 16,
                child: PopularEventDetails(event: popularEvent),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CategoryChip extends StatelessWidget {
  final String label;

  const CategoryChip({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: kcTextPrimaryColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(fontWeight: FontWeight.bold),
      ),
    );
  }
}

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: kcOverlayDark,
        shape: BoxShape.circle,
      ),
      child: Icon(
        OctIcons.heart_16,
        color: ComponentColors.iconPrimary,
        size: 16,
      ),
    );
  }
}

class PopularEventDetails extends StatelessWidget {
  final dynamic event;

  const PopularEventDetails({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          event.title,
          style: GoogleFonts.inter(
            color: kcTextPrimaryColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        verticalSpaceTiny,
        Text(
          event.startDate.toIso8601String(),
          style: GoogleFonts.inter(
            color: kcTextPrimaryColor,
            fontSize: 12,
          ),
        ),
        verticalSpaceTiny,
        Row(
          children: [
            const AvatarStack(),
            horizontalSpaceSmall,
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: kcPrimaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '+40',
                style: GoogleFonts.inter(
                  color: kcTextPrimaryColor,
                  fontSize: 12,
                ),
              ),
            ),
            const Spacer(),
            Text(
              '\$${event.currency}',
              style: GoogleFonts.inter(
                color: kcPrimaryColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
