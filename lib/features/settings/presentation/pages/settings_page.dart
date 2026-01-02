import 'dart:ui';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../config/injection.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../../../core/theme/theme_cubit.dart';
import '../bloc/settings_bloc.dart';
import '../bloc/settings_event.dart';
import '../bloc/settings_state.dart';
import '../widgets/profile_section.dart';
import '../widgets/settings_tile.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<SettingsBloc>()..add(const SettingsEvent.started()),
      child: const _SettingsView(),
    );
  }
}

class _SettingsView extends StatelessWidget {
  const _SettingsView();

  @override
  Widget build(BuildContext context) {
    return BlocListener<SettingsBloc, SettingsState>(
      listener: (context, state) {
        state.maybeWhen(
          loggedOut: () {
            // Navigate to login page
            // context.go('/login'); // Uncomment when login is implemented
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Logged out successfully')),
            );
          },
          orElse: () {},
        );
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(
            'Settings',
            style: GoogleFonts.montserrat(
              color: Colors.black87,
              fontWeight: FontWeight.w700,
            ),
          ),
          backgroundColor: Colors.white.withValues(alpha: 0.1),
          flexibleSpace: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(color: Colors.transparent),
            ),
          ),
          elevation: 0,
          centerTitle: false,
        ),
        body: Stack(
          children: [
            // Animated Background
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
              bottom: 100,
              right: -50,
              child: FadeIn(
                duration: const Duration(seconds: 2),
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blueAccent.withValues(alpha: 0.15),
                        blurRadius: 100,
                        spreadRadius: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Content
            SafeArea(
              child: BlocBuilder<SettingsBloc, SettingsState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    loaded: (user) => ListView(
                      children: [
                        FadeInDown(
                          duration: const Duration(milliseconds: 600),
                          child: ProfileSection(
                            user: user,
                            onEdit: () {
                              context.push('/settings/profile');
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        FadeInUp(
                          delay: const Duration(milliseconds: 200),
                          child: SettingsTile(
                            icon: Icons.verified_user_outlined,
                            title: 'Verification',
                            subtitle: 'Update your KYC and BVN status',
                            onTap: () {
                              context.push('/settings/verification');
                            },
                          ),
                        ),
                        FadeInUp(
                          delay: const Duration(milliseconds: 300),
                          child: SettingsTile(
                            icon: Icons.security_outlined,
                            title: 'Security',
                            subtitle: 'Change password, PIN, or 2FA',
                            onTap: () {
                              context.push('/settings/security');
                            },
                          ),
                        ),
                        FadeInUp(
                          delay: const Duration(milliseconds: 300),
                          child: BlocBuilder<ThemeCubit, ThemeMode>(
                            builder: (context, themeMode) {
                              final isDark =
                                  themeMode == ThemeMode.dark ||
                                  (themeMode == ThemeMode.system &&
                                      MediaQuery.of(
                                            context,
                                          ).platformBrightness ==
                                          Brightness.dark);
                              return SwitchListTile(
                                value: isDark,
                                onChanged: (value) {
                                  context.read<ThemeCubit>().toggleTheme(value);
                                },
                                title: Text(
                                  'Dark Mode',
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                secondary: Icon(
                                  isDark ? Icons.dark_mode : Icons.light_mode,
                                  color: AppTheme.primaryColor,
                                ),
                                activeTrackColor: AppTheme.primaryColor,
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        FadeInUp(
                          delay: const Duration(milliseconds: 400),
                          child: SettingsTile(
                            icon: Icons.notifications_none_outlined,
                            title: 'Notifications',
                            subtitle: 'Manage your notification preferences',
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Notification settings coming soon!',
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 40),
                        FadeInUp(
                          delay: const Duration(milliseconds: 500),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: GlassContainer(
                              padding: EdgeInsets.zero,
                              borderRadius: BorderRadius.circular(12),
                              opacity: 0.8,
                              color: const Color(
                                0xFFCD042D,
                              ).withValues(alpha: 0.9),
                              child: InkWell(
                                onTap: () {
                                  _showLogoutDialog(context);
                                },
                                borderRadius: BorderRadius.circular(12),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Logout',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                    error: (message) => Center(child: Text('Error: $message')),
                    orElse: () =>
                        const Center(child: CircularProgressIndicator()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    // Capture the bloc before showing the dialog
    final settingsBloc = context.read<SettingsBloc>();

    showDialog(
      context: context,
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: AlertDialog(
          backgroundColor: Colors.white.withValues(alpha: 0.9),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            'Logout',
            style: GoogleFonts.montserrat(fontWeight: FontWeight.w700),
          ),
          content: Text(
            'Are you sure you want to logout?',
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
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                settingsBloc.add(const SettingsEvent.logoutRequested());
              },
              child: Text(
                'Logout',
                style: GoogleFonts.montserrat(color: const Color(0xFFCD042D)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
