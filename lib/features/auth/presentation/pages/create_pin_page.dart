import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../settings/presentation/bloc/settings_bloc.dart';
import '../../../settings/presentation/bloc/settings_event.dart';
import '../../../settings/presentation/bloc/settings_state.dart';

class CreatePinPage extends StatefulWidget {
  const CreatePinPage({super.key});

  @override
  State<CreatePinPage> createState() => _CreatePinPageState();
}

class _CreatePinPageState extends State<CreatePinPage> {
  final _pinController = TextEditingController();
  final _confirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<SettingsBloc, SettingsState>(
      listener: (context, state) {
        state.maybeWhen(
          loaded: (_) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('PIN Set Successfully!')),
            );
            context.go('/home'); // Or back to wherever they came from
          },
          error: (msg) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(msg), backgroundColor: Colors.red),
            );
          },
          orElse: () {},
        );
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(
            'Create Transaction PIN',
            style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
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
                      ? [const Color(0xFF1E1E1E), const Color(0xFF000000)]
                      : [const Color(0xFFE0F7FA), const Color(0xFFE8F5E9)],
                ),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      'Secure Your Wallet',
                      style: GoogleFonts.montserrat(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Set a 4-digit PIN for withdrawals and transactions.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(color: Colors.grey),
                    ),
                    const SizedBox(height: 40),
                    _buildPinField('Enter PIN', _pinController),
                    const SizedBox(height: 16),
                    _buildPinField('Confirm PIN', _confirmController),
                    const Spacer(),
                    BlocBuilder<SettingsBloc, SettingsState>(
                      builder: (context, state) {
                        final isLoading = state.maybeWhen(
                          loading: () => true,
                          orElse: () => false,
                        );
                        return PrimaryButton(
                          text: 'Create PIN',
                          isLoading: isLoading,
                          onPressed: _onSubmit,
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
        Text(hint, style: GoogleFonts.montserrat(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        GlassContainer(
          padding: EdgeInsets.zero,
          borderRadius: BorderRadius.circular(12),
          child: TextField(
            controller: controller,
            obscureText: true,
            keyboardType: TextInputType.number,
            maxLength: 4,
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 8,
            ),
            decoration: const InputDecoration(
              counterText: '',
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(16),
            ),
          ),
        ),
      ],
    );
  }

  void _onSubmit() {
    if (_pinController.text.length != 4) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('PIN must be 4 digits')));
      return;
    }
    if (_pinController.text != _confirmController.text) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('PINs do not match')));
      return;
    }

    // Dispatch Create PIN Event
    // We treat "Change PIN" with empty oldPin as "Create"
    context.read<SettingsBloc>().add(
      SettingsEvent.changePinRequested(oldPin: '', newPin: _pinController.text),
    );
  }
}
