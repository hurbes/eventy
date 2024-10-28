import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_octicons/flutter_octicons.dart';
import 'package:google_fonts/google_fonts.dart';

class ValidatedInputField extends StatefulWidget {
  final String label;
  final String hint;
  final String? Function(String?) validator;
  final TextInputType keyboardType;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String)? onChanged;
  final String? initialValue;

  const ValidatedInputField({
    Key? key,
    required this.label,
    required this.hint,
    required this.validator,
    this.keyboardType = TextInputType.text,
    this.maxLength,
    this.inputFormatters,
    this.onChanged,
    this.initialValue,
  }) : super(key: key);

  @override
  _ValidatedInputFieldState createState() => _ValidatedInputFieldState();
}

class _ValidatedInputFieldState extends State<ValidatedInputField> {
  late final TextEditingController _controller;
  final _focusNode = FocusNode();
  String? _errorText;
  bool _isInteracted = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
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
      if (_controller.text.isNotEmpty && widget.onChanged != null) {
        widget.onChanged!(_controller.text);
      }
    }
  }

  void _onTextChange() {
    if (!_isInteracted) {
      setState(() {
        _isInteracted = true;
      });
    }
    if (_controller.text.isNotEmpty && widget.onChanged != null) {
      widget.onChanged!(_controller.text);
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
