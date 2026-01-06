import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Visual widget showing password requirements with checkmarks
class PasswordRequirementsWidget extends StatelessWidget {
  final String password;

  const PasswordRequirementsWidget({super.key, required this.password});

  bool get hasMinLength => password.length >= 8;
  bool get hasUppercase => RegExp(r'(?=.*[A-Z])').hasMatch(password);
  bool get hasLowercase => RegExp(r'(?=.*[a-z])').hasMatch(password);
  bool get hasDigit => RegExp(r'(?=.*\d)').hasMatch(password);
  bool get hasSpecialChar => RegExp(r'(?=.*[@$!%*?&])').hasMatch(password);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Password must contain:',
            style: GoogleFonts.inter(
              color: Colors.white70,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          _buildRequirement('At least 8 characters', hasMinLength),
          _buildRequirement('One uppercase letter', hasUppercase),
          _buildRequirement('One lowercase letter', hasLowercase),
          _buildRequirement('One number', hasDigit),
          _buildRequirement('One special character (@\$!%*?&)', hasSpecialChar),
        ],
      ),
    );
  }

  Widget _buildRequirement(String text, bool isMet) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(
            isMet ? Icons.check_circle : Icons.cancel,
            size: 16,
            color: isMet
                ? const Color(0xFF10B981) // Green
                : Colors.white.withValues(alpha: 0.3),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.inter(
                color: isMet
                    ? Colors.white
                    : Colors.white.withValues(alpha: 0.5),
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
