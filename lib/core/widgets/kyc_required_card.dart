import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

/// KYC requirement card shown when user needs to complete verification
class KycRequiredCard extends StatelessWidget {
  final String title;
  final String message;
  final String actionLabel;

  const KycRequiredCard({
    super.key,
    this.title = '🔐 Complete KYC to Access Wallet',
    this.message =
        'For your security and regulatory compliance, please complete your KYC verification to access custodial wallet features including multi-chain crypto addresses.',
    this.actionLabel = 'Start Verification',
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xff22c55e).withValues(alpha: 0.1),
            const Color(0xff16a34a).withValues(alpha: 0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xff22c55e).withValues(alpha: 0.3),
          width: 2,
        ),
      ),
      child: Column(
        children: [
          // Icon
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: const Color(0xff22c55e).withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.verified_user_rounded,
              size: 40,
              color: Color(0xff22c55e),
            ),
          ),

          const SizedBox(height: 20),

          // Title
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: isDark ? Colors.white : Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 12),

          // Message
          Text(
            message,
            style: GoogleFonts.inter(
              fontSize: 14,
              height: 1.6,
              color: isDark ? const Color(0xff9ca3af) : const Color(0xff6b7280),
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 24),

          // Action Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                context.push('/settings/verification');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff22c55e),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    actionLabel,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
