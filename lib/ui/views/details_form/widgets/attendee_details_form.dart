import 'package:eventy/ui/common/app_colors.dart';
import 'package:eventy/ui/common/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';
import '../details_form_viewmodel.dart';
import 'validated_input_field.dart';

class AttendeeDetailsForm extends ViewModelWidget<DetailsFormViewModel> {
  const AttendeeDetailsForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, DetailsFormViewModel viewModel) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          if (index == 0) {
            return const AttendeeDetailsHeader();
          }
          index -= 1;
          if (index < viewModel.totalAttendees) {
            return AttendeeForm(index: index);
          }
          return null;
        },
        childCount: viewModel.totalAttendees + 1,
      ),
    );
  }
}

class AttendeeDetailsHeader extends StatelessWidget {
  const AttendeeDetailsHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Text(
        'Attendee Details',
        style: GoogleFonts.inter(
          color: kcTextPrimaryColor,
          fontSize: getResponsiveFontSize(context, fontSize: 30),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class AttendeeForm extends ViewModelWidget<DetailsFormViewModel> {
  final int index;

  const AttendeeForm({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context, DetailsFormViewModel viewModel) {
    final ticketType = _getTicketType(viewModel, index);
    final attendeeDetails = index < viewModel.attendeeDetails.length
        ? viewModel.attendeeDetails[index]
        : <String, String>{};

    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            ticketType,
            style: GoogleFonts.inter(
              color: kcPrimaryColor,
              fontSize: getResponsiveFontSize(context, fontSize: 40),
              fontWeight: FontWeight.bold,
            ),
          ),
          verticalSpaceSmall,
          ValidatedInputField(
            label: 'First Name',
            hint: 'First name',
            validator: validateName,
            initialValue: attendeeDetails['firstName'],
            onChanged: (value) =>
                viewModel.updateAttendeeDetails(index, {'firstName': value}),
          ),
          verticalSpaceSmall,
          ValidatedInputField(
            label: 'Last Name',
            hint: 'Last name',
            validator: validateName,
            initialValue: attendeeDetails['lastName'],
            onChanged: (value) =>
                viewModel.updateAttendeeDetails(index, {'lastName': value}),
          ),
          verticalSpaceSmall,
          ValidatedInputField(
            label: 'Email',
            hint: 'Email address',
            validator: validateEmail,
            initialValue: attendeeDetails['email'],
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) =>
                viewModel.updateAttendeeDetails(index, {'email': value}),
          ),
        ],
      ),
    );
  }

  String _getTicketType(DetailsFormViewModel viewModel, int index) {
    int currentIndex = 0;
    for (var entry in viewModel.selectedTickets.entries) {
      if (index < currentIndex + entry.value) {
        return entry.key.title ?? '';
      }
      currentIndex += entry.value;
    }
    return '';
  }
}
