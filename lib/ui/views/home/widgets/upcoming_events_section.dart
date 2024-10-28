import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:eventy/ui/common/ui_helpers.dart';
import 'package:eventy/ui/widgets/common/event_card/event_card.dart';
import '../home_viewmodel.dart';
import 'section_header.dart';

class UpcomingEventsSection extends ViewModelWidget<HomeViewModel> {
  const UpcomingEventsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return Column(
      children: [
        const SectionHeader(title: 'Upcoming Events'),
        verticalSpaceSmall,
        SizedBox(
          height: screenHeightPercentage(context, percentage: 0.25),
          child: GridView.builder(
            scrollDirection: Axis.horizontal,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: .3,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: viewModel.upcomingEvents.length,
            itemBuilder: (context, index) {
              final event = viewModel.upcomingEvents[index];
              return EventCard(event: event);
            },
          ),
        ),
      ],
    );
  }
}
