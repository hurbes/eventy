import 'package:eventy/ui/common/app_colors.dart';
import 'package:eventy/ui/common/ui_helpers.dart';
import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';

import 'ticket_selection_viewmodel.dart';
import 'widgets/ticket_selection_app_bar.dart';
import 'widgets/ticket_selection_header.dart';
import 'widgets/top_card.dart';
import 'widgets/product_item.dart';
import 'widgets/next_button.dart';

class TicketSelectionView extends StackedView<TicketSelectionViewModel> {
  const TicketSelectionView({Key? key}) : super(key: key);

  @override
  Widget builder(
      BuildContext context, TicketSelectionViewModel viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: kcBackgroundColor,
      body: CustomScrollView(
        slivers: [
          TicketSelectionAppBar(
            title: viewModel.event?.title ?? '',
            itemCount: viewModel.event?.tickets.length ?? 0,
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                const TicketSelectionHeader(),
                if (viewModel.event != null)
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: TopCard(
                      event: viewModel.event!,
                      eventImage: viewModel.eventImage,
                    ),
                  ),
              ],
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final ticket = viewModel.tickets[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: ProductItem(
                      title: ticket.title ?? '',
                      description: ticket.description ?? '',
                      price: ticket.price ?? 0,
                      currency: viewModel.event?.currency ?? '',
                      quantity: viewModel.quantityForTicket(ticket),
                      onAdd: () => viewModel.addTicket(ticket),
                      onRemove: () => viewModel.removeTicket(ticket),
                      canAdd: viewModel.canAddMoreTickets(ticket),
                      canRemove: viewModel.canRemoveTickets(ticket),
                      maxReached: viewModel.quantityForTicket(ticket) ==
                          ticket.prices.first.quantityRemaining,
                    ),
                  );
                },
                childCount: viewModel.tickets.length,
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: verticalSpaceLarge,
            ),
          ),
        ],
      ),
      bottomNavigationBar: const NextButton(),
    );
  }

  @override
  TicketSelectionViewModel viewModelBuilder(BuildContext context) =>
      TicketSelectionViewModel();
}
