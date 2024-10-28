import 'package:flutter/material.dart';
import '../../../common/app_colors.dart';
import '../../../common/ui_helpers.dart';

class TicketQRSection extends StatelessWidget {
  const TicketQRSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: screenHeightPercentage(context, percentage: 0.5),
      margin: const EdgeInsets.symmetric(horizontal: 25),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: ComponentColors.cardBackground,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: ComponentColors.cardBorder,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Text(
            'Scan This QR',
            style: TextStyle(
              color: Colors.white,
              fontSize: getResponsiveFontSize(context, fontSize: 45),
              fontWeight: FontWeight.bold,
            ),
          ),
          verticalSpaceSmall,
          Text(
            'point this qr to the scan place',
            style: TextStyle(
              color: kcTextSecondaryColor,
              fontSize: getResponsiveFontSize(context, fontSize: 35),
            ),
          ),
          verticalSpaceMedium,
          Container(
            width: screenHeightPercentage(context, percentage: 0.8),
            height: screenHeightPercentage(context, percentage: 0.3),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  kcPrimaryColor,
                  kcPrimaryColor.withOpacity(0.8),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Icon(
              Icons.qr_code,
              size: screenHeightPercentage(context, percentage: 0.3),
              color: Colors.white,
            ),
          ),
          verticalSpaceMedium,
          const Text(
            'DWP IV X AW',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ],
      ),
    );
  }
}
