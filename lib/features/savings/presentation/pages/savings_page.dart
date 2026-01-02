import 'dart:ui';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../data/savings_dummy_data.dart';

class SavingsPage extends StatelessWidget {
  const SavingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Savings Assets',
          style: GoogleFonts.montserrat(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black87,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: Colors.transparent,
        flexibleSpace: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(color: Colors.transparent),
          ),
        ),
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

          // Orb
          Positioned(
            top: 100,
            left: -50,
            child: FadeIn(
              duration: const Duration(seconds: 2),
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  color: const Color(0xFF29844B).withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF29844B).withValues(alpha: 0.15),
                      blurRadius: 100,
                      spreadRadius: 30,
                    ),
                  ],
                ),
              ),
            ),
          ),

          SafeArea(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: mockSavingsAssets.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return FadeInDown(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: GlassContainer(
                        borderRadius: BorderRadius.circular(20),
                        child: Column(
                          children: [
                            Text(
                              'Total Savings',
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '₦ 2,500,000.00',
                              style: GoogleFonts.montserrat(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF29844B),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '+12.5% APY (Avg)',
                              style: GoogleFonts.montserrat(
                                fontSize: 12,
                                color: Colors.green,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }

                final asset = mockSavingsAssets[index - 1];
                return FadeInUp(
                  delay: Duration(milliseconds: index * 100),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: GestureDetector(
                      onTap: () {
                        // Transform asset to map for detail page
                        context.push(
                          '/savings/detail',
                          extra: {
                            'name': asset.name,
                            'balance':
                                150000.0, // Mock amount since model doesn't have it
                            'apy': asset.apy,
                            'icon': asset.icon,
                            'profit': 1200.0, // Mock profit
                          },
                        );
                      },
                      child: GlassContainer(
                        padding: const EdgeInsets.all(16),
                        borderRadius: BorderRadius.circular(16),
                        child: Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.5),
                                shape: BoxShape.circle,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                asset.icon,
                                style: const TextStyle(fontSize: 24),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    asset.name,
                                    style: GoogleFonts.montserrat(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    asset.description,
                                    style: GoogleFonts.montserrat(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '${asset.apy}%',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF29844B),
                                  ),
                                ),
                                Text(
                                  'APY',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 10,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FadeInUp(
        delay: const Duration(milliseconds: 1000),
        child: FloatingActionButton.extended(
          onPressed: () => context.push('/savings/create'),
          backgroundColor: const Color(0xFF29844B),
          icon: const Icon(Icons.add, color: Colors.white),
          label: Text(
            'New Save',
            style: GoogleFonts.montserrat(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
