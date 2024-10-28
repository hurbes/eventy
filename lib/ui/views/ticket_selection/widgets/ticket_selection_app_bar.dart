import 'package:flutter/material.dart';
import 'package:flutter_octicons/flutter_octicons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eventy/ui/common/app_colors.dart';

class TicketSelectionAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final int itemCount;

  const TicketSelectionAppBar({
    Key? key,
    required this.title,
    required this.itemCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      backgroundColor: kcBackgroundColor.withOpacity(0.9),
      elevation: 0,
      leading: IconButton(
        icon: const Icon(OctIcons.x_16, color: ComponentColors.iconPrimary),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text(
        title,
        style: GoogleFonts.inter(
          color: kcTextPrimaryColor,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        ItemCountBadge(itemCount: itemCount),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class ItemCountBadge extends StatelessWidget {
  final int itemCount;

  const ItemCountBadge({Key? key, required this.itemCount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: ComponentColors.badgeBackground,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        '$itemCount items',
        style: GoogleFonts.inter(
          color: ComponentColors.badgeText,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
