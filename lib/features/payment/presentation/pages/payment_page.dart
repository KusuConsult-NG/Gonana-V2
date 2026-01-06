import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../../../core/widgets/primary_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_state.dart';
import '../../../market/domain/entities/order_entity.dart';
import '../../../market/domain/entities/product_entity.dart';
import '../../../market/presentation/bloc/order_bloc.dart';
import '../../../market/presentation/bloc/order_event.dart';
import '../../../wallet/presentation/bloc/wallet_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../../market/domain/repositories/market_repository.dart';
import '../../presentation/bloc/payment_bloc.dart';
import '../../../../config/injection.dart';

class PaymentPage extends StatefulWidget {
  final ProductEntity? product;

  const PaymentPage({super.key, this.product});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String _selectedFiatMethod = 'Card';
  String _selectedLogistics = 'Standard Shipping';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    // Load wallet data to ensure balance is up to date
    context.read<WalletBloc>().add(const WalletEvent.loadWalletData());
  }

  @override
  void dispose() {
    _tabController.dispose();
    _addressController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final product = widget.product;
    final fallbackProduct = {
      'name': 'Premium Rice',
      'price': 45000.0,
      'currency': 'NGN',
    };
    final amount = product?.amount ?? (fallbackProduct['price'] as double);

    return BlocProvider(
      create: (context) => getIt<PaymentBloc>(),
      child: BlocListener<PaymentBloc, PaymentState>(
        listener: (context, state) {
          state.maybeWhen(
            success: (message) {
              _createOrder(context, status: OrderStatus.paid);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Payment Successful: $message'),
                  backgroundColor: Colors.green,
                ),
              );
              context.go('/home');
            },
            error: (message) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Payment Failed: $message'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            orElse: () {},
          );
        },
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            title: Text(
              'Checkout',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: isDark ? Colors.white : Colors.black87,
              ),
              onPressed: () => context.pop(),
            ),
          ),
          body: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: isDark
                        ? [const Color(0xFF1E1E1E), const Color(0xFF000000)]
                        : [const Color(0xFFE0F7FA), const Color(0xFFE8F5E9)],
                  ),
                ),
              ),
              SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 16),
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
                                    style: GoogleFonts.inter(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    product?.title ??
                                        fallbackProduct['name'] as String,
                                    style: GoogleFonts.inter(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    'Total',
                                    style: GoogleFonts.inter(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    '₦ ${amount.toStringAsFixed(2)}',
                                    style: GoogleFonts.inter(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: AppTheme.primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Shipping Method Dropdown
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 16),
                            Text(
                              'Shipping Method',
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w600,
                                color: isDark ? Colors.white : Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 8),
                            GlassContainer(
                              borderRadius: BorderRadius.circular(12),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: _selectedLogistics,
                                  isExpanded: true,
                                  dropdownColor: isDark
                                      ? const Color(0xFF1E1E1E)
                                      : Colors.white,
                                  icon: Icon(
                                    Icons.local_shipping_outlined,
                                    color: isDark
                                        ? Colors.white70
                                        : Colors.black54,
                                  ),
                                  style: GoogleFonts.inter(
                                    color: isDark
                                        ? Colors.white
                                        : Colors.black87,
                                    fontSize: 14,
                                  ),
                                  items:
                                      [
                                        'Standard Shipping',
                                        'Farmers Shipment',
                                      ].map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                  onChanged: (String? newValue) {
                                    if (newValue != null) {
                                      setState(() {
                                        _selectedLogistics = newValue;
                                      });
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Shipping Address Inputs
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Shipping Details',
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w600,
                                color: isDark ? Colors.white : Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 8),
                            _buildTextField(
                              context,
                              _nameController,
                              'Recipient Name',
                              Icons.person_outline,
                            ),
                            const SizedBox(height: 8),
                            _buildTextField(
                              context,
                              _phoneController,
                              'Phone Number',
                              Icons.phone_outlined,
                            ),
                            const SizedBox(height: 8),
                            _buildTextField(
                              context,
                              _addressController,
                              'Delivery Address',
                              Icons.location_on_outlined,
                            ),
                          ],
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
                            tabs: const [
                              Tab(text: 'Paystack'),
                              Tab(text: 'Crypto'),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        height: 400, // Fixed height for TabView
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            _buildFiatTab(context, amount),
                            _buildCryptoTab(context, amount),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    BuildContext context,
    TextEditingController controller,
    String hint,
    IconData icon,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GlassContainer(
      borderRadius: BorderRadius.circular(12),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        controller: controller,
        style: GoogleFonts.inter(color: isDark ? Colors.white : Colors.black87),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: GoogleFonts.inter(
            color: isDark ? Colors.white54 : Colors.black38,
          ),
          icon: Icon(icon, color: isDark ? Colors.white70 : Colors.black54),
        ),
      ),
    );
  }

  Widget _buildFiatTab(BuildContext context, double amount) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _PaymentMethodCard(
                  title: 'Paystack',
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
          if (_selectedFiatMethod == 'Card')
            GlassContainer(
              borderRadius: BorderRadius.circular(16),
              padding: const EdgeInsets.all(24),
              child: const Center(
                child: Text(
                  'Secured by Paystack',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            )
          else
            GlassContainer(
              borderRadius: BorderRadius.circular(16),
              padding: const EdgeInsets.all(24),
              child: const Text('Insufficient Wallet Balance (Demo)'),
            ),
          const SizedBox(height: 32),
          BlocBuilder<PaymentBloc, PaymentState>(
            builder: (context, state) {
              return state.maybeWhen(
                loading: () => const Center(child: CircularProgressIndicator()),
                orElse: () => PrimaryButton(
                  text: 'Pay Now',
                  onPressed: () {
                    // Validate
                    if (_nameController.text.isEmpty ||
                        _phoneController.text.isEmpty ||
                        _addressController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please fill in all shipping details"),
                        ),
                      );
                      return;
                    }

                    final authState = context.read<AuthBloc>().state;
                    final email = authState.maybeWhen(
                      authenticated: (auth) => auth.user.email,
                      orElse: () => 'guest@gonana.com',
                    );

                    final reference = 'ref_${const Uuid().v4()}';

                    // Trigger Native Paystack
                    context.read<PaymentBloc>().add(
                      PaymentEvent.payWithPaystack(
                        context: context,
                        amount: amount,
                        email: email ?? 'guest@gonana.com',
                        reference: reference,
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCryptoTab(BuildContext context, double amount) {
    return BlocConsumer<WalletBloc, WalletState>(
      listener: (context, state) {
        // Handle explicit success/error events if we added them,
        // currently handling via direct UI feedback or just state update
      },
      builder: (context, state) {
        final balance = state.maybeWhen(
          loaded: (wallet, _) => wallet
              .balanceNgn, // Showing NGN equivalent for now or mock crypto
          orElse: () => 0.0,
        );
        // For demo, assuming Internal Balance covers it.
        // Real app would check crypto balance (USDT/CCD).

        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              GlassContainer(
                borderRadius: BorderRadius.circular(16),
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: Colors.orange,
                        child: Text('U', style: TextStyle(color: Colors.white)),
                      ),
                      title: const Text('USDT Balance'),
                      subtitle: Text(
                        '${(balance / 1500).toStringAsFixed(2)} USDT',
                      ), // Mock conversion
                      trailing: const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                      ),
                    ),
                    const Divider(),
                    const Text(
                      'Order will be paid using your Internal Wallet balance.',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              PrimaryButton(
                text: 'Confirm Crypto Payment',
                onPressed: () {
                  if (_nameController.text.isEmpty ||
                      _phoneController.text.isEmpty ||
                      _addressController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please fill in all shipping details"),
                      ),
                    );
                    return;
                  }

                  context.read<WalletBloc>().add(
                    WalletEvent.payOrder(
                      amount: amount,
                      orderId: const Uuid().v4(),
                    ),
                  );

                  _createOrder(context, status: OrderStatus.paid);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Crypto Payment Successful!')),
                  );
                  context.go('/home');
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _createOrder(
    BuildContext context, {
    OrderStatus status = OrderStatus.pending,
  }) {
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
      status: status,
      date: DateTime.now(),

      logisticsCompany: _selectedLogistics,
      shippingAddress: _addressController.text,
      recipientName: _nameController.text,
      recipientPhone: _phoneController.text,
    );

    context.read<OrderBloc>().add(OrderEvent.createOrder(order));

    // Decrement stock if order is paid
    if (status == OrderStatus.paid) {
      GetIt.I<MarketRepository>().decrementProductStock(product.id, 1);
    }
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
              style: GoogleFonts.inter(
                color: isSelected
                    ? Colors.white
                    : (Theme.of(context).brightness == Brightness.dark
                          ? Colors.grey[400]
                          : Colors.grey[700]),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
