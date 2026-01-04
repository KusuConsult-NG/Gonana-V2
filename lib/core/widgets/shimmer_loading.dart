import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// Shimmer loading placeholders matching HTML skeleton states
class ShimmerLoading extends StatelessWidget {
  final double width;
  final double height;
  final BorderRadius? borderRadius;

  const ShimmerLoading({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius,
  });

  /// Circular shimmer (for avatars)
  factory ShimmerLoading.circular({required double size}) {
    return ShimmerLoading(
      width: size,
      height: size,
      borderRadius: BorderRadius.circular(size / 2),
    );
  }

  /// Rectangle shimmer (for cards, images)
  factory ShimmerLoading.rectangle({
    required double width,
    required double height,
    double borderRadius = 12,
  }) {
    return ShimmerLoading(
      width: width,
      height: height,
      borderRadius: BorderRadius.circular(borderRadius),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Shimmer.fromColors(
      baseColor: isDark ? const Color(0xff374151) : const Color(0xffe5e7eb),
      highlightColor: isDark
          ? const Color(0xff4b5563)
          : const Color(0xfff3f4f6),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: isDark ? const Color(0xff374151) : const Color(0xffe5e7eb),
          borderRadius: borderRadius,
        ),
      ),
    );
  }
}

/// Product card shimmer placeholder
class ProductCardShimmer extends StatelessWidget {
  const ProductCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? const Color(0xff1f2937)
            : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).brightness == Brightness.dark
              ? const Color(0xff374151)
              : const Color(0xffe5e7eb),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShimmerLoading.rectangle(
            width: double.infinity,
            height: 180,
            borderRadius: 12,
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerLoading.rectangle(
                  width: double.infinity,
                  height: 20,
                  borderRadius: 4,
                ),
                const SizedBox(height: 8),
                ShimmerLoading.rectangle(
                  width: 120,
                  height: 16,
                  borderRadius: 4,
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ShimmerLoading.rectangle(
                      width: 80,
                      height: 24,
                      borderRadius: 4,
                    ),
                    ShimmerLoading.rectangle(
                      width: 100,
                      height: 36,
                      borderRadius: 8,
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

/// Feed post shimmer placeholder
class FeedPostShimmer extends StatelessWidget {
  const FeedPostShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? const Color(0xff1f2937)
            : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).brightness == Brightness.dark
              ? const Color(0xff374151)
              : const Color(0xffe5e7eb),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ShimmerLoading.circular(size: 40),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerLoading.rectangle(
                      width: 150,
                      height: 16,
                      borderRadius: 4,
                    ),
                    const SizedBox(height: 6),
                    ShimmerLoading.rectangle(
                      width: 100,
                      height: 12,
                      borderRadius: 4,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ShimmerLoading.rectangle(
            width: double.infinity,
            height: 14,
            borderRadius: 4,
          ),
          const SizedBox(height: 8),
          ShimmerLoading.rectangle(
            width: double.infinity,
            height: 14,
            borderRadius: 4,
          ),
          const SizedBox(height: 8),
          ShimmerLoading.rectangle(width: 200, height: 14, borderRadius: 4),
          const SizedBox(height: 16),
          ShimmerLoading.rectangle(
            width: double.infinity,
            height: 200,
            borderRadius: 8,
          ),
        ],
      ),
    );
  }
}
