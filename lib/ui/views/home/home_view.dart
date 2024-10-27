import 'package:eventy/ui/common/app_colors.dart';
import 'package:eventy/ui/common/ui_helpers.dart';
import 'package:eventy/ui/views/home/widgets/section_header.dart';
import 'package:eventy/ui/widgets/common/event_card/event_card.dart';
import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';
import 'widgets/home_view_shimmer.dart';
import 'widgets/header_section.dart';
// ignore: library_prefixes
import 'widgets/search_bar.dart' as SearchBar;
import 'widgets/category_section.dart';
import 'widgets/upcoming_events_section.dart';
import 'widgets/popular_now_section.dart';
import 'widgets/bottom_nav_bar.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(BuildContext context, HomeViewModel viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: kcBackgroundColor,
      body: SafeArea(
        child: NotificationListener<ScrollNotification>(
          onNotification: (scrollInfo) =>
              _handleScrollNotification(scrollInfo, viewModel),
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    verticalSpaceSmall,
                    const HeaderSection(),
                    verticalSpaceSmall,
                    const SearchBar.SearchBar(),
                    verticalSpaceMedium,
                    const CategorySection(),
                    verticalSpaceMedium,
                    _buildUpcomingEventsSection(viewModel),
                    verticalSpaceMedium,
                    _buildPopularNowSection(viewModel),
                    verticalSpaceLarge,
                  ]),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                sliver: _buildRecommendationsSection(viewModel),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }

  bool _handleScrollNotification(
      ScrollNotification scrollInfo, HomeViewModel viewModel) {
    if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
      if (!viewModel.isBusy && viewModel.hasMoreRecommendations) {
        viewModel.loadMoreRecommendations();
      }
    }
    return true;
  }

  Widget _buildUpcomingEventsSection(HomeViewModel viewModel) {
    return viewModel.isBusy
        ? const ShimmerUpcomingEventsSection()
        : const UpcomingEventsSection();
  }

  Widget _buildPopularNowSection(HomeViewModel viewModel) {
    return viewModel.isBusy
        ? const ShimmerPopularNowSection()
        : const PopularNowSection();
  }

  Widget _buildRecommendationsSection(HomeViewModel viewModel) {
    return viewModel.isBusy
        ? const SliverToBoxAdapter(child: ShimmerRecommendationsSection())
        : SliverList(
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
                  (viewModel.hasMoreRecommendations ? 2 : 1), // +1 for header
            ),
          );
  }

  Widget _buildRecommendationItem(HomeViewModel viewModel, int index) {
    if (index < viewModel.recommendedEvents.length) {
      final event = viewModel.recommendedEvents[index];
      return Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: EventCard(event: event, isUpcoming: false),
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
    } else {
      return const SizedBox.shrink();
    }
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();
}
