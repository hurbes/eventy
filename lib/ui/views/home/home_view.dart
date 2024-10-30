import 'package:eventy/ui/common/app_colors.dart';
import 'package:eventy/ui/common/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';
import 'widgets/bottom_nav_bar.dart';
import 'widgets/category_section.dart';
import 'widgets/header_section.dart';
import 'widgets/home_sections.dart';
// ignore: library_prefixes
import 'widgets/search_bar.dart' as SearchBar;

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(BuildContext context, HomeViewModel viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: kcBackgroundColor,
      body: SafeArea(
        child: NotificationListener<ScrollNotification>(
          onNotification: (scrollInfo) {
            if (scrollInfo.metrics.pixels ==
                scrollInfo.metrics.maxScrollExtent) {
              if (!viewModel.isBusy && viewModel.hasMoreRecommendations) {
                viewModel.loadMoreRecommendations();
              }
            }
            return true;
          },
          child: const CustomScrollView(
            slivers: [
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    children: [
                      verticalSpaceSmall,
                      HeaderSection(),
                      verticalSpaceSmall,
                      SearchBar.SearchBar(),
                      verticalSpaceMedium,
                      CategorySection(),
                      verticalSpaceMedium,
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                sliver: HomeSections(),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();
}
