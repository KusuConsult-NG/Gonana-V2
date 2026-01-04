import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../settings/presentation/bloc/settings_bloc.dart';
import '../../../settings/presentation/bloc/settings_event.dart';
import '../../../settings/presentation/bloc/settings_state.dart';
import '../widgets/pin_verification_dialog.dart';

class WithdrawPage extends StatefulWidget {
  const WithdrawPage({super.key});

  @override
  State<WithdrawPage> createState() => _WithdrawPageState();
}

class _WithdrawPageState extends State<WithdrawPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _amountController = TextEditingController();
  final _addressController = TextEditingController();
  final _accountNumberController = TextEditingController();
  final _accountNameController = TextEditingController();

  String selectedBank = 'Access Bank';
  String selectedCrypto = 'USDT (TRC20)';

  final double withdrawalFee = 50.0; // NGN or percentage
  double get totalAmount {
    final amount = double.tryParse(_amountController.text) ?? 0.0;
    return amount > 0 ? amount + withdrawalFee : 0.0;
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _amountController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _tabController.dispose();
    _amountController.dispose();
    _addressController.dispose();
    _accountNumberController.dispose();
    _accountNameController.dispose();
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
          'Withdraw Funds',
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
            Tab(text: 'Bank Transfer'),
            Tab(text: 'Crypto'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildBankWithdrawal(isDark),
          _buildCryptoWithdrawal(isDark),
        ],
      ),
    );
  }

  Widget _buildBankWithdrawal(bool isDark) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bank selection
          FadeInDown(child: _buildSectionTitle(isDark, 'Bank')),
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
                  value: selectedBank,
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
                  items:
                      [
                            'Access Bank',
                            'GTBank',
                            'First Bank',
                            'Zenith Bank',
                            'UBA',
                          ]
                          .map(
                            (bank) => DropdownMenuItem(
                              value: bank,
                              child: Text(bank),
                            ),
                          )
                          .toList(),
                  onChanged: (value) => setState(() => selectedBank = value!),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Account Number
          FadeInDown(
            delay: const Duration(milliseconds: 150),
            child: _buildSectionTitle(isDark, 'Account Number'),
          ),
          const SizedBox(height: 12),
          FadeInDown(
            delay: const Duration(milliseconds: 200),
            child: _buildTextField(
              isDark,
              _accountNumberController,
              'Enter 10-digit account number',
              keyboardType: TextInputType.number,
              maxLength: 10,
            ),
          ),
          const SizedBox(height: 20),

          // Account Name (auto-filled after validation in real app)
          FadeInDown(
            delay: const Duration(milliseconds: 250),
            child: _buildSectionTitle(isDark, 'Account Name'),
          ),
          const SizedBox(height: 12),
          FadeInDown(
            delay: const Duration(milliseconds: 300),
            child: _buildTextField(
              isDark,
              _accountNameController,
              'John Doe',
              enabled: false, // Read-only after validation
            ),
          ),
          const SizedBox(height: 20),

          // Amount
          FadeInDown(
            delay: const Duration(milliseconds: 350),
            child: _buildSectionTitle(isDark, 'Amount'),
          ),
          const SizedBox(height: 12),
          FadeInDown(
            delay: const Duration(milliseconds: 400),
            child: _buildAmountField(isDark),
          ),
          const SizedBox(height: 24),

          // Fee breakdown
          if (_amountController.text.isNotEmpty) ...[
            FadeInUp(
              delay: const Duration(milliseconds: 450),
              child: _buildFeeBreakdown(isDark),
            ),
            const SizedBox(height: 32),
          ],

          // Withdraw button
          FadeInUp(
            delay: const Duration(milliseconds: 500),
            child: _buildWithdrawButton(isDark, 'Withdraw to Bank'),
          ),
        ],
      ),
    );
  }

  Widget _buildCryptoWithdrawal(bool isDark) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Crypto selection
          FadeInDown(child: _buildSectionTitle(isDark, 'Currency')),
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
                  items: ['USDT (TRC20)', 'USDT (ERC20)', 'USDC ( ERC20)']
                      .map(
                        (crypto) => DropdownMenuItem(
                          value: crypto,
                          child: Text(crypto),
                        ),
                      )
                      .toList(),
                  onChanged: (value) => setState(() => selectedCrypto = value!),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Wallet Address
          FadeInDown(
            delay: const Duration(milliseconds: 150),
            child: _buildSectionTitle(isDark, 'Recipient Address'),
          ),
          const SizedBox(height: 12),
          FadeInDown(
            delay: const Duration(milliseconds: 200),
            child: _buildTextField(
              isDark,
              _addressController,
              'Enter wallet address',
              maxLines: 2,
            ),
          ),
          const SizedBox(height: 20),

          // Amount
          FadeInDown(
            delay: const Duration(milliseconds: 250),
            child: _buildSectionTitle(isDark, 'Amount'),
          ),
          const SizedBox(height: 12),
          FadeInDown(
            delay: const Duration(milliseconds: 300),
            child: _buildAmountField(isDark),
          ),
          const SizedBox(height: 24),

          // Fee breakdown
          if (_amountController.text.isNotEmpty) ...[
            FadeInUp(
              delay: const Duration(milliseconds: 350),
              child: _buildFeeBreakdown(isDark),
            ),
            const SizedBox(height: 24),
          ],

          // Warning
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
                      'Double-check the address. Crypto transactions are irreversible.',
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
          const SizedBox(height: 32),

          // Withdraw button
          FadeInUp(
            delay: const Duration(milliseconds: 450),
            child: _buildWithdrawButton(isDark, 'Withdraw Crypto'),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(bool isDark, String title) {
    return Text(
      title,
      style: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: isDark ? Colors.white : Colors.black87,
      ),
    );
  }

  Widget _buildTextField(
    bool isDark,
    TextEditingController controller,
    String hint, {
    TextInputType? keyboardType,
    int maxLines = 1,
    int? maxLength,
    bool enabled = true,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xff1f2937) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? const Color(0xff374151) : const Color(0xffe5e7eb),
        ),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        maxLength: maxLength,
        enabled: enabled,
        style: GoogleFonts.inter(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: enabled
              ? (isDark ? Colors.white : Colors.black87)
              : (isDark ? const Color(0xff6b7280) : const Color(0xff9ca3af)),
        ),
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
          counterText: '',
          hintStyle: GoogleFonts.inter(
            color: isDark ? const Color(0xff6b7280) : const Color(0xff9ca3af),
          ),
        ),
      ),
    );
  }

  Widget _buildAmountField(bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xff1f2937) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? const Color(0xff374151) : const Color(0xffe5e7eb),
        ),
      ),
      child: Row(
        children: [
          Text(
            'NGN',
            style: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: const Color(0xff22c55e),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: _amountController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              style: GoogleFonts.inter(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: isDark ? Colors.white : Colors.black87,
              ),
              decoration: InputDecoration(
                hintText: '0.00',
                border: InputBorder.none,
                hintStyle: GoogleFonts.inter(
                  color: isDark
                      ? const Color(0xff6b7280)
                      : const Color(0xff9ca3af),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeeBreakdown(bool isDark) {
    final amount = double.tryParse(_amountController.text) ?? 0.0;

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
          _buildFeeRow(isDark, 'Amount', 'NGN ${amount.toStringAsFixed(2)}'),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(height: 1),
          ),
          _buildFeeRow(
            isDark,
            'Withdrawal Fee',
            'NGN ${withdrawalFee.toStringAsFixed(2)}',
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(height: 1),
          ),
          _buildFeeRow(
            isDark,
            'Total',
            'NGN ${totalAmount.toStringAsFixed(2)}',
            isTotal: true,
          ),
        ],
      ),
    );
  }

  Widget _buildFeeRow(
    bool isDark,
    String label,
    String value, {
    bool isTotal = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
            color: isDark
                ? (isTotal ? Colors.white : const Color(0xff9ca3af))
                : (isTotal ? Colors.black87 : const Color(0xff6b7280)),
          ),
        ),
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: isTotal ? 18 : 14,
            fontWeight: FontWeight.w700,
            color: isTotal
                ? const Color(0xff22c55e)
                : (isDark ? Colors.white : Colors.black87),
          ),
        ),
      ],
    );
  }

  Widget _buildWithdrawButton(bool isDark, String label) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => _handleWithdrawal(),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: const Color(0xff22c55e),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void _handleWithdrawal() {
    if (_amountController.text.isEmpty) {
      _showSnackBar('Please enter an amount', Colors.red);
      return;
    }

    final settingsState = context.read<SettingsBloc>().state;
    final user = settingsState.maybeWhen(
      loaded: (user) => user,
      orElse: () => null,
    );

    if (user == null) {
      _showSnackBar('Loading user profile...', Colors.orange);
      context.read<SettingsBloc>().add(const SettingsEvent.started());
      return;
    }

    // Check PIN exists
    if (user.pin == null || user.pin!.isEmpty) {
      _showPinRequiredDialog(user.kycStatus == 'verified');
      return;
    }

    // Verify PIN
    showDialog<bool>(
      context: context,
      builder: (context) => PinVerificationDialog(
        onVerify: (pin) async {
          await Future.delayed(const Duration(seconds: 1));
          return pin == user.pin;
        },
      ),
    ).then((verified) {
      if (verified == true && mounted) {
        _showSnackBar('Withdrawal Successful!', const Color(0xff22c55e));
        Navigator.pop(context);
      }
    });
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: GoogleFonts.inter()),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  void _showPinRequiredDialog(bool isKycVerified) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          'PIN Required',
          style: GoogleFonts.inter(fontWeight: FontWeight.w700),
        ),
        content: Text(
          isKycVerified
              ? 'Please create a transaction PIN to proceed.'
              : 'You must complete KYC verification before withdrawing funds.',
          style: GoogleFonts.inter(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Cancel', style: GoogleFonts.inter()),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              context.push(
                isKycVerified
                    ? '/settings/security/pin'
                    : '/settings/verification',
              );
            },
            child: Text(
              isKycVerified ? 'Create PIN' : 'Verify Now',
              style: GoogleFonts.inter(color: const Color(0xff22c55e)),
            ),
          ),
        ],
      ),
    );
  }
}
