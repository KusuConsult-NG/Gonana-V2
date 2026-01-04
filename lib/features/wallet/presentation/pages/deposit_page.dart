import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';

class DepositPage extends StatefulWidget {
  const DepositPage({super.key});

  @override
  State<DepositPage> createState() => _DepositPageState();
}

class _DepositPageState extends State<DepositPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Multi-chain addresses (should come from wallet state in production)
  final Map<String, String> cryptoAddresses = {
    'USDT (TRC20)': 'TXYZa1234567890abcdefghijklmnopqrs',
    'USDT (ERC20)': '0x71C7656EC7ab88b098defB751B7401B5f6d8976F',
    'USDC (ERC20)': '0x71C7656EC7ab88b098defB751B7401B5f6d8976F',
  };

  String selectedCrypto = 'USDT (TRC20)';

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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xff111827)
          : const Color(0xfff3f4f6),
      appBar: AppBar(
        title: Text(
          'Deposit Funds',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w700,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        backgroundColor: isDark ? const Color(0xff1f2937) : Colors.white,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: const Color(0xff22c55e),
          indicatorWeight: 3,
          labelStyle: GoogleFonts.inter(fontWeight: FontWeight.w600),
          labelColor: const Color(0xff22c55e),
          unselectedLabelColor: isDark
              ? const Color(0xff9ca3af)
              : const Color(0xff6b7280),
          tabs: const [
            Tab(text: 'Crypto'),
            Tab(text: 'Bank Transfer'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildCryptoDeposit(context, isDark),
          _buildFiatDeposit(context, isDark),
        ],
      ),
    );
  }

  Widget _buildCryptoDeposit(BuildContext context, bool isDark) {
    final currentAddress = cryptoAddresses[selectedCrypto] ?? '';

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Currency selector
          FadeInDown(
            child: Text(
              'Select Currency',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
          ),
          const SizedBox(height: 12),
          FadeInDown(
            delay: const Duration(milliseconds: 100),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xff1f2937) : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isDark
                      ? const Color(0xff374151)
                      : const Color(0xffe5e7eb),
                ),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedCrypto,
                  isExpanded: true,
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Color(0xff22c55e),
                  ),
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                  items: cryptoAddresses.keys.map((String currency) {
                    return DropdownMenuItem<String>(
                      value: currency,
                      child: Text(currency),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        selectedCrypto = newValue;
                      });
                    }
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 32),

          // QR Code section
          FadeInUp(
            delay: const Duration(milliseconds: 200),
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xff22c55e).withValues(alpha: 0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: QrImageView(
                  data: currentAddress,
                  version: QrVersions.auto,
                  size: 220.0,
                  backgroundColor: Colors.white,
                  eyeStyle: const QrEyeStyle(
                    eyeShape: QrEyeShape.square,
                    color: Color(0xff22c55e),
                  ),
                  dataModuleStyle: const QrDataModuleStyle(
                    dataModuleShape: QrDataModuleShape.square,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 32),

          // Address section
          FadeInUp(
            delay: const Duration(milliseconds: 300),
            child: Text(
              'Deposit Address',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isDark
                    ? const Color(0xff9ca3af)
                    : const Color(0xff6b7280),
              ),
            ),
          ),
          const SizedBox(height: 8),
          FadeInUp(
            delay: const Duration(milliseconds: 350),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xff1f2937) : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isDark
                      ? const Color(0xff374151)
                      : const Color(0xffe5e7eb),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      currentAddress,
                      style: GoogleFonts.robotoMono(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xff22c55e).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.copy,
                        color: Color(0xff22c55e),
                        size: 20,
                      ),
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: currentAddress));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Address copied!',
                              style: GoogleFonts.inter(),
                            ),
                            backgroundColor: const Color(0xff22c55e),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),

          // Warning box
          FadeInUp(
            delay: const Duration(milliseconds: 400),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.orange.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.orange.withValues(alpha: 0.3)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.warning_amber_rounded,
                    color: Colors.orange,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Only send $selectedCrypto to this address. Sending other assets may result in permanent loss.',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: isDark ? Colors.orange[200] : Colors.orange[900],
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Info cards
          FadeInUp(
            delay: const Duration(milliseconds: 450),
            child: Row(
              children: [
                Expanded(
                  child: _buildInfoCard(
                    isDark,
                    Icons.access_time,
                    'Processing Time',
                    '10-30 min',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildInfoCard(
                    isDark,
                    Icons.confirmation_number_outlined,
                    'Confirmations',
                    '6 blocks',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFiatDeposit(BuildContext context, bool isDark) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeInDown(
            child: Text(
              'Bank Transfer Details',
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
          ),
          const SizedBox(height: 8),
          FadeInDown(
            delay: const Duration(milliseconds: 100),
            child: Text(
              'Transfer funds to the account below. Your wallet will be credited automatically.',
              style: GoogleFonts.inter(
                fontSize: 14,
                color: isDark
                    ? const Color(0xff9ca3af)
                    : const Color(0xff6b7280),
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 24),

          FadeInUp(
            delay: const Duration(milliseconds: 200),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xff1f2937) : Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isDark
                      ? const Color(0xff374151)
                      : const Color(0xffe5e7eb),
                ),
              ),
              child: Column(
                children: [
                  _buildBankDetailRow(
                    isDark,
                    'Bank Name',
                    'Gonana Microfinance Bank',
                    icon: Icons.account_balance,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Divider(height: 1),
                  ),
                  _buildBankDetailRow(
                    isDark,
                    'Account Number',
                    '1234567890',
                    isCopyable: true,
                    icon: Icons.credit_card,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Divider(height: 1),
                  ),
                  _buildBankDetailRow(
                    isDark,
                    'Account Name',
                    'John Doe',
                    icon: Icons.person_outline,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Info banner
          FadeInUp(
            delay: const Duration(milliseconds: 300),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xff22c55e), Color(0xff16a34a)],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.check_circle, color: Colors.white, size: 24),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Deposits are processed automatically within minutes',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Instructions
          FadeInUp(
            delay: const Duration(milliseconds: 350),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'How to Deposit',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
                const SizedBox(height: 12),
                _buildInstructionStep(
                  isDark,
                  '1',
                  'Copy the account number above',
                ),
                _buildInstructionStep(isDark, '2', 'Open your banking app'),
                _buildInstructionStep(
                  isDark,
                  '3',
                  'Transfer to the provided account',
                ),
                _buildInstructionStep(
                  isDark,
                  '4',
                  'Your wallet will be credited automatically',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(
    bool isDark,
    IconData icon,
    String label,
    String value,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xff1f2937) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? const Color(0xff374151) : const Color(0xffe5e7eb),
        ),
      ),
      child: Column(
        children: [
          Icon(icon, color: const Color(0xff22c55e), size: 28),
          const SizedBox(height: 8),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 11,
              color: isDark ? const Color(0xff9ca3af) : const Color(0xff6b7280),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBankDetailRow(
    bool isDark,
    String label,
    String value, {
    bool isCopyable = false,
    IconData? icon,
  }) {
    return Row(
      children: [
        if (icon != null) ...[
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xff22c55e).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: const Color(0xff22c55e), size: 20),
          ),
          const SizedBox(width: 12),
        ],
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: isDark
                      ? const Color(0xff9ca3af)
                      : const Color(0xff6b7280),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
            ],
          ),
        ),
        if (isCopyable)
          Container(
            decoration: BoxDecoration(
              color: const Color(0xff22c55e).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: IconButton(
              icon: const Icon(Icons.copy, color: Color(0xff22c55e), size: 18),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: value));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Copied!', style: GoogleFonts.inter()),
                    backgroundColor: const Color(0xff22c55e),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }

  Widget _buildInstructionStep(bool isDark, String number, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: const Color(0xff22c55e).withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                number,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xff22c55e),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: isDark
                    ? const Color(0xff9ca3af)
                    : const Color(0xff6b7280),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
