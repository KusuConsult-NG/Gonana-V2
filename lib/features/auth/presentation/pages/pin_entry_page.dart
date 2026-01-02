import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/glass_container.dart';

class PinEntryPage extends StatefulWidget {
  final bool isTransaction;
  final VoidCallback? onSuccess;

  const PinEntryPage({super.key, this.isTransaction = false, this.onSuccess});

  @override
  State<PinEntryPage> createState() => _PinEntryPageState();
}

class _PinEntryPageState extends State<PinEntryPage> {
  String _pin = '';

  void _onKeyPress(String value) {
    if (_pin.length < 4) {
      setState(() {
        _pin += value;
      });
      if (_pin.length == 4) {
        _validatePin();
      }
    }
  }

  void _onDelete() {
    if (_pin.isNotEmpty) {
      setState(() {
        _pin = _pin.substring(0, _pin.length - 1);
      });
    }
  }

  void _validatePin() {
    // Mock Validation
    if (_pin == '1234') {
      if (widget.isTransaction) {
        // Return true if opened as dialog/screen for transaction
        if (widget.onSuccess != null) {
          widget.onSuccess!();
        } else {
          context.pop(true);
        }
      } else {
        // Navigate to Home if Login
        context.go('/home');
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Incorrect PIN. Try 1234'),
          backgroundColor: Colors.red,
        ),
      );
      setState(() {
        _pin = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background (Reused from App)
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.isTransaction
                      ? 'Enter Transaction PIN'
                      : 'Welcome Back',
                  style: GoogleFonts.montserrat(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Enter your 4-digit PIN',
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 48),

                // PIN Dots
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(4, (index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: index < _pin.length
                            ? AppTheme.primaryColor
                            : Colors.grey.withValues(alpha: 0.3),
                        border: Border.all(
                          color: index < _pin.length
                              ? AppTheme.primaryColor
                              : Colors.grey,
                          width: 2,
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 64),

                // Keypad
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 1.5,
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 20,
                          ),
                      itemCount: 12,
                      itemBuilder: (context, index) {
                        if (index == 9) return const SizedBox(); // Empty
                        if (index == 11) {
                          return _buildKeyResponse(
                            child: const Icon(Icons.backspace_outlined),
                            onTap: _onDelete,
                          );
                        }

                        final number = index == 10 ? '0' : '${index + 1}';
                        return _buildKeyResponse(
                          child: Text(
                            number,
                            style: GoogleFonts.montserrat(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onTap: () => _onKeyPress(number),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (!widget.isTransaction)
            Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child: Center(
                child: TextButton(
                  onPressed: () {
                    // Forgot PIN flow (e.g. logout)
                    context.go('/login');
                  },
                  child: Text(
                    'Switch Account',
                    style: GoogleFonts.montserrat(
                      color: AppTheme.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildKeyResponse({
    required Widget child,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(40),
      child: GlassContainer(
        borderRadius: BorderRadius.circular(40),
        padding: EdgeInsets.zero,
        child: Center(child: child),
      ),
    );
  }
}
