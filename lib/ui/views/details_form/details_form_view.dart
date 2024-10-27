import 'dart:ui';

import 'package:eventy/core/models/event/event.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:stacked/stacked.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_octicons/flutter_octicons.dart';
import 'details_form_viewmodel.dart';

class DetailsFormView extends StackedView<DetailsFormViewModel> {
  const DetailsFormView({Key? key}) : super(key: key);

  @override
  Widget builder(
      BuildContext context, DetailsFormViewModel viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: const Color(0xff22141a),
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
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: StepTitle(),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverAnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: CurrentStep(key: ValueKey(viewModel.currentStep)),
                ),
              ),
              SliverToBoxAdapter(
                child:
                    SizedBox(height: MediaQuery.of(context).size.height * 0.15),
              ),
            ],
          ),
          const PersistentBottomSheet(),
        ],
      ),
    );
  }

  @override
  DetailsFormViewModel viewModelBuilder(BuildContext context) =>
      DetailsFormViewModel();
}

class DetailsFormAppBar extends StatelessWidget {
  const DetailsFormAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: const Color(0xff22141a),
      elevation: 0,
      pinned: true,
      leading: IconButton(
        icon: const Icon(OctIcons.arrow_left_16, color: Colors.white),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text(
        '(NOT A) Halloween Party',
        style: GoogleFonts.inter(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
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

class AnimatedProgressBar extends StatelessWidget {
  final int currentStep;

  const AnimatedProgressBar({Key? key, required this.currentStep})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff22141a),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      child: Row(
        children: List.generate(3, (index) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: TweenAnimationBuilder<double>(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                tween: Tween(
                  begin: 0,
                  end: index <= currentStep ? 1.0 : 0.0,
                ),
                builder: (context, value, child) {
                  return LinearProgressIndicator(
                    value: value,
                    backgroundColor: Colors.grey.withOpacity(0.3),
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Color(0xFFFF4E8D)),
                    minHeight: 4,
                  );
                },
              ),
            ),
          );
        }),
      ),
    );
  }
}

class CurrentStep extends ViewModelWidget<DetailsFormViewModel> {
  const CurrentStep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, DetailsFormViewModel viewModel) {
    switch (viewModel.currentStep) {
      case 0:
        return const SliverToBoxAdapter(child: YourDetails());
      case 1:
        return const AttendeeDetails();
      case 2:
        return const SliverToBoxAdapter(child: PaymentDetails());
      default:
        return const SliverToBoxAdapter(child: SizedBox.shrink());
    }
  }
}

class YourDetails extends ViewModelWidget<DetailsFormViewModel> {
  const YourDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, DetailsFormViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your Details',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 24),
        const ValidatedInputField(
          label: 'First Name',
          hint: 'First name',
          validator: validateName,
          maxLength: 50,
        ),
        const SizedBox(height: 24),
        const ValidatedInputField(
          label: 'Last Name',
          hint: 'Last Name',
          validator: validateName,
          maxLength: 50,
        ),
        const SizedBox(height: 24),
        const ValidatedInputField(
          label: 'Email Address',
          hint: 'Email Address',
          validator: validateEmail,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 24),
        const CopyDetailsCheckbox(),
      ],
    );
  }
}

class AttendeeDetails extends ViewModelWidget<DetailsFormViewModel> {
  const AttendeeDetails({Key? key}) : super(key: key);

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
          color: Colors.white,
          fontSize: 24,
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
    String ticketType = '';
    int currentIndex = 0;
    for (var entry in viewModel.selectedTickets.entries) {
      if (index < currentIndex + entry.value) {
        ticketType = entry.key.title ?? '';
        break;
      }
      currentIndex += entry.value;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            ticketType,
            style: GoogleFonts.inter(
              color: const Color(0xFFFF4E8D),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ValidatedInputField(
            label: 'First Name',
            hint: 'First name',
            validator: validateName,
            onChanged: (value) =>
                viewModel.updateAttendeeDetails(index, {'firstName': value}),
          ),
          const SizedBox(height: 16),
          ValidatedInputField(
            label: 'Last Name',
            hint: 'Last name',
            validator: validateName,
            onChanged: (value) =>
                viewModel.updateAttendeeDetails(index, {'lastName': value}),
          ),
          const SizedBox(height: 16),
          ValidatedInputField(
            label: 'Email',
            hint: 'Email address',
            validator: validateEmail,
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) =>
                viewModel.updateAttendeeDetails(index, {'email': value}),
          ),
        ],
      ),
    );
  }
}

