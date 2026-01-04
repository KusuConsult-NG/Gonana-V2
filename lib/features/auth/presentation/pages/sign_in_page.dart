import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/injection.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../settings/domain/repositories/settings_repository.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

/// Modern login page matching HTML design reference
/// Clean, professional design with vibrant green branding
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return BlocProvider(
      create: (context) => getIt<AuthBloc>(),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          state.maybeWhen(
            authenticated: (user) {
              context.go('/home');
            },
            error: (message) => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            orElse: () {},
          );
        },
        builder: (context, state) {
          final isLoading = state.maybeWhen(
            loading: () => true,
            orElse: () => false,
          );

          return Scaffold(
            backgroundColor: isDark
                ? AppTheme.backgroundDark
                : AppTheme.backgroundLight,
            body: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 400),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Logo and Header
                        FadeInDown(
                          duration: const Duration(milliseconds: 600),
                          child: _buildHeader(theme),
                        ),

                        const SizedBox(height: 32),

                        // Tab selector (Login/Sign Up)
                        FadeInDown(
                          delay: const Duration(milliseconds: 200),
                          child: _buildTabSelector(),
                        ),

                        const SizedBox(height: 32),

                        // Form Card
                        FadeInUp(
                          delay: const Duration(milliseconds: 400),
                          child: _buildFormCard(context, isLoading, isDark),
                        ),

                        const SizedBox(height: 24),

                        // Social Login Options
                        FadeInUp(
                          delay: const Duration(milliseconds: 600),
                          child: _buildSocialOptions(context, isLoading),
                        ),

                        const SizedBox(height: 24),

                        // Footer
                        FadeInUp(
                          delay: const Duration(milliseconds: 800),
                          child: _buildFooter(theme),
                        ),

                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(ThemeData theme) {
    return Column(
      children: [
        // Logo Container
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: AppTheme.primaryGreen.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(
            Icons.spa_rounded,
            size: 36,
            color: AppTheme.primaryGreen,
          ),
        ),
        const SizedBox(height: 16),

        // App Name
        Text(
          'Gonana',
          style: theme.textTheme.displaySmall?.copyWith(
            fontWeight: FontWeight.w700,
            color: AppTheme.primaryGreen,
          ),
        ),
        const SizedBox(height: 8),

        // Title
        Text(
          'Welcome Back',
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),

        // Subtitle
        Text(
          'Access your global agricultural marketplace',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.brightness == Brightness.dark
                ? AppTheme.textMutedDark
                : AppTheme.textMutedLight,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildTabSelector() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? const Color(0xff374151)
            : const Color(0xfff3f4f6),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? const Color(0xff1f2937)
              : Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        labelColor: AppTheme.primaryGreen,
        unselectedLabelColor: Theme.of(context).brightness == Brightness.dark
            ? AppTheme.textMutedDark
            : AppTheme.textMutedLight,
        labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        tabs: const [
          Tab(text: 'Log In'),
          Tab(text: 'Sign Up'),
        ],
        onTap: (index) {
          if (index == 1) {
            context.push('/signup');
          }
        },
      ),
    );
  }

  Widget _buildFormCard(BuildContext context, bool isLoading, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.surfaceDark : AppTheme.surfaceLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? AppTheme.borderDark : AppTheme.borderLight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.05),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Email Field
            Text(
              'Email Address',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: 'you@example.com',
                prefixIcon: Icon(Icons.mail_outline_rounded),
              ),
              validator: (v) {
                if (v == null || v.isEmpty) {
                  return 'Email is required';
                }
                if (!v.contains('@')) {
                  return 'Enter a valid email';
                }
                return null;
              },
            ),

            const SizedBox(height: 20),

            // Password Field
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Password', style: Theme.of(context).textTheme.titleSmall),
                TextButton(
                  onPressed: () => context.push('/forgot-password'),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(0, 0),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text(
                    'Forgot?',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _passwordController,
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                hintText: '••••••••',
                prefixIcon: const Icon(Icons.lock_outline_rounded),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility_rounded
                        : Icons.visibility_off_rounded,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
              validator: (v) {
                if (v == null || v.isEmpty) {
                  return 'Password is required';
                }
                if (v.length < 6) {
                  return 'Password must be at least 6 characters';
                }
                return null;
              },
            ),

            const SizedBox(height: 24),

            // Login Button
            CustomButton.primary(
              label: 'Log In',
              isFullWidth: true,
              isLoading: isLoading,
              onPressed: isLoading
                  ? null
                  : () {
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(
                          AuthEvent.signInRequested(
                            email: _emailController.text.trim(),
                            password: _passwordController.text,
                          ),
                        );
                      }
                    },
            ),

            // Biometric Login Option
            FutureBuilder<bool>(
              future: getIt<SettingsRepository>().getBiometricsEnabled(),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data == true) {
                  return Column(
                    children: [
                      const SizedBox(height: 16),
                      Center(
                        child: IconButton(
                          onPressed: () {
                            context.read<AuthBloc>().add(
                              const AuthEvent.biometricLoginRequested(),
                            );
                          },
                          icon: const Icon(
                            Icons.fingerprint_rounded,
                            size: 40,
                            color: AppTheme.primaryGreen,
                          ),
                        ),
                      ),
                    ],
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialOptions(BuildContext context, bool isLoading) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        // Divider
        Row(
          children: [
            Expanded(
              child: Divider(
                color: isDark ? AppTheme.borderDark : AppTheme.borderLight,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'OR CONTINUE WITH',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: isDark
                      ? AppTheme.textMutedDark
                      : AppTheme.textMutedLight,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            Expanded(
              child: Divider(
                color: isDark ? AppTheme.borderDark : AppTheme.borderLight,
              ),
            ),
          ],
        ),

        const SizedBox(height: 20),

        // Social Buttons
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: isLoading
                    ? null
                    : () {
                        context.read<AuthBloc>().add(
                          const AuthEvent.googleSignInRequested(),
                        );
                      },
                icon: Image.asset(
                  'assets/images/google_icon.png',
                  width: 20,
                  height: 20,
                  errorBuilder: (_, __, ___) =>
                      const Icon(Icons.g_mobiledata, size: 20),
                ),
                label: const Text('Google'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  side: BorderSide(
                    color: isDark ? AppTheme.borderDark : AppTheme.borderLight,
                  ),
                  foregroundColor: isDark
                      ? AppTheme.textDark
                      : AppTheme.textLight,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: isLoading
                    ? null
                    : () {
                        // TODO: Implement Wallet Connect
                      },
                icon: const Icon(
                  Icons.account_balance_wallet_rounded,
                  size: 20,
                ),
                label: const Text('Wallet'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  side: BorderSide(
                    color: isDark ? AppTheme.borderDark : AppTheme.borderLight,
                  ),
                  foregroundColor: isDark
                      ? AppTheme.textDark
                      : AppTheme.textLight,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFooter(ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.verified_user_rounded,
          size: 16,
          color: theme.brightness == Brightness.dark
              ? AppTheme.textMutedDark
              : AppTheme.textMutedLight,
        ),
        const SizedBox(width: 8),
        Text(
          'Secure Agri-Marketplace',
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.brightness == Brightness.dark
                ? AppTheme.textMutedDark
                : AppTheme.textMutedLight,
          ),
        ),
      ],
    );
  }
}
