import 'package:eventy/ui/common/app_colors.dart';
import 'package:eventy/ui/common/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:stacked/stacked.dart';

import 'details_form_viewmodel.dart';
import 'widgets/animated_progress_bar.dart';
import 'widgets/details_form_app_bar.dart';
import 'widgets/persistent_bottom_sheet.dart';
import 'widgets/step_content.dart';
import 'widgets/step_title.dart';

class DetailsFormView extends StackedView<DetailsFormViewModel> {
  const DetailsFormView({Key? key}) : super(key: key);

  @override
  Widget builder(
      BuildContext context, DetailsFormViewModel viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: kcBackgroundColor,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              const DetailsFormAppBar(),
              SliverPersistentHeader(
                pinned: true,
                delegate: _SliverAppBarDelegate(
                  minHeight: 80,
                  maxHeight: 80,
                  child:
                      AnimatedProgressBar(currentStep: viewModel.currentStep),
                ),
              ),
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: StepTitle(),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverAnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: StepContent(key: ValueKey(viewModel.currentStep)),
                ),
              ),
              SliverToBoxAdapter(
                child: verticalSpace(
                    screenHeightPercentage(context, percentage: 0.15)),
              ),
            ],
          ),
          const PersistentBottomSheet().animate().shimmer(
                duration: 1000.ms,
                color: Colors.white.withOpacity(0.1),
              ),
        ],
      ),
    );
  }

  @override
  DetailsFormViewModel viewModelBuilder(BuildContext context) =>
      DetailsFormViewModel();
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  const _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
