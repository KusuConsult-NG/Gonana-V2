import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FuturisticTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  const FuturisticTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.validator,
  });

  @override
  State<FuturisticTextField> createState() => _FuturisticTextFieldState();
}

class _FuturisticTextFieldState extends State<FuturisticTextField> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (hasFocus) {
        setState(() {
          _isFocused = hasFocus;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: _isFocused ? 0.9 : 0.7),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _isFocused
                ? const Color(0xFF29844B)
                : Colors.white.withValues(alpha: 0.5),
            width: 1.5,
          ),
          boxShadow: [
            if (_isFocused)
              BoxShadow(
                color: const Color(0xFF29844B).withValues(alpha: 0.3),
                blurRadius: 12,
                spreadRadius: 2,
              ),
          ],
        ),
        child: TextFormField(
          controller: widget.controller,
          obscureText: widget.obscureText,
          keyboardType: widget.keyboardType,
          style: GoogleFonts.montserrat(
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
          validator: widget.validator,
          decoration: InputDecoration(
            labelText: widget.label,
            labelStyle: GoogleFonts.montserrat(
              color: _isFocused ? const Color(0xFF29844B) : Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
            hintText: widget.hint,
            hintStyle: GoogleFonts.montserrat(color: Colors.grey[400]),
            prefixIcon: widget.prefixIcon != null
                ? Icon(
                    widget.prefixIcon,
                    color: _isFocused
                        ? const Color(0xFF29844B)
                        : Colors.grey[500],
                  )
                : null,
            suffixIcon: widget.suffixIcon,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 16,
            ),
            errorStyle: const TextStyle(height: 0, color: Colors.transparent),
          ),
        ),
      ),
    );
  }
}
