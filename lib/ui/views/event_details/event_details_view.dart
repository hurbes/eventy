import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:eventy/ui/common/app_colors.dart';
import 'package:eventy/ui/common/ui_helpers.dart';
import 'package:eventy/core/models/event/event.dart';

import 'event_details_viewmodel.dart';
import 'widgets/event_details_app_bar.dart';
import 'widgets/event_image_header.dart';
import 'widgets/about_section.dart';
import 'widgets/organizers_section.dart';
import 'widgets/location_section.dart';
import 'widgets/buy_ticket_button.dart';

class EventDetailsView extends StackedView<EventDetailsViewModel> {
  final Event event;

  const EventDetailsView({Key? key, required this.event}) : super(key: key);

  @override
  Widget builder(
      BuildContext context, EventDetailsViewModel viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: kcBackgroundColor,
      extendBodyBehindAppBar: true,
      appBar: const EventDetailsAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            EventImageHeader(imageUrl: viewModel.eventImage, event: event),
            verticalSpaceLarge,
            verticalSpaceMedium,
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AboutSection(description: event.description),
                  verticalSpaceMedium,
                  OrganizersSection(organizerName: viewModel.eventOrganizer),
                  verticalSpaceMedium,
                  const LocationSection(),
                  verticalSpaceLarge,
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BuyTicketButton(),
    );
  }

  @override
  EventDetailsViewModel viewModelBuilder(BuildContext context) =>
      EventDetailsViewModel(event: event);
}
