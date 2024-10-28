import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../details_form_viewmodel.dart';
import 'attendee_details_form.dart';
import 'payment_details_form.dart';
import 'personal_details_form.dart';

class StepContent extends ViewModelWidget<DetailsFormViewModel> {
  const StepContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, DetailsFormViewModel viewModel) {
    switch (viewModel.currentStep) {
      case 0:
        return const SliverToBoxAdapter(child: PersonalDetailsForm());
      case 1:
        return const AttendeeDetailsForm();
      case 2:
        return const SliverToBoxAdapter(child: PaymentDetailsForm());
      default:
        return const SliverToBoxAdapter(child: SizedBox.shrink());
    }
  }
}
