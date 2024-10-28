import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'order_details_viewmodel.dart';

class OrderDetailsView extends StackedView<OrderDetailsViewModel> {
  const OrderDetailsView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    OrderDetailsViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
      ),
    );
  }

  @override
  OrderDetailsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      OrderDetailsViewModel();
}
