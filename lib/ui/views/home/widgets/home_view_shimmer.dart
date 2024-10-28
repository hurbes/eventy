import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerUpcomingEventsSection extends StatelessWidget {
  const ShimmerUpcomingEventsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ShimmerSectionHeader(),
        const SizedBox(height: 16),
        SizedBox(
          height: 230,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 2,
            itemBuilder: (context, index) {
              return const Padding(
                padding: EdgeInsets.only(right: 16),
                child: Column(
                  children: [
                    ShimmerUpcomingEventCard(),
                    SizedBox(height: 16),
                    ShimmerUpcomingEventCard(),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class ShimmerUpcomingEventCard extends StatelessWidget {
  const ShimmerUpcomingEventCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[800]!,
      highlightColor: Colors.grey[700]!,
      child: Container(
        width: 350,
        height: 107,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}

class ShimmerPopularNowSection extends StatelessWidget {
  const ShimmerPopularNowSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ShimmerSectionHeader(),
        const SizedBox(height: 16),
        Shimmer.fromColors(
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
      ],
    );
  }
}

class ShimmerRecommendationsSection extends StatelessWidget {
  const ShimmerRecommendationsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ShimmerSectionHeader(),
        const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 4,
          itemBuilder: (context, index) {
            return const Padding(
              padding: EdgeInsets.only(bottom: 12),
              child: ShimmerRecommendationCard(),
            );
          },
        ),
      ],
    );
  }
}

class ShimmerRecommendationCard extends StatelessWidget {
  const ShimmerRecommendationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[800]!,
      highlightColor: Colors.grey[700]!,
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}

class ShimmerSectionHeader extends StatelessWidget {
  const ShimmerSectionHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[800]!,
      highlightColor: Colors.grey[700]!,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 150,
            height: 24,
            color: Colors.white,
          ),
          Container(
            width: 60,
            height: 24,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
