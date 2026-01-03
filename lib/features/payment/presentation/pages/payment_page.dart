import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../../../core/widgets/primary_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_state.dart';
import '../../../market/domain/entities/product_entity.dart';
import '../../../market/domain/entities/order_entity.dart';
import '../../../market/presentation/bloc/order_bloc.dart';
import '../../../market/presentation/bloc/order_event.dart';

class PaymentPage extends StatefulWidget {
  final ProductEntity? product; // Product details passed from Market

  const PaymentPage({super.key, this.product});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedFiatMethod = 'Card'; // Card, Wallet
  String _selectedCryptoMethod = 'Internal'; // Internal, External

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final fallbackProduct = {
      'name': 'Premium Rice',
      'price': 45000.0,
      'currency': 'NGN',
    };

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Checkout',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black87,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black87,
          ),
          onPressed: () => context.pop(),
        ),
      ),
      body: Stack(
        children: [
          // Background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: Theme.of(context).brightness == Brightness.dark
                    ? [const Color(0xFF1E1E1E), const Color(0xFF000000)]
                    : [const Color(0xFFE0F7FA), const Color(0xFFE8F5E9)],
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 16),
                // Order Summary Card
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: GlassContainer(
                    borderRadius: BorderRadius.circular(16),
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Product',
                              style: GoogleFonts.montserrat(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              product?.title ??
                                  fallbackProduct['name'] as String,
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Total',
                              style: GoogleFonts.montserrat(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              '₦ ${(product?.amount ?? (fallbackProduct['price'] as double)).toStringAsFixed(2)}',
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: AppTheme.primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Shipping Method Selection
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: GlassContainer(
                    borderRadius: BorderRadius.circular(16),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: 'Logistics Company', // Default
                        isExpanded: true,
                        dropdownColor:
                            Theme.of(context).brightness == Brightness.dark
                            ? const Color(0xFF2C2C2C)
                            : Colors.white,
                        items:
                            [
                                  'Logistics Company',
                                  'Farmer Shipping',
                                  'Pickup Station',
                                ]
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(
                                      e,
                                      style: GoogleFonts.montserrat(),
                                    ),
                                  ),
                                )
                                .toList(),
                        onChanged: (val) {},
                        hint: Text(
                          'Select Shipping Method',
                          style: GoogleFonts.montserrat(),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Tabs
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TabBar(
                      controller: _tabController,
                      indicator: BoxDecoration(
                        color: AppTheme.primaryColor,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.grey[700],
                      labelStyle: GoogleFonts.montserrat(
                        fontWeight: FontWeight.bold,
                      ),
                      tabs: const [
                        Tab(text: 'Fiat Payment'),
                        Tab(text: 'Crypto Payment'),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Tab Content
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildFiatTab(context),
                      _buildCryptoTab(context),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFiatTab(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          // Payment Method Selection
          Row(
            children: [
              Expanded(
                child: _PaymentMethodCard(
                  title: 'Credit Card',
                  icon: Icons.credit_card,
                  isSelected: _selectedFiatMethod == 'Card',
                  onTap: () => setState(() => _selectedFiatMethod = 'Card'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _PaymentMethodCard(
                  title: 'App Wallet',
                  icon: Icons.account_balance_wallet,
                  isSelected: _selectedFiatMethod == 'Wallet',
                  onTap: () => setState(() => _selectedFiatMethod = 'Wallet'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          if (_selectedFiatMethod == 'Card') ...[
            GlassContainer(
              borderRadius: BorderRadius.circular(16),
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Card Number',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.credit_card),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Expiry Date',
                            hintText: 'MM/YY',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'CVV',
                            border: OutlineInputBorder(),
                          ),
                          obscureText: true,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ] else ...[
            GlassContainer(
              borderRadius: BorderRadius.circular(16),
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Wallet Balance', style: GoogleFonts.montserrat()),
                      Text(
                        '₦ 2,500,000.00',
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 24),
                  const Text('Sufficient balance for this transaction.'),
                ],
              ),
            ),
          ],

          const SizedBox(height: 32),
          PrimaryButton(
            text: 'Pay Now',
            onPressed: () {
              _createOrder(context);
              context.push(
                '/enter-pin',
                extra: {
                  'isTransaction': true,
                  'onSuccess': () {
                    // Handle success (pop or navigate to success page)
                    // For now, let's just pop back to Home or show success
                    context.go('/home');
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Payment Successful!')),
                    );
                  },
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCryptoTab(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          // Payment Method Selection
          Row(
            children: [
              Expanded(
                child: _PaymentMethodCard(
                  title: 'Crypto Wallet',
                  icon: Icons.token,
                  isSelected: _selectedCryptoMethod == 'Internal',
                  onTap: () =>
                      setState(() => _selectedCryptoMethod = 'Internal'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _PaymentMethodCard(
                  title: 'External Pay',
                  icon: Icons.qr_code,
                  isSelected: _selectedCryptoMethod == 'External',
                  onTap: () =>
                      setState(() => _selectedCryptoMethod = 'External'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          if (_selectedCryptoMethod == 'Internal') ...[
            GlassContainer(
              borderRadius: BorderRadius.circular(16),
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  RadioListTile<bool>(
                    value: true,
                    // ignore: deprecated_member_use
                    groupValue: true,
                    onChanged: (v) {},
                    secondary: const CircleAvatar(
                      backgroundColor: Colors.orange,
                      child: Text('U', style: TextStyle(color: Colors.white)),
                    ),
                    title: const Text('USDT'),
                    subtitle: const Text('Balance: 5,430.00 USDT'),
                  ),
                  const Divider(),
                  RadioListTile<bool>(
                    value: false,
                    // ignore: deprecated_member_use
                    groupValue: true,
                    onChanged: (v) {},
                    secondary: const CircleAvatar(
                      backgroundColor: Colors.purple,
                      child: Text('C', style: TextStyle(color: Colors.white)),
                    ),
                    title: const Text('Concordium'),
                    subtitle: const Text('Balance: 12,000.00 CCD'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            PrimaryButton(
              text: 'Confirm Crypto Payment',
              onPressed: () {
                _createOrder(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Crypto Payment Processing... Success!'),
                  ),
                );
                context.go('/home');
              },
            ),
          ] else ...[
            GlassContainer(
              borderRadius: BorderRadius.circular(16),
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const Text('Scan to Pay'),
                  const SizedBox(height: 16),
                  QrImageView(
                    data: '0x71C7656EC7ab88b098defB751B7401B5f6d8976F',
                    version: QrVersions.auto,
                    size: 200.0,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '0x71C7656EC7ab88b098defB751B7401B5f6d8976F',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inconsolata(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            PrimaryButton(
              text: 'I have made the transfer',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Verifying transaction... Confirmed!'),
                  ),
                );
                context.go('/home');
              },
            ),
          ],
        ],
      ),
    );
  }

  void _createOrder(BuildContext context) {
    final product = widget.product;
    if (product == null) return;

    final authState = context.read<AuthBloc>().state;
    final userId = authState.maybeWhen(
      authenticated: (auth) => auth.user.id,
      orElse: () => null,
    );

    if (userId == null) return;

    final order = OrderEntity(
      id: const Uuid().v4(),
      buyerId: userId,
      sellerId: product.sellerId ?? 'unknown_seller',
      sellerName: product.sellerName ?? 'Unknown Seller',
      productName: product.title,
      productImageUrl: product.imageUrl,
      totalPrice: product.amount,
      status: OrderStatus.pending,
      date: DateTime.now(),
      logisticsCompany: 'Standard Shipping',
    );

    context.read<OrderBloc>().add(OrderEvent.createOrder(order));
  }
}

class _PaymentMethodCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _PaymentMethodCard({
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected
              ? AppTheme.primaryColor
              : Colors.white.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? Colors.transparent : Colors.white,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppTheme.primaryColor.withValues(alpha: 0.4),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ]
              : [],
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : Colors.grey[700],
              size: 32,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: GoogleFonts.montserrat(
                color: isSelected ? Colors.white : Colors.grey[700],
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
