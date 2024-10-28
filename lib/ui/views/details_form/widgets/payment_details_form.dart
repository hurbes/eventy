import 'package:eventy/ui/common/app_colors.dart';
import 'package:eventy/ui/common/ui_helpers.dart';
import 'package:eventy/ui/widgets/common/event_card/event_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';

import '../details_form_viewmodel.dart';
import 'price_item.dart';

class PaymentDetailsForm extends ViewModelWidget<DetailsFormViewModel> {
  const PaymentDetailsForm({super.key});

  @override
  Widget build(BuildContext context, DetailsFormViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EventCard(event: viewModel.event!),
        verticalSpaceMedium,
        const OrderSummaryCard(),
      ],
    );
  }
}

class EventDetailRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const EventDetailRow({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: kcTextSecondaryColor,
        ),
        horizontalSpaceTiny,
        Text(
          text,
          style: GoogleFonts.inter(
            color: kcTextSecondaryColor,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}

class OrderSummaryCard extends ViewModelWidget<DetailsFormViewModel> {
  const OrderSummaryCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, DetailsFormViewModel viewModel) {
    final subtotal = _calculateSubtotal(viewModel);
    final fees = _calculateFees(subtotal);
    final total = subtotal + fees;
    final currency = viewModel.event?.currency ?? 'THB';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Order Summary',
          style: GoogleFonts.inter(
            color: kcTextPrimaryColor,
            fontSize: getResponsiveFontSize(context, fontSize: 35),
            fontWeight: FontWeight.bold,
          ),
        ),
        verticalSpaceSmall,
        Container(
          decoration: BoxDecoration(
            color: ComponentColors.cardBackground,
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              ...viewModel.selectedTickets.entries.map((entry) {
                final subtotal = entry.key.price! * entry.value;
                return PriceItem(
                  label: '${entry.value}x ${entry.key.title}',
                  price: '$currency ${subtotal.toStringAsFixed(2)}',
                );
              }),
              verticalSpaceTiny,
              PriceItem(
                label: 'Subtotal',
                price: '$currency ${subtotal.toStringAsFixed(2)}',
              ),
              verticalSpaceTiny,
              PriceItem(
                label: 'Fees',
                price: '$currency ${fees.toStringAsFixed(2)}',
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Divider(color: Colors.white24),
              ),
              PriceItem(
                label: 'Total',
                price: '$currency ${total.toStringAsFixed(2)}',
                isBold: true,
              ),
            ],
          ),
        ),
      ],
    );
  }

  double _calculateSubtotal(DetailsFormViewModel viewModel) {
    return viewModel.selectedTickets.entries.fold(
      0.0,
      (sum, entry) => sum + (entry.key.price ?? 0) * entry.value,
    );
  }

  double _calculateFees(double subtotal) {
    // Example: 10% service fee
    return subtotal * 0.10;
  }
}