class PaymentDetails extends StatelessWidget {
  const PaymentDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Payment Details',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 24),
        const ValidatedInputField(
          label: 'Card Number',
          hint: '1234 5678 9012 3456',
          validator: validateCardNumber,
          keyboardType: TextInputType.number,
          maxLength: 16,
        ),
        const SizedBox(height: 24),
        Row(
          children: const [
            Expanded(
              child: ValidatedInputField(
                label: 'Expiry Date',
                hint: 'MM/YY',
                validator: validateExpiryDate,
                keyboardType: TextInputType.datetime,
                maxLength: 5,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: ValidatedInputField(
                label: 'CVV',
                hint: '123',
                validator: validateCVV,
                keyboardType: TextInputType.number,
                maxLength: 3,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        const ValidatedInputField(
          label: 'Name on Card',
          hint: 'John Doe',
          validator: validateName,
          maxLength: 50,
        ),
      ],
    );
  }
}

class ValidatedInputField extends StatefulWidget {
  final String label;
  final String hint;
  final String? Function(String?) validator;
  final TextInputType keyboardType;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String)? onChanged;

  const ValidatedInputField({
    Key? key,
    required this.label,
    required this.hint,
    required this.validator,
    this.keyboardType = TextInputType.text,
    this.maxLength,
    this.inputFormatters,
    this.onChanged,
  }) : super(key: key);

  @override
  _ValidatedInputFieldState createState() => _ValidatedInputFieldState();
}

class _ValidatedInputFieldState extends State<ValidatedInputField> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  String? _errorText;
  bool _isInteracted = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
    _controller.addListener(_onTextChange);
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    if (!_focusNode.hasFocus) {
      setState(() {
        _errorText = widget.validator(_controller.text);
      });
    }
  }

  void _onTextChange() {
    if (!_isInteracted) {
      setState(() {
        _isInteracted = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextFormField(
            controller: _controller,
            focusNode: _focusNode,
            style: GoogleFonts.inter(color: Colors.white),
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: GoogleFonts.inter(color: Colors.grey),
              border: InputBorder.none,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              suffixIcon: _isInteracted && _errorText == null
                  ? const Icon(OctIcons.check_circle_16,
                      color: Color(0xFFFF4E8D))
                  : null,
            ),
            keyboardType: widget.keyboardType,
            maxLength: widget.maxLength,
            inputFormatters: widget.inputFormatters,
            buildCounter: (context,
                    {required currentLength, required isFocused, maxLength}) =>
                null,
          ),
        ),
        if (_errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              _errorText!,
              style: GoogleFonts.inter(
                color: const Color(0xFFFF4E8D),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
      ],
    );
  }
}

// Validation functions
String? validateName(String? value) {
  if (value == null || value.isEmpty) {
    return 'This field is required';
  }
  if (value.length < 2) {
    return 'Name must be at least 2 characters long';
  }
  return null;
}

String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter an email address';
  }
  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
    return 'Please enter a valid email address';
  }
  return null;
}

String? validateCardNumber(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a card number';
  }
  if (value.length != 16 || !RegExp(r'^[0-9]+$').hasMatch(value)) {
    return 'Please enter a valid 16-digit card number';
  }
  return null;
}

String? validateExpiryDate(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter an expiry date';
  }
  if (!RegExp(r'^(0[1-9]|1[0-2])\/[0-9]{2}$').hasMatch(value)) {
    return 'Please enter a valid expiry date (MM/YY)';
  }
  return null;
}

String? validateCVV(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a CVV';
  }
  if (value.length != 3 || !RegExp(r'^[0-9]+$').hasMatch(value)) {
    return 'Please enter a valid 3-digit CVV';
  }
  return null;
}

