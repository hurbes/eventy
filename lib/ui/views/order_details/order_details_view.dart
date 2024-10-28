import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:stacked/stacked.dart';
import '../../../ui/common/app_colors.dart';
import '../../../ui/common/ui_helpers.dart';
import 'order_details_viewmodel.dart';
import 'widgets/ticket_qr_section.dart';
import 'widgets/ticket_details_section.dart';
import 'widgets/ticket_header.dart';

class OrderDetailsView extends StackedView<OrderDetailsViewModel> {
  const OrderDetailsView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    OrderDetailsViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: kcBackgroundColor,
      body: CustomScrollView(
        slivers: [
          const TicketHeader(),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: [
                verticalSpaceMedium,
                const TicketQRSection()
                    .animate(
                      onPlay: (controller) => controller.repeat(reverse: true),
                    )
                    .scaleXY(duration: 1500.ms, end: 0.98),
                verticalSpaceLarge,
                const TicketDetailsSection(),
                verticalSpaceLarge,
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  OrderDetailsViewModel viewModelBuilder(BuildContext context) =>
      OrderDetailsViewModel();
}
