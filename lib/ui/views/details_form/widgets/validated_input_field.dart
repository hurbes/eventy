import 'package:eventy/ui/common/app_colors.dart';
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
            color: kcTextPrimaryColor,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: ComponentColors.inputBackground,
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextFormField(
            controller: _controller,
            focusNode: _focusNode,
            style: GoogleFonts.inter(color: kcTextPrimaryColor),
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle:
                  GoogleFonts.inter(color: ComponentColors.inputHintText),
              border: InputBorder.none,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              suffixIcon: _isInteracted && _errorText == null
                  ? const Icon(OctIcons.check_circle_16, color: kcPrimaryColor)
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
                color: ComponentColors.inputErrorText,
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

String? validatePhone(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a phone number';
  }
  if (!RegExp(r'^\+?[\d\s-]{10,}$').hasMatch(value)) {
    return 'Please enter a valid phone number';
  }
  return null;
}
