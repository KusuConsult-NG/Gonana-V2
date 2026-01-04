import 'dart:ui';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/utils/kyc_guard.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/injection.dart';
import '../../../../core/theme/app_theme.dart';
import '../bloc/market_bloc.dart';
import '../bloc/cart_bloc.dart';
import '../widgets/hot_deal_card.dart';
import '../widgets/product_card.dart';
import '../widgets/currency_converter_widget.dart';
import '../widgets/flash_deal_banner.dart';
import '../../../../core/widgets/scaffold_with_background.dart';
import '../../../../core/widgets/kyc_banner.dart';

class MarketPage extends StatelessWidget {
  const MarketPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<MarketBloc>()..add(const MarketEvent.loadData()),
      child: const _MarketView(),
    );
  }
}

class _MarketView extends StatelessWidget {
  const _MarketView();

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithBackground(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Market',
          style: GoogleFonts.montserrat(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.black.withValues(alpha: 0.2)
            : Colors.white.withValues(alpha: 0.1),
        flexibleSpace: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(color: Colors.transparent),
          ),
        ),
        elevation: 0,
        actions: [
          IconButton(
            icon: Stack(
              children: [
                Icon(
                  Icons.notifications_outlined,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black87,
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 8,
                      minHeight: 8,
                    ),
                  ),
                ),
              ],
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Stack(
              children: [
                Icon(
                  Icons.shopping_cart_outlined,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black87,
                ),
                BlocBuilder<CartBloc, CartState>(
                  builder: (context, state) {
                    if (state.items.isEmpty) return const SizedBox.shrink();
                    return Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 14,
                          minHeight: 14,
                        ),
                        child: Text(
                          '${state.items.length}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            onPressed: () => context.push('/cart'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          KycGuard.check(
            context,
            onVerified: () {
              context.push('/market/create');
            },
          );
        },
        backgroundColor: AppTheme.primaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: SafeArea(
        child: BlocBuilder<MarketBloc, MarketState>(
          builder: (context, state) {
            return state.when(
              initial: () => const SizedBox.shrink(),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (message) => Center(child: Text('Error: $message')),
              loaded: (products, hotDeals) {
                return CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const KycBanner(),
                            const SizedBox(height: 8),

                            // Flash Deal Banner
                            FlashDealBanner(
                              endTime: DateTime.now().add(
                                const Duration(hours: 6),
                              ),
                              onTap: () {
                                // TODO: Navigate to flash deals page
                              },
                            ),

                            const SizedBox(height: 16),
                            // Search Bar
                            FadeInDown(
                              duration: const Duration(milliseconds: 600),
                              child: Container(
                                decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? const Color(0xff1f2937)
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color:
                                        Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? const Color(0xff374151)
                                        : const Color(0xffe5e7eb),
                                  ),
                                ),
                                child: TextField(
                                  onChanged: (value) {
                                    context.read<MarketBloc>().add(
                                      MarketEvent.searchProducts(value),
                                    );
                                  },
                                  style: GoogleFonts.inter(
                                    color:
                                        Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : Colors.black87,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Search products...',
                                    hintStyle: GoogleFonts.inter(
                                      color:
                                          Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? const Color(0xff9ca3af)
                                          : const Color(0xff6b7280),
                                    ),
                                    prefixIcon: const Icon(
                                      Icons.search,
                                      color: Color(0xff22c55e),
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            // Category filters
                            FadeInDown(
                              delay: const Duration(milliseconds: 700),
                              child: SizedBox(
                                height: 40,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    const _CategoryChip(
                                      label: 'All',
                                      isSelected: true,
                                    ),
                                    const SizedBox(width: 8),
                                    const _CategoryChip(label: 'Vegetables'),
                                    const SizedBox(width: 8),
                                    const _CategoryChip(label: 'Fruits'),
                                    const SizedBox(width: 8),
                                    const _CategoryChip(label: 'Grains'),
                                    const SizedBox(width: 8),
                                    const _CategoryChip(label: 'Livestock'),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            // Realtime Currency Rate
                            FadeInDown(
                              duration: const Duration(milliseconds: 700),
                              child: const CurrencyConverterWidget(),
                            ),
                            const SizedBox(height: 20),

                            // Hot Deals Header
                            if (hotDeals.isNotEmpty) ...[
                              FadeInRight(
                                duration: const Duration(milliseconds: 600),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Hot Deals',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Colors.white
                                            : Colors.black87,
                                      ),
                                    ),
                                    const Icon(
                                      Icons.arrow_forward,
                                      color: AppTheme.primaryColor,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 12),

                              // Hot Deals List
                              FadeInRight(
                                delay: const Duration(milliseconds: 200),
                                duration: const Duration(milliseconds: 600),
                                child: SizedBox(
                                  height: 180,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: hotDeals.length,
                                    itemBuilder: (context, index) {
                                      return HotDealCard(
                                        product: hotDeals[index],
                                        onTap: () {
                                          context.push(
                                            '/market/details',
                                            extra: hotDeals[index],
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24),
                            ],

                            FadeInUp(
                              delay: const Duration(milliseconds: 300),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Buy Now',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.white
                                          : Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 12),
                          ],
                        ),
                      ),
                    ),

                    // Product Grid
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      sliver: SliverGrid(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.75,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                            ),
                        delegate: SliverChildBuilderDelegate((context, index) {
                          return FadeInUp(
                            delay: Duration(milliseconds: 100 * index),
                            child: GestureDetector(
                              onTap: () {
                                context.push(
                                  '/market/details',
                                  extra: products[index],
                                );
                              },
                              child: ProductCard(product: products[index]),
                            ),
                          );
                        }, childCount: products.length),
                      ),
                    ),
                    const SliverToBoxAdapter(child: SizedBox(height: 20)),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String label;
  final bool isSelected;

  const _CategoryChip({required this.label, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected
            ? const Color(0xff22c55e)
            : (isDark ? const Color(0xff1f2937) : Colors.white),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected
              ? const Color(0xff22c55e)
              : (isDark ? const Color(0xff374151) : const Color(0xffe5e7eb)),
        ),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: isSelected
              ? Colors.white
              : (isDark ? const Color(0xff9ca3af) : const Color(0xff6b7280)),
        ),
      ),
    );
  }
}