class InputField extends StatelessWidget {
  final String label;
  final String hint;

  const InputField({Key? key, required this.label, required this.hint})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            style: GoogleFonts.inter(color: Colors.white),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: GoogleFonts.inter(color: Colors.grey),
              border: InputBorder.none,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              suffixIcon: const Icon(OctIcons.check_circle_16,
                  color: Color(0xFFFF4E8D)),
            ),
          ),
        ),
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
          fillColor: WidgetStateProperty.resolveWith(
              (states) => const Color(0xFFFF4E8D)),
        ),
        Text(
          'Copy details to all attendees',
          style: GoogleFonts.inter(color: Colors.white, fontSize: 14),
        ),
      ],
    );
  }
}

class PersistentBottomSheet extends ViewModelWidget<DetailsFormViewModel> {
  const PersistentBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, DetailsFormViewModel viewModel) {
    return DraggableScrollableSheet(
      initialChildSize: 0.13,
      minChildSize: 0.13,
      maxChildSize: 0.9,
      snap: true,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: const Color(0xff22141a).withOpacity(0.85),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                spreadRadius: 5,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  children: [
                    const SizedBox(height: 12),
                    const DragHandle(),
                    const NavigationButtons(),
                    const SizedBox(height: 16),
                    EventDetails(selectedTickets: viewModel.selectedTickets),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class DragHandle extends StatelessWidget {
  const DragHandle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 5,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(2.5),
      ),
    );
  }
}

class NavigationButtons extends ViewModelWidget<DetailsFormViewModel> {
  const NavigationButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, DetailsFormViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (viewModel.currentStep > 0)
            ElevatedButton(
              onPressed: viewModel.previousStep,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Back',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          else
            const SizedBox.shrink(),
          ElevatedButton(
            onPressed: viewModel.currentStep < 2
                ? viewModel.nextStep
                : () {/* Submit form */},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF4E8D),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              viewModel.currentStep < 2 ? 'Next' : 'Submit',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EventDetails extends StatelessWidget {
  final Map<Ticket, int> selectedTickets;

  const EventDetails({Key? key, required this.selectedTickets})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double totalPrice = 0;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Price Breakdown',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          ...selectedTickets.entries.map((entry) {
            final ticketPrice = entry.key.price ?? 0;
            final subtotal = ticketPrice * entry.value;
            totalPrice += subtotal;
            return PriceItem(
              label: '${entry.key.title} x${entry.value}',
              price: 'THB ${subtotal.toStringAsFixed(2)}',
            );
          }),
          const Divider(color: Colors.white30),
          PriceItem(
            label: 'Total',
            price: 'THB ${totalPrice.toStringAsFixed(2)}',
            isBold: true,
          ),
        ],
      ),
    );
  }
}

class PriceItem extends StatelessWidget {
  final String label;
  final String price;
  final bool isBold;

  const PriceItem({
    Key? key,
    required this.label,
    required this.price,
    this.isBold = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            price,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

class StepTitle extends ViewModelWidget<DetailsFormViewModel> {
  @override
  Widget build(BuildContext context, DetailsFormViewModel viewModel) {
    String title;
    String subtitle;

    switch (viewModel.currentStep) {
      case 0:
        title = 'Who\'s Booking?';
        subtitle = 'Let\'s start with your details';
        break;
      case 1:
        title = 'Who\'s Coming?';
        subtitle = 'Tell us about your fellow party-goers';
        break;
      case 2:
        title = 'Secure Your Spot!';
        subtitle = 'Just a few more details to confirm your booking';
        break;
      default:
        title = 'Oops!';
        subtitle = 'Something went wrong';
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.creepster(
            color: const Color(0xFFFF4E8D),
            fontSize: 36,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                blurRadius: 10.0,
                color: Colors.black.withOpacity(0.3),
                offset: const Offset(5, 5),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: GoogleFonts.inter(
            color: Colors.white70,
            fontSize: 16,
            fontStyle: FontStyle.italic,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}
