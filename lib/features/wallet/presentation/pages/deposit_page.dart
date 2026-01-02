import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/glass_container.dart';

class DepositPage extends StatefulWidget {
  const DepositPage({super.key});

  @override
  State<DepositPage> createState() => _DepositPageState();
}

class _DepositPageState extends State<DepositPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final String walletAddress = '0x71C7656EC7ab88b098defB751B7401B5f6d8976F';

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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Deposit',
          style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppTheme.primaryColor,
          labelColor: Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : Colors.black,
          tabs: const [
            Tab(text: 'Crypto Deposit'),
            Tab(text: 'Fiat Deposit'),
          ],
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Adaptive Background
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
                    : [const Color(0xFFE0F7FA), const Color(0xFFE8F5E9)],
              ),
            ),
          ),
          SafeArea(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildCryptoDeposit(context),
                _buildFiatDeposit(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCryptoDeposit(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Text(
            'Scan QR Code to Deposit',
            style: GoogleFonts.montserrat(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 24),
          GlassContainer(
            padding: const EdgeInsets.all(24),
            borderRadius: BorderRadius.circular(20),
            child: QrImageView(
              data: walletAddress,
              version: QrVersions.auto,
              size: 200.0,
              backgroundColor: Colors.white,
            ),
          ),
          const SizedBox(height: 40),
          Text(
            'Wallet Address',
            style: GoogleFonts.montserrat(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 12),
          GlassContainer(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            borderRadius: BorderRadius.circular(12),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    walletAddress,
                    style: GoogleFonts.inconsolata(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.copy, color: AppTheme.primaryColor),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: walletAddress));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Address copied to clipboard'),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Spacer(),
          Text(
            'Send only supported assets to this address.\nSending unsupported assets may result in loss.',
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildFiatDeposit(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bank Transfer Details',
            style: GoogleFonts.montserrat(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Transfer funds to the account below to credit your wallet instantly.',
            style: GoogleFonts.montserrat(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 24),

          GlassContainer(
            padding: const EdgeInsets.all(24),
            borderRadius: BorderRadius.circular(16),
            child: Column(
              children: [
                _buildBankDetailRow('Bank Name', 'Gonana Microfinance Bank'),
                const Divider(),
                _buildBankDetailRow(
                  'Account Number',
                  '1234567890',
                  isCopyable: true,
                ),
                const Divider(),
                _buildBankDetailRow('Account Name', 'John Doe'),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Center(
            child: Text(
              'Deposits are processed automatically.',
              style: GoogleFonts.montserrat(
                fontSize: 12,
                fontStyle: FontStyle.italic,
                color: AppTheme.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBankDetailRow(
    String label,
    String value, {
    bool isCopyable = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: GoogleFonts.montserrat(color: Colors.grey[600])),
          Row(
            children: [
              Text(
                value,
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              if (isCopyable) ...[
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: value));
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(const SnackBar(content: Text('Copied!')));
                  },
                  child: const Icon(
                    Icons.copy,
                    size: 16,
                    color: AppTheme.primaryColor,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
