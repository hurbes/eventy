import 'package:eventy/core/models/event/event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_octicons/flutter_octicons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'home_viewmodel.dart';
import 'home_view_shimmer.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: const Color(0xff22141a),
      body: SafeArea(
        child: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (scrollInfo.metrics.pixels ==
                scrollInfo.metrics.maxScrollExtent) {
              if (!viewModel.isBusy && viewModel.hasMoreRecommendations) {
                viewModel.loadMoreRecommendations();
              }
            }
            return true;
          },
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    const SizedBox(height: 16),
                    const HeaderSection(),
                    const SizedBox(height: 16),
                    const SearchBar(),
                    const SizedBox(height: 20),
                    const CategorySection(),
                    const SizedBox(height: 24),
                    viewModel.isBusy
                        ? const ShimmerUpcomingEventsSection()
                        : const UpcomingEventsSection(),
                    const SizedBox(height: 24),
                    viewModel.isBusy
                        ? const ShimmerPopularNowSection()
                        : const PopularNowSection(),
                    const SizedBox(height: 24),
                    const SectionHeader(title: 'Recommendations for you'),
                    const SizedBox(height: 16),
                  ]),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                sliver: viewModel.isBusy
                    ? const SliverToBoxAdapter(
                        child: ShimmerRecommendationsSection())
                    : SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            if (index < viewModel.recommendedEvents.length) {
                              final event = viewModel.recommendedEvents[index];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: RecommendationCard(event: event),
                              );
                            } else if (viewModel.hasMoreRecommendations) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                child: Center(
                                  child: viewModel.isBusy
                                      ? const CircularProgressIndicator()
                                      : const SizedBox.shrink(),
                                ),
                              );
                            } else {
                              return const SizedBox.shrink();
                            }
                          },
                          childCount: viewModel.recommendedEvents.length +
                              (viewModel.hasMoreRecommendations ? 1 : 0),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();
}

class HeaderSection extends StatelessWidget {
  const HeaderSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Location',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 6, right: 4),
                  child: Icon(
                    OctIcons.location_16,
                    color: Color(0xFFFF4E8D),
                    size: 20,
                  ),
                ),
                Text(
                  'Ahmedabad, Gujarat',
                  style: GoogleFonts.inter(
                    color: Colors.grey[400],
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ],
        ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(OctIcons.bell_16, color: Colors.white, size: 20),
        ),
      ],
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(OctIcons.search_16, color: Colors.grey, size: 18),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Search',
              style: GoogleFonts.inter(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
          ),
          const Icon(OctIcons.sliders_16, color: Colors.grey, size: 18),
        ],
      ),
    );
  }
}

class CategorySection extends ViewModelWidget<HomeViewModel> {
  const CategorySection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    final categories = [
      {'icon': '✨', 'label': 'Upcoming'},
      {'icon': '⏲︎', 'label': 'Past Events'},
    ];

    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return CategoryItem(
            icon: categories[index]['icon'] as String,
            label: categories[index]['label'] as String,
            isSelected: viewModel.currentIndex == index,
            onTap: () => viewModel.setIndex(index),
          );
        },
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final String icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryItem({
    Key? key,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 350),
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFFFF4E8D).withOpacity(0.7)
              : Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(icon, style: const TextStyle(fontSize: 16)),
            const SizedBox(width: 8),
            Text(
              label,
              style: GoogleFonts.inter(
                color: isSelected ? Colors.white : Colors.grey,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UpcomingEventsSection extends ViewModelWidget<HomeViewModel> {
  const UpcomingEventsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return Column(
      children: [
        const SectionHeader(title: 'Upcoming Events'),
        const SizedBox(height: 16),
        SizedBox(
          height: 240,
          child: GridView.builder(
            scrollDirection: Axis.horizontal,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Two items per column
              childAspectRatio: .3, // Aspect ratio for square items
              crossAxisSpacing: 16,
            ),
            itemCount: viewModel.upcomingEvents.length,
            itemBuilder: (context, index) {
              final event = viewModel.upcomingEvents[index];
              return Padding(
                padding: const EdgeInsets.only(right: 16),
                child: UpcomingEventCard(event: event),
              );
            },
          ),
        ),
      ],
    );
  }
}

