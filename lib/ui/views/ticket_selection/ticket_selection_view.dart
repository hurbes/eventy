import 'package:cached_network_image/cached_network_image.dart';
import 'package:eventy/core/models/event/event.dart';
import 'package:eventy/ui/common/shared/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stacked/stacked.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_octicons/flutter_octicons.dart';

import 'ticket_selection_viewmodel.dart';

class TicketSelectionView extends StackedView<TicketSelectionViewModel> {
  const TicketSelectionView({Key? key}) : super(key: key);

  @override
  Widget builder(
      BuildContext context, TicketSelectionViewModel viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: const Color(0xff22141a),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: const Color(0xff22141a).withOpacity(0.9),
            elevation: 0,
            leading: IconButton(
              icon: const Icon(OctIcons.x_16, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text(
              viewModel.event?.title ?? '',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              ItemCountBadge(itemCount: viewModel.event?.tickets.length ?? 0),
            ],
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
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final ticket = viewModel.tickets[index];
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
          SliverFillRemaining(
            hasScrollBody: false,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: NextButton(onPressed: viewModel.navigateToDetailsForm),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  TicketSelectionViewModel viewModelBuilder(BuildContext context) =>
      TicketSelectionViewModel();
}

class TicketSelectionHeader extends StatelessWidget {
  const TicketSelectionHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            'Select Your Tickets',
            style: GoogleFonts.inter(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Choose from our available ticket options',
            style: GoogleFonts.inter(
              fontSize: 16,
              color: Colors.grey[400],
            ),
          ),
        ],
      ),
    );
  }
}

class ItemCountBadge extends StatelessWidget {
  final int itemCount;

  const ItemCountBadge({Key? key, required this.itemCount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFFF4E8D),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        '$itemCount items',
        style: GoogleFonts.inter(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  final String title;
  final String description;
  final double price;
  final String currency;
  final int quantity;
  final void Function() onAdd;
  final void Function() onRemove;
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
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProductTitle(title: title),
          const SizedBox(height: 12),
          ProductDescription(description: description),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ProductPrice(price: price, currency: currency),
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
            const SizedBox(height: 8),
            Text(
              'Maximum tickets reached',
              style: GoogleFonts.inter(
                color: const Color(0xFFFF4E8D),
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class ProductTitle extends StatelessWidget {
  final String title;

  const ProductTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.inter(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class ProductDescription extends StatelessWidget {
  final String description;

  const ProductDescription({Key? key, required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HtmlWidget(
      description,
      textStyle: GoogleFonts.inter(
        color: Colors.grey[400],
        fontSize: 14,
      ),
    );
  }
}

class ProductPrice extends StatelessWidget {
  final double price;
  final String currency;

  const ProductPrice({Key? key, required this.price, required this.currency})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      '$currency ${price.toStringAsFixed(2)}',
      style: GoogleFonts.inter(
        color: const Color(0xFFFF4E8D),
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class QuantitySelector extends StatelessWidget {
  final void Function() onAdd;
  final void Function() onRemove;
  final int quantity;
  final bool canAdd;
  final bool canRemove;

  const QuantitySelector({
    Key? key,
    required this.onAdd,
    required this.onRemove,
    required this.quantity,
    required this.canAdd,
    required this.canRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(
              OctIcons.dash_16,
              color: canRemove ? Colors.white : Colors.grey,
              size: 16,
            ),
            onPressed: canRemove ? onRemove : null,
          ),
          AnimatedFlipCounter(
            value: quantity,
            textStyle: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            icon: Icon(
              OctIcons.plus_16,
              color: canAdd ? Colors.white : Colors.grey,
              size: 16,
            ),
            onPressed: canAdd ? onAdd : null,
          ),
        ],
      ),
    );
  }
}

class TopCard extends StatelessWidget {
  final Event event;
  final String eventImage;

  const TopCard({Key? key, required this.event, required this.eventImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: CachedNetworkImage(
              imageUrl: eventImage,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
              placeholder: (context, url) => Shimmer.fromColors(
                baseColor: Colors.grey[800]!,
                highlightColor: Colors.grey[700]!,
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              errorListener: (_) {},
              errorWidget: (context, url, error) => CachedNetworkImage(
                imageUrl: 'https://picsum.photos/200/300',
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.9),
                  ],
                  stops: const [0.3, 1.0],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.title,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(event.startDate.toIso8601String(),
                        style: GoogleFonts.inter(
                            color: Colors.white, fontSize: 12)),
                    const TimerWidget(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TimerWidget extends StatelessWidget {
  const TimerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: Stream.periodic(const Duration(seconds: 1), (i) => 15 * 60 - i)
          .take(15 * 60),
      builder: (context, snapshot) {
        final seconds = snapshot.data ?? 15 * 60;
        final minutes = seconds ~/ 60;
        final remainingSeconds = seconds % 60;

        Color timerColor;
        if (seconds > 10 * 60) {
          timerColor = Colors.green;
        } else if (seconds > 5 * 60) {
          timerColor = Colors.yellow;
        } else {
          timerColor = Colors.red;
        }

        return Row(
          children: [
            AnimatedFlipCounter(
              value: minutes,
              textStyle: GoogleFonts.inter(
                color: timerColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              ':',
              style: GoogleFonts.inter(
                color: timerColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            AnimatedFlipCounter(
              value: remainingSeconds,
              textStyle: GoogleFonts.inter(
                color: timerColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              wholeDigits: 2,
            ),
          ],
        );
      },
    );
  }
}

class NextButton extends StatelessWidget {
  final VoidCallback onPressed;

  const NextButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFF4E8D),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          'Next',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
