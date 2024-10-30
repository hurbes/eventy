import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:lottie/lottie.dart';

import '../home_viewmodel.dart';
import 'upcoming_events_section.dart';
import 'popular_now_section.dart';
import 'home_view_shimmer.dart';
import 'section_header.dart';
import '../../../widgets/common/event_card/event_card.dart';
import '../../../common/ui_helpers.dart';

class HomeSections extends ViewModelWidget<HomeViewModel> {
  const HomeSections({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    if (viewModel.isBusy) {
      return const SliverToBoxAdapter(
        child: Column(
          children: [
            ShimmerUpcomingEventsSection(),
            verticalSpaceMedium,
            ShimmerPopularNowSection(),
            verticalSpaceMedium,
            ShimmerRecommendationsSection(),
          ],
        ),
      );
    }

    return SliverAnimatedList(
      initialItemCount:
          viewModel.recommendedEvents.length + 3, // +3 for sections
      itemBuilder: (context, index, animation) {
        return FadeTransition(
          opacity: animation,
          child: _buildSectionItem(index, viewModel),
        );
      },
    );
  }

  Widget _buildSectionItem(int index, HomeViewModel viewModel) {
    if (index == 0) {
      return const UpcomingEventsSection();
    } else if (index == 1) {
      return const Padding(
        padding: EdgeInsets.only(top: 16),
        child: Column(
          children: [
            verticalSpaceMedium,
            PopularNowSection(),
          ],
        ),
      );
    } else if (index == 2) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: SectionHeader(title: 'Recommendations for you'),
      );
    } else {
      final eventIndex = index - 3;
      if (eventIndex < viewModel.recommendedEvents.length) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: EventCard(event: viewModel.recommendedEvents[eventIndex]),
        );
      } else if (viewModel.hasMoreRecommendations) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Lottie.asset(
            'assets/animations/loader.json',
            height: 50,
            width: 50,
            fit: BoxFit.contain,
          ),
        );
      }
      return const SizedBox.shrink();
    }
  }
}
