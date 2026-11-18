import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProductCardShimmer extends StatelessWidget {
  const ProductCardShimmer({super.key});

  Widget _buildPlaceholder({
    required double width,
    required double height,
    required Color color,
    double radius = 8,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final baseColor = isDark ? Colors.grey[850]! : Colors.grey[300]!;

    final highlightColor = isDark ? Colors.grey[750]! : Colors.grey[100]!;

    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: baseColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: baseColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Placeholder gambar produk.
            Expanded(
              flex: 5,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: baseColor,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Placeholder kategori.
            _buildPlaceholder(width: 55, height: 10, color: baseColor),

            const SizedBox(height: 8),

            // Placeholder nama produk.
            _buildPlaceholder(
              width: double.infinity,
              height: 13,
              color: baseColor,
            ),

            const SizedBox(height: 6),

            _buildPlaceholder(width: 85, height: 13, color: baseColor),

            const Spacer(),

            // Placeholder harga dan rating.
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildPlaceholder(width: 65, height: 14, color: baseColor),
                _buildPlaceholder(width: 35, height: 12, color: baseColor),
              ],
            ),

            const SizedBox(height: 10),

            // Placeholder tombol.
            _buildPlaceholder(
              width: double.infinity,
              height: 32,
              color: baseColor,
              radius: 8,
            ),
          ],
        ),
      ),
    );
  }
}

class ProductGridShimmer extends StatelessWidget {
  final int itemCount;

  const ProductGridShimmer({super.key, this.itemCount = 4});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.68,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemBuilder: (context, index) {
        return const ProductCardShimmer();
      },
    );
  }
}
