import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eventy/ui/common/app_colors.dart';
import 'package:eventy/ui/common/ui_helpers.dart';
import 'quantity_selector.dart';

class ProductItem extends StatelessWidget {
  final String title;
  final String description;
  final double price;
  final String currency;
  final int quantity;
  final VoidCallback onAdd;
  final VoidCallback onRemove;
  final bool canAdd;
  final bool canRemove;
  final bool maxReached;

  const ProductItem({
    Key? key,
    required this.title,
    required this.description,
    required this.price,
    required this.currency,
    required this.quantity,
    required this.onAdd,
    required this.onRemove,
    required this.canAdd,
    required this.canRemove,
    required this.maxReached,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ComponentColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              color: kcTextPrimaryColor,
              fontSize: getResponsiveFontSize(context, fontSize: 36),
              fontWeight: FontWeight.bold,
            ),
          ),
          verticalSpaceSmall,
          HtmlWidget(
            description,
            textStyle: GoogleFonts.inter(
              color: kcTextSecondaryColor,
              fontSize: getResponsiveFontSize(context, fontSize: 33),
            ),
          ),
          verticalSpaceSmall,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PriceDisplay(price: price, currency: currency),
              QuantitySelector(
                quantity: quantity,
                onAdd: onAdd,
                onRemove: onRemove,
                canAdd: canAdd,
                canRemove: canRemove,
              ),
            ],
          ),
          if (maxReached) ...[
            verticalSpaceSmall,
            Text(
              'Maximum tickets reached',
              style: GoogleFonts.inter(
                color: kcPrimaryColor,
                fontSize: getResponsiveFontSize(context, fontSize: 33),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class PriceDisplay extends StatelessWidget {
  final double price;
  final String currency;

  const PriceDisplay({
    Key? key,
    required this.price,
    required this.currency,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      '$currency ${price.toStringAsFixed(2)}',
      style: GoogleFonts.inter(
        color: kcPrimaryColor,
        fontSize: getResponsiveFontSize(context, fontSize: 33),
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
