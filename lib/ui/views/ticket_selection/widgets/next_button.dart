import 'package:flutter/material.dart';
import 'package:eventy/ui/common/shared/eventy_app_button.dart';
import 'package:stacked/stacked.dart';
import '../ticket_selection_viewmodel.dart';

class NextButton extends ViewModelWidget<TicketSelectionViewModel> {
  const NextButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, TicketSelectionViewModel viewModel) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: EventyAppButton(
          text: 'Next',
          width: double.infinity,
          onTap: viewModel.navigateToDetailsForm,
          isEnabled: viewModel.hasSelectedTickets,
          trailingIcon: viewModel.hasSelectedTickets
              ? null
              : const Icon(Icons.lock, size: 16, color: Colors.white54),
        ),
      ),
    );
  }
}
