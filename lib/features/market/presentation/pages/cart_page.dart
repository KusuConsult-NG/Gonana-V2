import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/widgets/empty_state.dart';
import '../bloc/cart_bloc.dart';
import '../widgets/logistics_selection_widget.dart';
import '../../../../core/utils/kyc_guard.dart';
import '../../domain/entities/product_entity.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xff111827)
          : const Color(0xfff3f4f6),
      appBar: AppBar(
        title: Text(
          'Shopping Cart',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w700,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        backgroundColor: isDark ? const Color(0xff1f2937) : Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDark ? Colors.white : Colors.black87,
          ),
          onPressed: () => context.pop(),
        ),
        actions: [
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              if (state.items.isEmpty) return const SizedBox.shrink();
              return TextButton.icon(
                onPressed: () {
                  context.read<CartBloc>().add(ClearCart());
                },
                icon: const Icon(
                  Icons.delete_sweep,
                  color: Colors.red,
                  size: 20,
                ),
                label: Text(
                  'Clear',
                  style: GoogleFonts.inter(
                    color: Colors.red,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state.items.isEmpty) {
            return EmptyState(
              icon: Icons.shopping_cart_outlined,
              title: 'Your cart is empty',
              message: 'Add some products to your cart to get started!',
              actionLabel: 'Browse Products',
              onActionPressed: () => context.go('/market'),
            );
          }

          return Column(
            children: [
              // Cart items list
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: state.items.length,
                  itemBuilder: (context, index) {
                    final item = state.items[index];
                    return FadeInUp(
                      delay: Duration(milliseconds: 50 * index),
                      child: _CartItemCard(
                        item: item,
                        onRemove: () {
                          context.read<CartBloc>().add(RemoveFromCart(item));
                        },
                      ),
                    );
                  },
                ),
              ),

              // Bottom checkout section
              Container(
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xff1f2937) : Colors.white,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(24),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 20,
                      offset: const Offset(0, -5),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(24),
                child: SafeArea(
                  top: false,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const LogisticsSelectionWidget(),
                      const SizedBox(height: 16),

                      // Fee breakdown section
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              color: isDark
                                  ? const Color(0xff374151)
                                  : const Color(0xffe5e7eb),
                            ),
                          ),
                        ),
                        child: Column(
                          children: [
                            // Subtotal
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Subtotal (${state.items.length} items)',
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    color: isDark
                                        ? const Color(0xff9ca3af)
                                        : const Color(0xff6b7280),
                                  ),
                                ),
                                Text(
                                  '₦${state.totalAmount.toStringAsFixed(2)}',
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: isDark
                                        ? Colors.white
                                        : Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),

                            // Shipping Estimate
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Shipping Estimate',
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    color: isDark
                                        ? const Color(0xff9ca3af)
                                        : const Color(0xff6b7280),
                                  ),
                                ),
                                Text(
                                  state.selectedLogistics != null
                                      ? '₦${state.selectedLogistics!.price.toStringAsFixed(2)}'
                                      : '₦0.00',
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: isDark
                                        ? Colors.white
                                        : Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),

                            // Service Fee
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Service Fee (1.5%)',
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    color: isDark
                                        ? const Color(0xff9ca3af)
                                        : const Color(0xff6b7280),
                                  ),
                                ),
                                Text(
                                  '₦${(state.totalAmount * 0.015).toStringAsFixed(2)}',
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: isDark
                                        ? Colors.white
                                        : Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Total with USD conversion
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              color: isDark
                                  ? const Color(0xff374151)
                                  : const Color(0xffe5e7eb),
                            ),
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total',
                                  style: GoogleFonts.inter(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: isDark
                                        ? Colors.white
                                        : Colors.black87,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '₦${_calculateGrandTotal(state).toStringAsFixed(2)}',
                                      style: GoogleFonts.inter(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xff22c55e),
                                      ),
                                    ),
                                    Text(
                                      'Approx. \$${(_calculateGrandTotal(state) / 1600).toStringAsFixed(2)} USD',
                                      style: GoogleFonts.inter(
                                        fontSize: 12,
                                        color: isDark
                                            ? const Color(0xff9ca3af)
                                            : const Color(0xff6b7280),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Checkout button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            KycGuard.check(
                              context,
                              onVerified: () {
                                if (state.items.isNotEmpty) {
                                  final firstItem = state.items.first;
                                  final checkoutProduct = ProductEntity(
                                    id: 'cart_checkout',
                                    title:
                                        'Cart Checkout (${state.items.length} items)',
                                    amount: state.totalAmount,
                                    images: [firstItem.imageUrl],
                                    description: 'Marketplace Checkout',
                                    sellerId: firstItem.sellerId,
                                    sellerName: firstItem.sellerName,
                                  );
                                  context.push(
                                    '/payment',
                                    extra: checkoutProduct,
                                  );
                                }
                              },
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            backgroundColor: const Color(0xff22c55e),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Proceed to Checkout',
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // Helper method to calculate grand total including all fees
  double _calculateGrandTotal(CartState state) {
    final subtotal = state.totalAmount;
    final shipping = state.selectedLogistics?.price ?? 0.0;
    final serviceFee = subtotal * 0.015; // 1.5%
    return subtotal + shipping + serviceFee;
  }
}

class _CartItemCard extends StatelessWidget {
  final ProductEntity item;
  final VoidCallback onRemove;

  const _CartItemCard({required this.item, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final quantity = item.quantity ?? 1;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xff1f2937) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? const Color(0xff374151) : const Color(0xffe5e7eb),
        ),
      ),
      child: Row(
        children: [
          // Product image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CachedNetworkImage(
              imageUrl: item.imageUrl,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                width: 80,
                height: 80,
                color: isDark ? Colors.grey[800] : Colors.grey[200],
                child: const Center(child: CircularProgressIndicator()),
              ),
              errorWidget: (context, url, error) => Container(
                width: 80,
                height: 80,
                color: isDark ? Colors.grey[800] : Colors.grey[200],
                child: const Icon(Icons.broken_image, size: 40),
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Product details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  'NGN ${item.amount.toStringAsFixed(2)}',
                  style: GoogleFonts.inter(
                    color: const Color(0xff22c55e),
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),

                // Quantity controls
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: isDark
                            ? const Color(0xff374151)
                            : const Color(0xfff3f4f6),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isDark
                              ? const Color(0xff4b5563)
                              : const Color(0xffd1d5db),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove, size: 18),
                            padding: const EdgeInsets.all(8),
                            constraints: const BoxConstraints(
                              minWidth: 36,
                              minHeight: 36,
                            ),
                            onPressed: quantity > 1
                                ? () {
                                    context.read<CartBloc>().add(
                                      UpdateCartItemQuantity(
                                        item,
                                        quantity - 1,
                                      ),
                                    );
                                  }
                                : null,
                            color: isDark ? Colors.white70 : Colors.black87,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              '$quantity',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: isDark ? Colors.white : Colors.black87,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add, size: 18),
                            padding: const EdgeInsets.all(8),
                            constraints: const BoxConstraints(
                              minWidth: 36,
                              minHeight: 36,
                            ),
                            onPressed: () {
                              context.read<CartBloc>().add(
                                UpdateCartItemQuantity(item, quantity + 1),
                              );
                            },
                            color: isDark ? Colors.white70 : Colors.black87,
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    // Delete button
                    IconButton(
                      icon: const Icon(
                        Icons.delete_outline,
                        color: Colors.red,
                        size: 20,
                      ),
                      onPressed: onRemove,
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

  // Helper method to calculate grand total including all fees
}