class UpcomingEventCard extends StatelessWidget {
  final Event event;

  const UpcomingEventCard({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CachedNetworkImage(
              imageUrl: 'https://picsum.photos/200/300',
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              placeholder: (context, url) => const ShimmerUpcomingEventCard(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  event.title,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(OctIcons.location_16,
                            size: 16, color: Colors.grey),
                        const SizedBox(width: 4),
                        SizedBox(
                          width: 150,
                          child: Text(
                            event.settings.target?.locationDetails.target
                                    ?.venueName ??
                                '',
                            maxLines: 1,
                            overflow: TextOverflow.visible,
                            style: GoogleFonts.inter(
                                color: Colors.grey, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF4E8D),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Join',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
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

class PopularNowSection extends ViewModelWidget<HomeViewModel> {
  const PopularNowSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    final popularEvent = viewModel.popularEvent;
    if (popularEvent == null) return const SizedBox.shrink();

    return Column(
      children: [
        const SectionHeader(title: 'Popular Now'),
        const SizedBox(height: 16),
        PopularNowCard(event: popularEvent),
      ],
    );
  }
}

class PopularNowCard extends StatelessWidget {
  final Event event;

  const PopularNowCard({Key? key, required this.event}) : super(key: key);

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
              imageUrl: 'https://picsum.photos/200/300',
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
              placeholder: (context, url) => const ShimmerPopularNowSection(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
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
            top: 16,
            left: 16,
            child: CategoryChip(label: 'Music'),
          ),
          const Positioned(
            right: 16,
            top: 16,
            child: FavoriteButton(),
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
                Text(
                  event.startDate.toIso8601String(),
                  style: GoogleFonts.inter(color: Colors.white, fontSize: 12),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const AvatarStack(),
                    Container(
                      margin: const EdgeInsets.only(left: 8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF4E8D),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '+40',
                        style: GoogleFonts.inter(
                            color: Colors.white, fontSize: 12),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '\$${event.currency}',
                      style: GoogleFonts.inter(
                        color: const Color(0xFFFF4E8D),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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

class CategoryChip extends StatelessWidget {
  final String label;

  const CategoryChip({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(label, style: GoogleFonts.inter(fontWeight: FontWeight.bold)),
    );
  }
}

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
        shape: BoxShape.circle,
      ),
      child: const Icon(OctIcons.heart_16, color: Colors.white, size: 16),
    );
  }
}

class AvatarStack extends StatelessWidget {
  const AvatarStack({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 96,
      height: 24,
      child: Stack(
        children: List.generate(4, (index) {
          return Positioned(
            left: index * 18.0,
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: ClipOval(
                child: Image.network(
                  'https://picsum.photos/seed/face$index/100/100',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            'See All',
            style: GoogleFonts.inter(color: const Color(0xFFFF4E8D)),
          ),
        ),
      ],
    );
  }
}

class RecommendationCard extends StatelessWidget {
  final Event event;

  const RecommendationCard({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white.withOpacity(0.05),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: 'https://picsum.photos/200/300',
                width: 84,
                height: 84,
                fit: BoxFit.cover,
                placeholder: (context, url) => ShimmerRecommendationCard(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    event.title,
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      const Icon(OctIcons.location_16,
                          size: 16, color: Colors.grey),
                      const SizedBox(width: 4),
                      SizedBox(
                        width: 150,
                        child: Text(
                          event.settings.target?.locationDetails.target
                                  ?.venueName ??
                              '',
                          maxLines: 1,
                          overflow: TextOverflow.visible,
                          style: GoogleFonts.inter(
                              color: Colors.grey, fontSize: 14),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF4E8D).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '\$${10}',
                          style: GoogleFonts.inter(
                            color: const Color(0xFFFF4E8D),
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        canvasColor: const Color(0xff22141a),
      ),
      child: BottomNavigationBar(
        iconSize: 32,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFFFF4E8D),
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(OctIcons.home_16),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(OctIcons.calendar_16),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(OctIcons.heart_16),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(OctIcons.location_16),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(OctIcons.person_16),
            label: '',
          ),
        ],
      ),
    );
  }
}
