import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/injection.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_event.dart';
import '../../../auth/presentation/bloc/auth_state.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthBloc>()..add(const AuthEvent.started()),
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          state.maybeWhen(
            authenticated: (_) => context.go('/home'),
            unauthenticated: () => context.go('/login'),
            orElse: () {},
          );
        },
        child: const Scaffold(
          backgroundColor: Color(0xFF29844B), // Gonana Green
          body: Center(child: CircularProgressIndicator(color: Colors.white)),
        ),
      ),
    );
  }
}
