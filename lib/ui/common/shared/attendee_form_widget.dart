import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_octicons/flutter_octicons.dart';

class AttendeeFormWidget extends StatefulWidget {
  final int index;
  final String ticketType;
  final Function(Map<String, String>) onFormSubmit;

  const AttendeeFormWidget({
    Key? key,
    required this.index,
    required this.ticketType,
    required this.onFormSubmit,
  }) : super(key: key);

  @override
  _AttendeeFormWidgetState createState() => _AttendeeFormWidgetState();
}

class _AttendeeFormWidgetState extends State<AttendeeFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      widget.onFormSubmit({
        'firstName': _firstNameController.text,
        'lastName': _lastNameController.text,
        'email': _emailController.text,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AttendeeFormHeader(
              index: widget.index, ticketType: widget.ticketType),
          const SizedBox(height: 16),
          AttendeeInputField(
            label: 'First Name',
            hint: 'First name',
            controller: _firstNameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a first name';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          AttendeeInputField(
            label: 'Last Name',
            hint: 'Last Name',
            controller: _lastNameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a last name';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          AttendeeInputField(
            label: 'Email Address',
            hint: 'Email Address',
            controller: _emailController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter an email address';
              }
              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                  .hasMatch(value)) {
                return 'Please enter a valid email address';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class AttendeeFormHeader extends StatelessWidget {
  final int index;
  final String ticketType;

  const AttendeeFormHeader({
    Key? key,
    required this.index,
    required this.ticketType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'Attendee ${index + 1} Details ($ticketType)',
      style: GoogleFonts.inter(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class AttendeeInputField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const AttendeeInputField({
    Key? key,
    required this.label,
    required this.hint,
    required this.controller,
    this.validator,
  }) : super(key: key);

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
          child: TextFormField(
            controller: controller,
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
            validator: validator,
          ),
        ),
      ],
    );
  }
}
