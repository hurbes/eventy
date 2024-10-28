import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:eventy/ui/common/shared/eventy_app_button.dart';
import 'package:stacked/stacked.dart';
import '../event_details_viewmodel.dart';

class BuyTicketButton extends ViewModelWidget<EventDetailsViewModel> {
  const BuyTicketButton({super.key});

  @override
  Widget build(BuildContext context, EventDetailsViewModel viewModel) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: EventyAppButton(
          text: 'Buy Ticket',
          width: double.infinity,
          onTap: viewModel.navigateToTicketSelection,
          isEnabled: viewModel.isBookable,
        ),
      ),
    )
        .animate(
          onPlay: (controller) => controller.repeat(),
          target: viewModel.isBookable ? 1 : 0,
        )
        .shimmer(duration: 1500.ms)
        .then(delay: 1000.ms)
        .shake(duration: 300.ms, hz: 4);
  }
}