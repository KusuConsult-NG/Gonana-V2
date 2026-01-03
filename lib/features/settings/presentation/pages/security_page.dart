import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/settings_bloc.dart';
import '../bloc/settings_event.dart';
import '../bloc/settings_state.dart';
import '../widgets/settings_tile.dart';
import '../../../../config/injection.dart';
import '../../domain/repositories/settings_repository.dart';

class SecurityPage extends StatefulWidget {
  const SecurityPage({super.key});

  @override
  State<SecurityPage> createState() => _SecurityPageState();
}

class _SecurityPageState extends State<SecurityPage> {
  bool _biometricsEnabled = false;

  @override
  void initState() {
    super.initState();
    _loadBiometricsSetting();
  }

  Future<void> _loadBiometricsSetting() async {
    final settingsRepo = getIt<SettingsRepository>();
    final enabled = await settingsRepo.getBiometricsEnabled();
    if (mounted) {
      setState(() {
        _biometricsEnabled = enabled;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Security',
          style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
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
                    : [const Color(0xFFE0F7FA), const Color(0xFFE8F5E9)],
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: BlocBuilder<SettingsBloc, SettingsState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      SettingsTile(
                        icon: Icons.lock_outline,
                        title: 'Change Password',
                        subtitle: 'Update your login password',
                        onTap: () =>
                            context.push('/settings/security/password'),
                      ),
                      const SizedBox(height: 16),
                      if (state.maybeWhen(
                        loaded: (u) => u.pin == null || u.pin!.isEmpty,
                        orElse: () => true,
                      ))
                        SettingsTile(
                          icon: Icons.pin,
                          title: 'Create Transaction PIN',
                          subtitle: 'Set up your security PIN',
                          onTap: () {
                            // Check KYC before allowing creation
                            final user = state.maybeWhen(
                              loaded: (u) => u,
                              orElse: () => null,
                            );
                            if (user?.kycStatus != 'verified') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Please complete KYC verification first',
                                  ),
                                ),
                              );
                              return;
                            }
                            context.push('/settings/security/pin');
                          },
                        )
                      else
                        SettingsTile(
                          icon: Icons.pin,
                          title: 'Change PIN',
                          subtitle: 'Update your transaction PIN',
                          onTap: () =>
                              context.push('/settings/security/change-pin'),
                        ),
                      const SizedBox(height: 16),
                      SwitchListTile(
                        value: _biometricsEnabled,
                        onChanged: (value) {
                          setState(() {
                            _biometricsEnabled = value;
                          });
                          context.read<SettingsBloc>().add(
                            SettingsEvent.toggleBiometricsRequested(value),
                          );
                        },
                        title: Text(
                          'Biometrics',
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w600,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black87,
                          ),
                        ),
                        subtitle: Text(
                          'Enable fingerprint login',
                          style: GoogleFonts.montserrat(color: Colors.grey),
                        ),
                        secondary: const Icon(
                          Icons.fingerprint,
                          color: Color(0xFF558B2F),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
