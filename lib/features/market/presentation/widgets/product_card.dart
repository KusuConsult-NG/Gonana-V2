import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../config/injection.dart';
import '../../../../core/services/currency_service.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../domain/entities/product_entity.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/cart_bloc.dart';

class ProductCard extends StatelessWidget {
  final ProductEntity product;
  final VoidCallback? onTap;

  const ProductCard({super.key, required this.product, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: GlassContainer(
        padding: EdgeInsets.zero, // Padding is internal
        opacity: 0.6,
        blur: 15,
        borderRadius: BorderRadius.circular(16),
        // decoration removed as GlassContainer handles it
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                    child: Image.network(
                      product.imageUrl,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Center(child: Icon(Icons.image_not_supported)),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if ((product.discountPercentage ?? 0) > 0)
                          Container(
                            margin: const EdgeInsets.only(bottom: 4),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xffef4444),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '-${product.discountPercentage!.toInt()}%',
                              style: GoogleFonts.inter(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        if (product.isHotDeal)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xfff59e0b),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.local_fire_department,
                                  size: 12,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 2),
                                Text(
                                  'HOT',
                                  style: GoogleFonts.inter(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 8,
                    bottom: 8,
                    child: GestureDetector(
                      onTap: () {
                        context.read<CartBloc>().add(AddToCart(product));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${product.title} added to cart'),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryColor,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.primaryColor.withValues(alpha: 0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.add_shopping_cart,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : const Color(0xff1f2937),
                      height: 1.2,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),

                  // Dual Currency Display
                  StreamBuilder<double>(
                    stream: getIt<CurrencyService>().rateStream,
                    initialData: getIt<CurrencyService>().currentRate,
                    builder: (context, snapshot) {
                      final rate = snapshot.data ?? 1500.0;
                      final usdPrice = product.amount / rate;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text(
                                '₦${product.amount.toStringAsFixed(0)}',
                                style: GoogleFonts.inter(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.primaryColor,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '\$${usdPrice.toStringAsFixed(2)}',
                                style: GoogleFonts.inter(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                  color:
                                      Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.grey[400]
                                      : Colors.grey[500],
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),

                  // Stock Progress Section
                  if (product.initialStock != null &&
                      product.soldCount != null) ...[
                    const SizedBox(height: 8),
                    Container(
                      height: 4,
                      decoration: BoxDecoration(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.grey[800]
                            : Colors.grey[200],
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: product.soldCount!,
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(
                                  0xffef4444,
                                ), // Red for urgency
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: (product.initialStock! - product.soldCount!)
                                .clamp(0, product.initialStock!),
                            child: const SizedBox(),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Sold: ${product.soldCount}/${product.initialStock}',
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.grey[400]
                            : Colors.grey[500],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
