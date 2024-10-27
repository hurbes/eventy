import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'event_details_viewmodel.dart';

class EventDetailsView extends StackedView<EventDetailsViewModel> {
  const EventDetailsView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    EventDetailsViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
      ),
    );
  }

  @override
  EventDetailsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      EventDetailsViewModel();
}
