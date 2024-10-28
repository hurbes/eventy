import 'package:eventy/ui/common/app_colors.dart';
import 'package:eventy/ui/common/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';
import '../details_form_viewmodel.dart';
import 'validated_input_field.dart';

class PersonalDetailsForm extends ViewModelWidget<DetailsFormViewModel> {
  const PersonalDetailsForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, DetailsFormViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ValidatedInputField(
          label: 'First Name',
          hint: 'First name',
          validator: validateName,
          maxLength: 50,
          initialValue: viewModel.personalDetails.firstName,
          onChanged: (value) =>
              viewModel.updatePersonalDetails(firstName: value),
        ),
        verticalSpaceMedium,
        ValidatedInputField(
          label: 'Last Name',
          hint: 'Last Name',
          validator: validateName,
          maxLength: 50,
          initialValue: viewModel.personalDetails.lastName,
          onChanged: (value) =>
              viewModel.updatePersonalDetails(lastName: value),
        ),
        verticalSpaceMedium,
        ValidatedInputField(
          label: 'Email Address',
          hint: 'Email Address',
          validator: validateEmail,
          keyboardType: TextInputType.emailAddress,
          initialValue: viewModel.personalDetails.email,
          onChanged: (value) => viewModel.updatePersonalDetails(email: value),
        ),
        verticalSpaceMedium,
        const CopyDetailsCheckbox(),
      ],
    );
  }
}

class CopyDetailsCheckbox extends ViewModelWidget<DetailsFormViewModel> {
  const CopyDetailsCheckbox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, DetailsFormViewModel viewModel) {
    return Row(
      children: [
        Checkbox(
          value: viewModel.copyDetails,
          onChanged: (value) => viewModel.setCopyDetails(value ?? false),
          fillColor:
              WidgetStateProperty.resolveWith((states) => kcPrimaryColor),
        ),
        Text(
          'Copy details to all attendees',
          style: GoogleFonts.inter(
            color: kcTextPrimaryColor,
            fontSize: getResponsiveFontSize(context, fontSize: 27),
          ),
        ),
      ],
    );
  }
}
