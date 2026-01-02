import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../../../core/widgets/primary_button.dart';

class StakeAmountPage extends StatefulWidget {
  final Map<String, dynamic> pool;
  const StakeAmountPage({super.key, required this.pool});

  @override
  State<StakeAmountPage> createState() => _StakeAmountPageState();
}

class _StakeAmountPageState extends State<StakeAmountPage> {
  final _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Stake ${widget.pool['name']}',
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
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  GlassContainer(
                    borderRadius: BorderRadius.circular(16),
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          Text(
                            'Enter Amount',
                            style: GoogleFonts.montserrat(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            controller: _amountController,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.montserrat(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                            decoration: const InputDecoration(
                              prefixText: '₦ ',
                              border: InputBorder.none,
                              hintText: '0.00',
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Available Balance: ₦ 1,500,000',
                            style: GoogleFonts.montserrat(
                              color: AppTheme.primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Summary
                  _buildSummaryRow('pool', widget.pool['name']),
                  const SizedBox(height: 12),
                  _buildSummaryRow('Duration', widget.pool['duration']),
                  const SizedBox(height: 12),
                  _buildSummaryRow('APY', widget.pool['apy']),

                  const Spacer(),
                  PrimaryButton(
                    text: 'Confirm Stake',
                    onPressed: () {
                      // Validate Amount
                      if (_amountController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please enter an amount'),
                          ),
                        );
                        return;
                      }

                      // Mock Success
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Staking Successful!')),
                      );
                      context.pop(); // Go back to list
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: GoogleFonts.montserrat(color: Colors.grey)),
        Text(
          value,
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
