import 'package:flutter/material.dart';
import 'package:flutter_octicons/flutter_octicons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eventy/ui/common/app_colors.dart';
import 'package:eventy/ui/common/shared/animated_flip_counter.dart';

class QuantitySelector extends StatelessWidget {
  final int quantity;
  final VoidCallback onAdd;
  final VoidCallback onRemove;
  final bool canAdd;
  final bool canRemove;

  const QuantitySelector({
    Key? key,
    required this.quantity,
    required this.onAdd,
    required this.onRemove,
    required this.canAdd,
    required this.canRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ComponentColors.cardBackground,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _QuantityButton(
            icon: OctIcons.dash_16,
            onTap: canRemove ? onRemove : null,
          ),
          AnimatedFlipCounter(
            value: quantity,
            textStyle: GoogleFonts.inter(
              color: kcTextPrimaryColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          _QuantityButton(
            icon: OctIcons.plus_16,
            onTap: canAdd ? onAdd : null,
          ),
        ],
      ),
    );
  }
}

class _QuantityButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _QuantityButton({
    Key? key,
    required this.icon,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        icon,
        color: onTap != null
            ? ComponentColors.iconPrimary
            : ComponentColors.iconSecondary,
        size: 16,
      ),
      onPressed: onTap,
    );
  }
}
