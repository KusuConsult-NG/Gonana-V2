import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/glass_container.dart';

class SavingsDetailPage extends StatelessWidget {
  final Map<String, dynamic>? asset; // Mock asset data

  const SavingsDetailPage({super.key, this.asset});

  @override
  Widget build(BuildContext context) {
    // Mock data if not provided
    final data =
        asset ??
        {
          'name': 'Gona Flex',
          'balance': 150000.0,
          'apy': 12.5,
          'icon': '🌱',
          'profit': 5600.0,
        };

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          data['name'],
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black87,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black87,
          ),
          onPressed: () => context.pop(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black87,
            ),
            onPressed: () {},
          ),
        ],
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
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  // Balance Card
                  GlassContainer(
                    borderRadius: BorderRadius.circular(24),
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        Text(
                          'Total Balance',
                          style: GoogleFonts.montserrat(color: Colors.grey),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '₦ ${(data['balance'] as double).toStringAsFixed(2)}',
                          style: GoogleFonts.montserrat(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.green.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                '+₦ ${data['profit']}',
                                style: GoogleFonts.montserrat(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Total Profit',
                              style: GoogleFonts.montserrat(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Graph Area
                  SizedBox(
                    height: 200,
                    width: double.infinity,
                    child: GlassContainer(
                      borderRadius: BorderRadius.circular(24),
                      child: Center(
                        child: Text(
                          'Performance Chart (Mock)',
                          style: GoogleFonts.montserrat(color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Recent Transactions
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Recent Activity',
                      style: GoogleFonts.montserrat(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildActivityItem(
                    'Interest Earned',
                    '+₦ 250.00',
                    'Today, 9:00 AM',
                  ),
                  _buildActivityItem('Deposit', '+₦ 50,000.00', 'Yesterday'),
                  _buildActivityItem(
                    'Interest Earned',
                    '+₦ 245.00',
                    'Dec 30, 2025',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: ElevatedButton(
            onPressed: () => context.push('/savings/create'), // Top up
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Text(
              'Add Funds',
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActivityItem(String title, String amount, String date) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GlassContainer(
        padding: const EdgeInsets.all(16),
        borderRadius: BorderRadius.circular(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_downward,
                color: Colors.green,
                size: 20,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    date,
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              amount,
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
