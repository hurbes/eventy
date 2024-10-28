import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eventy/ui/common/app_colors.dart';

class EventyAppButton extends StatefulWidget {
  final String text;
  final VoidCallback? onTap;
  final bool isEnabled;
  final bool isLoading;
  final double? width;
  final double height;
  final double borderRadius;
  final Color? backgroundColor;
  final Color? disabledColor;
  final EdgeInsets padding;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final TextStyle? textStyle;
  final Duration animationDuration;
  final Curve animationCurve;

  const EventyAppButton({
    Key? key,
    required this.text,
    this.onTap,
    this.isEnabled = true,
    this.isLoading = false,
    this.width,
    this.height = 50,
    this.borderRadius = 12,
    this.backgroundColor,
    this.disabledColor,
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    this.leadingIcon,
    this.trailingIcon,
    this.textStyle,
    this.animationDuration = const Duration(milliseconds: 150),
    this.animationCurve = Curves.easeInOut,
  }) : super(key: key);

  @override
  State<EventyAppButton> createState() => _EventyAppButtonState();
}

class _EventyAppButtonState extends State<EventyAppButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: widget.animationCurve,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    if (!widget.isEnabled || widget.isLoading) return;
    setState(() => isPressed = true);
    _controller.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    if (!widget.isEnabled || widget.isLoading) return;
    setState(() => isPressed = false);
    _controller.reverse();
  }

  void _handleTapCancel() {
    if (!widget.isEnabled || widget.isLoading) return;
    setState(() => isPressed = false);
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = !widget.isEnabled || widget.isLoading;

    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) => Transform.scale(
        scale: _scaleAnimation.value,
        child: child,
      ),
      child: GestureDetector(
        onTapDown: _handleTapDown,
        onTapUp: _handleTapUp,
        onTapCancel: _handleTapCancel,
        onTap: isDisabled ? null : widget.onTap,
        child: AnimatedContainer(
          duration: widget.animationDuration,
          curve: widget.animationCurve,
          width: widget.width,
          height: widget.height,
          padding: widget.padding,
          decoration: BoxDecoration(
            color: isDisabled
                ? (widget.disabledColor ?? ComponentColors.buttonDisabled)
                : (widget.backgroundColor ?? ComponentColors.buttonPrimary),
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize:
                widget.width == null ? MainAxisSize.min : MainAxisSize.max,
            children: [
              if (widget.leadingIcon != null) ...[
                widget.leadingIcon!,
                const SizedBox(width: 8),
              ],
              if (widget.isLoading)
                const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(kcTextPrimaryColor),
                  ),
                )
              else
                Text(
                  widget.text,
                  style: widget.textStyle ??
                      GoogleFonts.inter(
                        color: kcTextPrimaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              if (widget.trailingIcon != null) ...[
                const SizedBox(width: 8),
                widget.trailingIcon!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}
