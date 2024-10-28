import 'dart:ui';
import 'package:eventy/ui/common/app_colors.dart';
import 'package:eventy/ui/common/shared/eventy_app_button.dart';
import 'package:eventy/ui/common/shared/eventy_network_image.dart';
import 'package:eventy/ui/common/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_octicons/flutter_octicons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';
import '../details_form_viewmodel.dart';
import 'price_item.dart';

class PersistentBottomSheet extends ViewModelWidget<DetailsFormViewModel> {
  const PersistentBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, DetailsFormViewModel viewModel) {
    return DraggableScrollableSheet(
      initialChildSize: 0.12,
      minChildSize: 0.12,
      maxChildSize: 0.9,
      snap: true,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: kcBackgroundColor.withOpacity(0.85),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: const [
              BoxShadow(
                color: ShadowColors.defaultShadow,
                blurRadius: 10,
                spreadRadius: 5,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    verticalSpaceSmall,
                    const DragHandle(),
                    const NavigationButtons(),
                    verticalSpaceLarge,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: EventyNetworkImage(
                          imageUrl: viewModel.eventImage,
                          width: double.infinity,
                          height: 200,
                        ),
                      ),
                    ),
                    verticalSpaceMedium,
                    const BottomSheetEventDetails(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class DragHandle extends StatelessWidget {
  const DragHandle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 5,
      decoration: BoxDecoration(
        color: kcTextPrimaryColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(2.5),
      ),
    );
  }
}

class NavigationButtons extends ViewModelWidget<DetailsFormViewModel> {
  const NavigationButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, DetailsFormViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (viewModel.canMoveToPreviousStep())
            EventyAppButton(
              text: 'Back',
              onTap: viewModel.previousStep,
              backgroundColor: ComponentColors.buttonSecondary,
            )
          else
            const SizedBox.shrink(),
          EventyAppButton(
            isLoading: viewModel.isPaymentIntentBusy,
            text: viewModel.currentStep < 2 ? 'Next' : 'Submit',
            onTap: viewModel.currentStep < 2
                ? (viewModel.canMoveToNextStep() ? viewModel.nextStep : null)
                : (viewModel.isCurrentStepValid()
                    ? viewModel.createPaymentIntent
                    : null),
            isEnabled: viewModel.currentStep < 2
                ? viewModel.canMoveToNextStep()
                : viewModel.isCurrentStepValid(),
            trailingIcon: !viewModel.canMoveToNextStep()
                ? const Icon(
                    OctIcons.lock_16,
                    size: 16,
                    color: Colors.white54,
                  )
                : null,
          ),
        ],
      ),
    );
  }
}

class BottomSheetEventDetails extends ViewModelWidget<DetailsFormViewModel> {
  const BottomSheetEventDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, DetailsFormViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Price Breakdown',
            style: GoogleFonts.inter(
              color: kcTextPrimaryColor,
              fontSize: getResponsiveMediumFontSize(context),
              fontWeight: FontWeight.bold,
            ),
          ),
          verticalSpaceSmall,
          ...viewModel.selectedTickets.entries.map((entry) {
            final ticketPrice = entry.key.price ?? 0;
            final subtotal = ticketPrice * entry.value;
            return PriceItem(
              label: '${entry.key.title} x${entry.value}',
              price: 'THB ${subtotal.toStringAsFixed(2)}',
            );
          }),
          const Divider(color: Colors.white30),
          const PriceItem(
            label: 'Total',
            price: 'THB 33.00',
            isBold: true,
          ),
        ],
      ),
    );
  }
}
