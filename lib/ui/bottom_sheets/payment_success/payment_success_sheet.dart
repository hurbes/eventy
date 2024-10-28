import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:eventy/ui/common/app_colors.dart';
import 'package:eventy/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:lottie/lottie.dart';
import 'package:eventy/ui/common/shared/eventy_app_button.dart';

import 'payment_success_sheet_model.dart';

class PaymentSuccessSheet extends StackedView<PaymentSuccessSheetModel> {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;
  const PaymentSuccessSheet({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    PaymentSuccessSheetModel viewModel,
    Widget? child,
  ) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
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
              // Success Animation
              SizedBox(
                height: 200,
                child: Lottie.asset(
                  'assets/animations/success.json',
                  repeat: false,
                  onLoaded: (composition) {
                    viewModel.startConfetti();
                  },
                ),
              ),
              verticalSpaceMedium,
              // Title with Animation
              TweenAnimationBuilder<double>(
                duration: const Duration(milliseconds: 800),
                tween: Tween(begin: 0.0, end: 1.0),
                builder: (context, value, child) {
                  return Transform.scale(
                    scale: value,
                    child: child,
                  );
                },
                child: Text(
                  'Woohoo! 🎉',
                  style: TextStyle(
                    fontSize: getResponsiveFontSize(context, fontSize: 60),
                    fontWeight: FontWeight.w700,
                    color: kcPrimaryColor,
                  ),
                ),
              ),
              verticalSpaceSmall,
              // Description with Animation
              TweenAnimationBuilder<double>(
                duration: const Duration(milliseconds: 800),
                tween: Tween(begin: 0.0, end: 1.0),
                curve: Curves.easeOutCubic,
                builder: (context, value, child) {
                  return Opacity(
                    opacity: value,
                    child: child,
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Text(
                    'Your ticket is confirmed! Get ready for an amazing experience. We can\'t wait to see you there!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: getResponsiveFontSize(context, fontSize: 35),
                      color: kcTextSecondaryColor,
                    ),
                  ),
                ),
              ),
              verticalSpaceLarge,
              // View Ticket Button with Animation
              TweenAnimationBuilder<double>(
                duration: const Duration(milliseconds: 800),
                tween: Tween(begin: 0.0, end: 1.0),
                curve: Curves.elasticOut,
                builder: (context, value, child) {
                  return Transform.scale(
                    scale: value,
                    child: child,
                  );
                },
                child: SizedBox(
                  height: 42,
                  width: screenWidthFraction(context, dividedBy: 2),
                  child: EventyAppButton(
                    text: 'View Ticket',
                    onTap: () =>
                        completer?.call(SheetResponse(confirmed: true)),
                  ),
                ),
              ),
              verticalSpaceLarge,
            ],
          ),
        ),
        // Left Confetti
        Positioned(
          left: 0,
          child: ConfettiWidget(
            confettiController: viewModel.leftConfettiController,
            blastDirection: -pi / 3, // Slightly to the right
            emissionFrequency: 0.05,
            numberOfParticles: 10,
            maxBlastForce: 20,
            minBlastForce: 10,
            gravity: 0.2,
            particleDrag: 0.1,
            colors: const [
              kcPrimaryColor,
              kcSuccessColor,
              Colors.blue,
              Colors.orange,
              Colors.purple,
            ],
          ),
        ),
        // Center Confetti
        ConfettiWidget(
          confettiController: viewModel.centerConfettiController,
          blastDirection: -pi / 2, // Straight up
          emissionFrequency: 0.05,
          numberOfParticles: 15,
          maxBlastForce: 25,
          minBlastForce: 15,
          gravity: 0.2,
          particleDrag: 0.1,
          colors: const [
            kcPrimaryColor,
            kcSuccessColor,
            Colors.blue,
            Colors.orange,
            Colors.purple,
          ],
        ),
        // Right Confetti
        Positioned(
          right: 0,
          child: ConfettiWidget(
            confettiController: viewModel.rightConfettiController,
            blastDirection: -2 * pi / 3, // Slightly to the left
            emissionFrequency: 0.05,
            numberOfParticles: 10,
            maxBlastForce: 20,
            minBlastForce: 10,
            gravity: 0.2,
            particleDrag: 0.1,
            colors: const [
              kcPrimaryColor,
              kcSuccessColor,
              Colors.blue,
              Colors.orange,
              Colors.purple,
            ],
          ),
        ),
      ],
    );
  }

  @override
  PaymentSuccessSheetModel viewModelBuilder(BuildContext context) =>
      PaymentSuccessSheetModel();
}
