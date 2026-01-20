import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/bloc/auth_bloc.dart';

class KycGuard {
  static bool check(BuildContext context, {required VoidCallback onVerified}) {
    final authState = context.read<AuthBloc>().state;

    // Use runtime type checking instead of maybeWhen to avoid freezed extension issues
    final typeName = authState.runtimeType.toString();

    if (typeName.contains('Authenticated')) {
      // Bypass KYC for user request
      onVerified();
      return true;
    } else if (typeName.contains('Loading')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Checking verification status...')),
      );
      return false;
    } else {
      context.go('/login');
      return false;
    }
  }
}
