import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/settings_bloc.dart';
import '../bloc/settings_event.dart';
import '../bloc/settings_state.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/glass_container.dart';

class ChangePinPage extends StatefulWidget {
  const ChangePinPage({super.key});

  @override
  State<ChangePinPage> createState() => _ChangePinPageState();
}

class _ChangePinPageState extends State<ChangePinPage> {
  final _oldPinController = TextEditingController();
  final _newPinController = TextEditingController();
  final _confirmPinController = TextEditingController();

  @override
  void dispose() {
    _oldPinController.dispose();
    _newPinController.dispose();
    _confirmPinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SettingsBloc, SettingsState>(
      listener: (context, state) {
        state.maybeWhen(
          loaded: (_) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('PIN updated successfully!')),
            );
            context.pop();
          },
          error: (message) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(message)));
          },
          orElse: () {},
        );
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(
            'Change PIN',
            style: GoogleFonts.inter(fontWeight: FontWeight.bold),
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
                      : [const Color(0xFFE0F7FA), const Color(0xFFE8F5E9)],
                ),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Secure your account',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildPinField('Old PIN', _oldPinController),
                    const SizedBox(height: 16),
                    _buildPinField('New PIN', _newPinController),
                    const SizedBox(height: 16),
                    _buildPinField('Confirm New PIN', _confirmPinController),
                    const Spacer(),
                    BlocBuilder<SettingsBloc, SettingsState>(
                      builder: (context, state) {
                        final isLoading = state.maybeWhen(
                          loading: () => true,
                          orElse: () => false,
                        );
                        return SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: isLoading ? null : _onChangePin,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.primaryColor,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: isLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : Text(
                                    'Update PIN',
                                    style: GoogleFonts.inter(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPinField(String hint, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(hint, style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        GlassContainer(
          padding: EdgeInsets.zero,
          borderRadius: BorderRadius.circular(12),
          child: TextField(
            controller: controller,
            obscureText: true,
            keyboardType: TextInputType.number,
            maxLength: 4,
            decoration: InputDecoration(
              hintText: '****',
              counterText: '',
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(16),
              hintStyle: TextStyle(color: Colors.grey[400]),
              prefixIcon: const Icon(Icons.lock_outline, color: Colors.grey),
            ),
          ),
        ),
      ],
    );
  }

  void _onChangePin() {
    if (_oldPinController.text.length != 4 ||
        _newPinController.text.length != 4 ||
        _confirmPinController.text.length != 4) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('PIN must be 4 digits')));
      return;
    }

    if (_newPinController.text != _confirmPinController.text) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('PINs do not match')));
      return;
    }

    context.read<SettingsBloc>().add(
      SettingsEvent.changePinRequested(
        oldPin: _oldPinController.text,
        newPin: _newPinController.text,
      ),
    );
  }
}
