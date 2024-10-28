import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:lottie/lottie.dart';
import 'package:eventy/ui/widgets/common/event_card/event_card.dart';
import 'package:eventy/ui/views/home/widgets/section_header.dart';
import '../home_viewmodel.dart';

class RecommendationsSection extends ViewModelWidget<HomeViewModel> {
  const RecommendationsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          if (index == 0) {
            return const Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: SectionHeader(title: 'Recommendations for you'),
            );
          }
          return _buildRecommendationItem(viewModel, index - 1);
        },
        childCount: viewModel.recommendedEvents.length +
            (viewModel.hasMoreRecommendations ? 2 : 1),
      ),
    );
  }

  Widget _buildRecommendationItem(HomeViewModel viewModel, int index) {
    if (index < viewModel.recommendedEvents.length) {
      final event = viewModel.recommendedEvents[index];
      return Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: EventCard(event: event),
      );
    } else if (viewModel.hasMoreRecommendations) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Center(
          child: Lottie.asset(
            'assets/animations/loader.json',
            height: 50,
            width: 50,
            fit: BoxFit.contain,
          ),
        ),
      );
    }
    return const SizedBox.shrink();
  }
}
