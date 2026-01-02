import 'dart:ui';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/injection.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/glass_container.dart';
import '../bloc/market_bloc.dart';
import '../widgets/hot_deal_card.dart';
import '../widgets/product_card.dart';
import '../widgets/currency_converter_widget.dart';

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
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Market',
          style: GoogleFonts.montserrat(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white.withValues(alpha: 0.1),
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
                const Icon(Icons.notifications_outlined, color: Colors.black87),
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
                const Icon(Icons.shopping_cart_outlined, color: Colors.black87),
                // Badge could be added here using BlocBuilder<CartBloc...>
              ],
            ),
            onPressed: () => context.push('/cart'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/market/create-product'),
        backgroundColor: AppTheme.primaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Stack(
        children: [
          // Animated Background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: Theme.of(context).brightness == Brightness.dark
                    ? [
                        const Color(0xFF1E1E1E),
                        const Color(0xFF2C2C2C),
                        const Color(0xFF000000),
                      ]
                    : [
                        const Color(0xFFE0F7FA), // Light Cyan
                        const Color(0xFFE8F5E9), // Light Green
                        const Color(0xFFF3E5F5), // Light Purple
                      ],
              ),
            ),
          ),
          // Orbs
          Positioned(
            top: 50,
            left: -50,
            child: FadeIn(
              duration: const Duration(seconds: 2),
              child: Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  color: Colors.orangeAccent.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.orangeAccent.withValues(alpha: 0.15),
                      blurRadius: 80,
                      spreadRadius: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Content
          SafeArea(
            child: BlocBuilder<MarketBloc, MarketState>(
              builder: (context, state) {
                return state.when(
                  initial: () => const SizedBox.shrink(),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
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
                                // Search Bar in Glass
                                FadeInDown(
                                  duration: const Duration(milliseconds: 600),
                                  child: GlassContainer(
                                    opacity: 0.5,
                                    blur: 10,
                                    padding: EdgeInsets.zero,
                                    borderRadius: BorderRadius.circular(12),
                                    child: TextField(
                                      onChanged: (value) {
                                        context.read<MarketBloc>().add(
                                          MarketEvent.searchProducts(value),
                                        );
                                      },
                                      decoration: InputDecoration(
                                        hintText: 'Search products...',
                                        hintStyle: GoogleFonts.montserrat(
                                          color: Colors.grey,
                                        ),
                                        prefixIcon: const Icon(
                                          Icons.search,
                                          color: Colors.grey,
                                        ),
                                        border: InputBorder.none,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                              horizontal: 16,
                                              vertical: 14,
                                            ),
                                      ),
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
                                                '/payment',
                                                extra: {
                                                  'name': hotDeals[index].title,
                                                  'price':
                                                      hotDeals[index].amount,
                                                  'currency': 'NGN',
                                                },
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
                            delegate: SliverChildBuilderDelegate((
                              context,
                              index,
                            ) {
                              return FadeInUp(
                                delay: Duration(milliseconds: 100 * index),
                                child: GestureDetector(
                                  onTap: () {
                                    context.push(
                                      '/payment',
                                      extra: {
                                        'name': products[index].title,
                                        'price': products[index].amount,
                                        'currency': 'NGN',
                                      },
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
        ],
      ),
    );
  }
}
