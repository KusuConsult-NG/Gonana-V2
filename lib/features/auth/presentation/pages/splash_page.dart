import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/injection.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
// import 'package:animate_do/animate_do.dart'; // We would use this for easy animations, but let's stick to standard for now to avoid dep hell

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthBloc>()..add(const AuthEvent.started()),
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) async {
          // Ensure the animation has time to complete and user sees the splash
          await Future.delayed(const Duration(seconds: 3));

          if (!context.mounted) return;

          state.maybeWhen(
            orElse: () {
              context.go('/login');
            },
            authenticated: (user) {
              context.go('/home');
            },
          );
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Opacity(
                  opacity: _opacityAnimation.value,
                  child: Transform.scale(
                    scale: _scaleAnimation.value,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Hero(
                          tag: 'logo',
                          child: Container(
                            width: 180,
                            height: 180,
                            padding: const EdgeInsets.all(25),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              // Soft radial gradient for inner glow
                              gradient: RadialGradient(
                                colors: [
                                  Colors.white.withValues(alpha: 0.15),
                                  Colors.white.withValues(alpha: 0.0),
                                ],
                              ),
                              boxShadow: [
                                // Primary Glow
                                BoxShadow(
                                  color: const Color(
                                    0xFF29844B,
                                  ).withValues(alpha: 0.3),
                                  blurRadius: 50,
                                  spreadRadius: 10,
                                ),
                                // Secondary Glow (Subtle depth)
                                BoxShadow(
                                  color: const Color(
                                    0xFF64FFDA,
                                  ).withValues(alpha: 0.1),
                                  blurRadius: 30,
                                  spreadRadius: 5,
                                ),
                              ],
                            ),
                            child: ClipOval(
                              child: Image.asset(
                                'assets/images/logo.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Gonana',
                          style: Theme.of(context).textTheme.displayMedium
                              ?.copyWith(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'The Future of Agriculture',
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                color: Colors.grey[600],
                                letterSpacing: 1.5,
                              ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
