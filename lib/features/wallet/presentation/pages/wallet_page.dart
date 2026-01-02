import 'dart:ui';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../config/injection.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../domain/entities/transaction_entity.dart';
import '../../domain/entities/wallet_entity.dart';
import '../bloc/wallet_bloc.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<WalletBloc>()..add(const WalletEvent.loadWalletData()),
      child: const _WalletView(),
    );
  }
}

class _WalletView extends StatefulWidget {
  const _WalletView();

  @override
  State<_WalletView> createState() => _WalletViewState();
}

class _WalletViewState extends State<_WalletView> {
  bool _isBalanceVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Wallet',
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
        centerTitle: true,
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
            top: 100,
            left: -50,
            child: FadeIn(
              duration: const Duration(seconds: 2),
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.purple.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.purple.withValues(alpha: 0.15),
                      blurRadius: 100,
                      spreadRadius: 30,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Content
          SafeArea(
            child: BlocBuilder<WalletBloc, WalletState>(
              builder: (context, state) {
                return state.when(
                  initial: () => const SizedBox.shrink(),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (message) => Center(child: Text('Error: $message')),
                  loaded: (wallet, transactions) {
                    return SingleChildScrollView(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FadeInDown(
                            duration: const Duration(milliseconds: 800),
                            child: _buildBalanceCard(wallet),
                          ),
                          const SizedBox(height: 24),
                          FadeInDown(
                            delay: const Duration(milliseconds: 200),
                            duration: const Duration(milliseconds: 600),
                            child: _buildActionButtons(),
                          ),
                          const SizedBox(height: 24),
                          FadeInLeft(
                            delay: const Duration(milliseconds: 400),
                            child: Text(
                              'Crypto Assets',
                              style: GoogleFonts.montserrat(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          _buildCryptoList(wallet),
                          const SizedBox(height: 24),
                          FadeInLeft(
                            delay: const Duration(milliseconds: 600),
                            child: Text(
                              'Transaction History',
                              style: GoogleFonts.montserrat(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          _buildTransactionList(transactions),
                        ],
                      ),
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

  Widget _buildBalanceCard(WalletEntity wallet) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xff29844B),
            Color(0xff00E5FF), // Add cyan for futuristic gradient
            Color(0xff003633),
          ],
          stops: [0.3, 0.7, 1.0],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff29844B).withValues(alpha: 0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Balance',
                style: GoogleFonts.montserrat(
                  color: Colors.white.withValues(alpha: 0.8),
                  fontSize: 14,
                ),
              ),
              IconButton(
                icon: Icon(
                  _isBalanceVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.white.withValues(alpha: 0.8),
                  size: 20,
                ),
                onPressed: () {
                  setState(() {
                    _isBalanceVisible = !_isBalanceVisible;
                  });
                },
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            _isBalanceVisible
                ? 'NGN ${wallet.balanceNgn.toStringAsFixed(2)}'
                : '****',
            style: GoogleFonts.montserrat(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          GlassContainer(
            color: Colors.black.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(12),
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '2348012345678',
                  style: GoogleFonts.montserrat(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontSize: 16,
                    letterSpacing: 1.2,
                  ),
                ),
                const Icon(Icons.copy, color: Colors.white, size: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: _ActionButton(
            icon: Icons.add,
            label: 'Deposit',
            color: AppTheme.primaryColor,
            onTap: () {
              context.push('/wallet/deposit');
            },
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _ActionButton(
            icon: Icons.arrow_outward,
            label: 'Withdraw',
            color: Colors.orange,
            onTap: () {
              context.push('/wallet/withdraw');
            },
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _ActionButton(
            icon: Icons.savings_outlined,
            label: 'Savings',
            color: Colors.purple,
            onTap: () {
              context.push('/savings');
            },
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _ActionButton(
            icon: Icons.monetization_on_outlined,
            label: 'Staking',
            color: Colors.orange,
            onTap: () {
              context.push('/staking');
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCryptoList(WalletEntity wallet) {
    return Column(
      children: [
        FadeInUp(
          delay: const Duration(milliseconds: 500),
          child: _CryptoItem(
            symbol: 'CCD',
            name: 'Concordium',
            amount: wallet.cryptoBalanceCcd,
            iconColor: Colors.purple,
            onTap: () {
              // Placeholder for detail view
              _showTokenDetails(context, 'Concordium (CCD)');
            },
          ),
        ),
        const SizedBox(height: 12),
        FadeInUp(
          delay: const Duration(milliseconds: 600),
          child: _CryptoItem(
            symbol: 'ETH',
            name: 'Ethereum',
            amount: wallet.cryptoBalanceEth,
            iconColor: Colors.blueAccent,
            onTap: () {
              _showTokenDetails(context, 'Ethereum (ETH)');
            },
          ),
        ),
        const SizedBox(height: 12),
        FadeInUp(
          delay: const Duration(milliseconds: 700),
          child: _CryptoItem(
            symbol: 'USDT',
            name: 'Tether',
            amount: 0.00,
            iconColor: Colors.green,
            onTap: () => _showNetworkSelection(context, 'USDT'),
          ),
        ),
        const SizedBox(height: 12),
        FadeInUp(
          delay: const Duration(milliseconds: 800),
          child: _CryptoItem(
            symbol: 'USDC',
            name: 'USD Coin',
            amount: 0.00,
            iconColor: Colors.blue,
            onTap: () => _showNetworkSelection(context, 'USDC'),
          ),
        ),
      ],
    );
  }

  void _showNetworkSelection(BuildContext context, String asset) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return GlassContainer(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          padding: const EdgeInsets.all(24),
          opacity: 0.9,
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select Network for $asset',
                style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              _NetworkOption(
                name: 'ERC20 (Ethereum)',
                onTap: () => Navigator.pop(context),
              ),
              _NetworkOption(
                name: 'TRC20 (Tron)',
                onTap: () => Navigator.pop(context),
              ),
              _NetworkOption(
                name: 'BEP20 (BNB Chain)',
                onTap: () => Navigator.pop(context),
              ),
              _NetworkOption(
                name: 'Solana',
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showTokenDetails(BuildContext context, String tokenName) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return GlassContainer(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          padding: const EdgeInsets.all(24),
          opacity: 0.95,
          color: Theme.of(context).brightness == Brightness.dark
              ? const Color(0xFF1E1E1E)
              : Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$tokenName History',
                style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              // Mock Transactions
              _buildMockHistoryItem(
                context,
                'Received from Exchange',
                '+ 50.0',
                true,
              ),
              const Divider(),
              _buildMockHistoryItem(
                context,
                'Sent to Farmer John',
                '- 12.5',
                false,
              ),
              const Divider(),
              _buildMockHistoryItem(context, 'Staking Reward', '+ 2.1', true),
              const SizedBox(height: 20),
              Center(
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Close'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMockHistoryItem(
    BuildContext context,
    String title,
    String amount,
    bool isCredit,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.montserrat(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white70
                  : Colors.black87,
            ),
          ),
          Text(
            amount,
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.bold,
              color: isCredit ? Colors.green : Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionList(List<TransactionEntity> transactions) {
    if (transactions.isEmpty) {
      return const Center(child: Text("No transactions yet"));
    }
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: transactions.length,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final tx = transactions[index];
        final isCredit = tx.type == TransactionType.credit;
        return FadeInUp(
          delay: Duration(milliseconds: 50 * index),
          child: GlassContainer(
            opacity: 0.4,
            blur: 5,
            padding: const EdgeInsets.all(12),
            borderRadius: BorderRadius.circular(12),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isCredit
                        ? Colors.green.withValues(alpha: 0.1)
                        : Colors.red.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isCredit ? Icons.arrow_downward : Icons.arrow_upward,
                    color: isCredit ? Colors.green : Colors.red,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tx.description,
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        tx.date.toString().substring(0, 16),
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.grey[400]
                              : Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  '${isCredit ? "+" : "-"} NGN ${tx.amount.toStringAsFixed(2)}',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: isCredit ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _NetworkOption extends StatelessWidget {
  final String name;
  final VoidCallback onTap;

  const _NetworkOption({required this.name, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name, style: GoogleFonts.montserrat(fontSize: 16)),
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      trailing: const Icon(Icons.chevron_right, size: 20, color: Colors.grey),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: GlassContainer(
        padding: const EdgeInsets.symmetric(vertical: 16),
        borderRadius: BorderRadius.circular(16),
        opacity: 0.6,
        blur: 15,
        child: Column(
          children: [
            Icon(icon, color: color),
            const SizedBox(height: 8),
            Text(
              label,
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CryptoItem extends StatelessWidget {
  final String symbol;
  final String name;
  final double amount;
  final Color iconColor;
  final VoidCallback onTap;

  const _CryptoItem({
    required this.symbol,
    required this.name,
    required this.amount,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: GlassContainer(
        padding: const EdgeInsets.all(16),
        opacity: 0.5,
        borderRadius: BorderRadius.circular(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Text(
                symbol[0],
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold,
                  color: iconColor,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  symbol,
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  name,
                  style: GoogleFonts.montserrat(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.grey[400]
                        : Colors.grey[700],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text(
              amount.toStringAsFixed(4),
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
