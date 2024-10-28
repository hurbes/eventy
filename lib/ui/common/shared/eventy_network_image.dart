import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:eventy/ui/common/app_colors.dart';

class EventyNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final String? fallbackImageUrl;
  final Widget? errorWidget;
  final Widget Function(BuildContext, String)? placeholderBuilder;
  final bool useShimmer;
  final Color? shimmerBaseColor;
  final Color? shimmerHighlightColor;
  final Duration shimmerDuration;
  final void Function(Object)? onError;

  const EventyNetworkImage({
    Key? key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.fallbackImageUrl = 'https://picsum.photos/800/400?grayscale',
    this.errorWidget,
    this.placeholderBuilder,
    this.useShimmer = true,
    this.shimmerBaseColor,
    this.shimmerHighlightColor,
    this.shimmerDuration = const Duration(milliseconds: 1500),
    this.onError,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget imageWidget = CachedNetworkImage(
      imageUrl: imageUrl,
      fit: fit,
      width: width,
      height: height,
      errorWidget: (context, url, error) {
        if (errorWidget != null) return errorWidget!;
        return CachedNetworkImage(
          imageUrl: fallbackImageUrl!,
          fit: fit,
          width: width,
          height: height,
          errorListener: onError ?? (context) {},
        );
      },
      errorListener: onError ?? (context) {},
      placeholder: (context, url) {
        if (placeholderBuilder != null) {
          return placeholderBuilder!(context, url);
        }

        Widget placeholderWidget = Container(
          width: width,
          height: height,
          color: shimmerBaseColor ?? ShimmerColors.baseColor,
        );

        if (!useShimmer) return placeholderWidget;

        return Shimmer.fromColors(
          baseColor: shimmerBaseColor ?? ShimmerColors.baseColor,
          highlightColor: shimmerHighlightColor ?? ShimmerColors.highlightColor,
          period: shimmerDuration,
          child: placeholderWidget,
        );
      },
    );

    if (borderRadius != null) {
      imageWidget = ClipRRect(
        borderRadius: borderRadius!,
        child: imageWidget,
      );
    }

    return imageWidget;
  }
}
