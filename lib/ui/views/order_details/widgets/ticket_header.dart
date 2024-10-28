import 'package:flutter/material.dart';
import '../../../common/app_colors.dart';
import '../../../common/ui_helpers.dart';

class TicketHeader extends StatelessWidget {
  const TicketHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: kcBackgroundColor,
      expandedHeight: 120,
      floating: false,
      pinned: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          'View Ticket',
          style: TextStyle(
            color: Colors.white,
            fontSize: getResponsiveFontSize(context, fontSize: 40),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
    );
  }
}
