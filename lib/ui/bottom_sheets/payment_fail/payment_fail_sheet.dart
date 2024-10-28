import 'package:eventy/ui/common/shared/eventy_app_button.dart';
import 'package:flutter/material.dart';
import 'package:eventy/ui/common/app_colors.dart';
import 'package:eventy/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:lottie/lottie.dart';

import 'payment_fail_sheet_model.dart';

class PaymentFailSheet extends StackedView<PaymentFailSheetModel> {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;
  const PaymentFailSheet({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    PaymentFailSheetModel viewModel,
    Widget? child,
  ) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: kcBackgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Error Animation
          SizedBox(
            height: 200,
            child: Lottie.asset(
              'assets/animations/error.json',
              repeat: true,
              reverse: true,
            ),
          ),
          verticalSpaceMedium,
          // Title
          Text(
            'Payment Failed',
            style: TextStyle(
              fontSize: getResponsiveFontSize(context, fontSize: 40),
              fontWeight: FontWeight.w700,
              color: kcPrimaryColor,
            ),
          ),
          verticalSpaceSmall,
          // Description
          Text(
            'Don\'t worry! Your payment wasn\'t processed. Please try again or contact support if the issue persists.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: getResponsiveFontSize(context, fontSize: 35),
              color: kcTextSecondaryColor,
            ),
          ),
          verticalSpaceLarge,
          // Retry Button
          SizedBox(
            height: 42,
            width: screenWidthFraction(context, dividedBy: 2),
            child: EventyAppButton(
              text: 'Try Again',
              onTap: () => completer?.call(SheetResponse(confirmed: true)),
            ),
          ),
          verticalSpaceMedium,
          // Cancel Button
          GestureDetector(
            onTap: () => completer?.call(SheetResponse(confirmed: false)),
            child: Text(
              'Cancel Payment',
              style: TextStyle(
                fontSize: getResponsiveFontSize(context, fontSize: 35),
                color: kcTextSecondaryColor,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          verticalSpaceLarge,
        ],
      ),
    );
  }

  @override
  PaymentFailSheetModel viewModelBuilder(BuildContext context) =>
      PaymentFailSheetModel();
}
