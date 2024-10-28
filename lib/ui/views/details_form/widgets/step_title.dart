import 'package:eventy/ui/common/app_colors.dart';
import 'package:eventy/ui/common/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';

import '../details_form_viewmodel.dart';

class StepTitle extends ViewModelWidget<DetailsFormViewModel> {
  const StepTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, DetailsFormViewModel viewModel) {
    final (title, subtitle) = _getStepContent(viewModel.currentStep);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.creepster(
            color: kcPrimaryColor,
            fontSize: getResponsiveFontSize(context, fontSize: 65),
            fontWeight: FontWeight.bold,
            shadows: [
              const Shadow(
                blurRadius: 10.0,
                color: ShadowColors.defaultShadow,
                offset: Offset(5, 5),
              ),
            ],
          ),
        ),
        verticalSpaceSmall,
        Text(
          subtitle,
          style: GoogleFonts.inter(
            color: kcTextSecondaryColor,
            fontSize: getResponsiveFontSize(context, fontSize: 35),
            fontStyle: FontStyle.italic,
            letterSpacing: 0.5,
          ),
        ),
        verticalSpaceMedium,
      ],
    );
  }

  (String, String) _getStepContent(int step) {
    switch (step) {
      case 0:
        return ('Who\'s Booking?', 'Let\'s start with your details');
      case 1:
        return ('Who\'s Coming?', 'Tell us about your fellow party-goers');
      case 2:
        return (
          'Secure Your Spot!',
          'Just a few more details to confirm your booking'
        );
      default:
        return ('Oops!', 'Something went wrong');
    }
  }
}
