import 'package:flutter/material.dart';
import '../../../common/app_colors.dart';
import '../../../common/ui_helpers.dart';

class TicketDetailsSection extends StatelessWidget {
  const TicketDetailsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildDetailRow(
            context,
            'Full Name',
            'Esmeralda',
            'Hour',
            '10:00 AM',
          ),
          verticalSpaceMedium,
          _buildDetailRow(
            context,
            'Date',
            '27 Dec 2022',
            'Seat',
            'A1, A2',
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context,
    String label1,
    String value1,
    String label2,
    String value2,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: _buildDetailItem(context, label1, value1),
        ),
        horizontalSpaceMedium,
        Expanded(
          child: _buildDetailItem(context, label2, value2),
        ),
      ],
    );
  }

  Widget _buildDetailItem(BuildContext context, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: TextStyle(
            color: kcTextSecondaryColor,
            fontSize: getResponsiveFontSize(context, fontSize: 35),
          ),
        ),
        verticalSpaceTiny,
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: getResponsiveFontSize(context, fontSize: 35),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
