import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/glass_container.dart';
import '../widgets/pin_verification_dialog.dart'; // Import Dialog
import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../auth/presentation/bloc/auth_bloc.dart';
// import '../../../auth/presentation/bloc/auth_state.dart';
import '../../../settings/presentation/bloc/settings_bloc.dart';
import '../../../settings/presentation/bloc/settings_state.dart';
import '../../../settings/presentation/bloc/settings_event.dart';

class WithdrawPage extends StatefulWidget {
  const WithdrawPage({super.key});

  @override
  State<WithdrawPage> createState() => _WithdrawPageState();
}

class _WithdrawPageState extends State<WithdrawPage> {
  final _amountController = TextEditingController();
  final _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Withdraw',
            style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          bottom: TabBar(
            indicatorColor: AppTheme.primaryColor,
            labelColor: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
            tabs: const [
              Tab(text: 'Crypto Wallet'),
              Tab(text: 'Bank Transfer'),
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
                      : [const Color(0xFFFFF3E0), const Color(0xFFFFEBEE)],
                ),
              ),
            ),
            SafeArea(
              child: TabBarView(
                children: [_buildWalletWithdrawal(), _buildBankWithdrawal()],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWalletWithdrawal() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recipient Address',
            style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          GlassContainer(
            padding: EdgeInsets.zero,
            borderRadius: BorderRadius.circular(12),
            child: TextField(
              controller: _addressController,
              decoration: InputDecoration(
                hintText: 'Enter wallet address',
                border: InputBorder.none,
                contentPadding: const EdgeInsets.all(16),
                hintStyle: TextStyle(color: Colors.grey[400]),
              ),
            ),
          ),
          const SizedBox(height: 24),
          _buildAmountField(),
          const SizedBox(height: 40),
          _buildConfirmButton('Confirm Withdrawal'),
        ],
      ),
    );
  }

  Widget _buildBankWithdrawal() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bank Details',
            style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          _buildTextField(hint: 'Bank Name'),
          const SizedBox(height: 12),
          _buildTextField(hint: 'Account Number', isNumber: true),
          const SizedBox(height: 12),
          _buildTextField(hint: 'Account Name'),
          const SizedBox(height: 24),
          _buildAmountField(),
          const SizedBox(height: 40),
          _buildConfirmButton('Withdraw to Bank'),
        ],
      ),
    );
  }

  Widget _buildTextField({required String hint, bool isNumber = false}) {
    return GlassContainer(
      padding: EdgeInsets.zero,
      borderRadius: BorderRadius.circular(12),
      child: TextField(
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(16),
          hintStyle: TextStyle(color: Colors.grey[400]),
        ),
      ),
    );
  }

  Widget _buildAmountField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Amount',
          style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        GlassContainer(
          padding: EdgeInsets.zero,
          borderRadius: BorderRadius.circular(12),
          child: TextField(
            controller: _amountController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              hintText: '0.00',
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(16),
              hintStyle: TextStyle(color: Colors.grey[400]),
              suffixIcon: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  'NGN',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryColor,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildConfirmButton(String text) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (_amountController.text.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Please enter an amount')),
            );
            return;
          }

          // PIN Verification Logic
          final settingsState = context.read<SettingsBloc>().state;
          final user = settingsState.maybeWhen(
            loaded: (user) => user,
            orElse: () => null,
          );

          if (user == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Loading user profile... please click confirm again.',
                ),
              ),
            );
            context.read<SettingsBloc>().add(const SettingsEvent.started());
            return;
          }

          // 1. Check if PIN exists
          if (user.pin == null || user.pin!.isEmpty) {
            // 2. If no PIN, check KYC
            if (user.kycStatus != 'verified') {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Verification Required'),
                  content: const Text(
                    'You must complete KYC verification before you can withdraw funds.',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(ctx),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                        context.push('/settings/verification');
                      },
                      child: const Text('Verify Now'),
                    ),
                  ],
                ),
              );
              return;
            } else {
              // Verified but no PIN -> Create PIN
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('PIN Required'),
                  content: const Text(
                    'Please create a transaction PIN to proceed.',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(ctx),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                        context.push('/settings/security/pin');
                      },
                      child: const Text('Create PIN'),
                    ),
                  ],
                ),
              );
              return;
            }
          }

          // 3. PIN matches -> Verify
          showDialog<bool>(
            context: context,
            builder: (context) => PinVerificationDialog(
              onVerify: (pin) async {
                // Verify against user.pin
                // In real app, this should be an API call to avoid local check if possible,
                // but for now we check against the loaded user entity.
                await Future.delayed(const Duration(seconds: 1));
                return pin == user.pin;
              },
            ),
          ).then((verified) {
            if (verified == true && mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Withdrawal Successful!'),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.pop(context); // Close Withdraw Page
            }
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primaryColor,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          text,
          style: GoogleFonts.montserrat(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
