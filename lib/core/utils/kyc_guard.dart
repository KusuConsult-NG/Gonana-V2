import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
}
