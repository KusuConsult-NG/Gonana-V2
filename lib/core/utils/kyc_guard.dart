import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/auth/presentation/bloc/auth_state.dart';

class KycGuard {
  static bool check(BuildContext context, {required VoidCallback onVerified}) {
    final authState = context.read<AuthBloc>().state;

    return authState.maybeWhen(
      authenticated: (auth) {
        // Bypass KYC for user request
        onVerified();
        return true;
      },
      loading: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Checking verification status...')),
        );
        return false;
      },
      orElse: () {
        context.go('/login');
        return false;
      },
    );
  }

  static void _showKycRequiredDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Verification Required',
          style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
        ),
        content: Text(
          'To ensure security and comply with regulations, identity verification is required before you can perform financial transactions (payments, withdrawals, savings).',
          style: GoogleFonts.montserrat(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.montserrat(color: Colors.grey),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              context.push('/settings/verification');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF29844B),
              foregroundColor: Colors.white,
            ),
            child: Text('Verify Now', style: GoogleFonts.montserrat()),
          ),
        ],
      ),
    );
  }
}
