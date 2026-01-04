import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/glass_container.dart';

class CreateSavingsPage extends StatefulWidget {
  const CreateSavingsPage({super.key});

  @override
  State<CreateSavingsPage> createState() => _CreateSavingsPageState();
}

class _CreateSavingsPageState extends State<CreateSavingsPage> {
  final TextEditingController _amountController = TextEditingController();
  String _selectedToken = 'Gona';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Create Savings',
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
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'How much do you want to save?',
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Amount Input
                  GlassContainer(
                    padding: EdgeInsets.zero,
                    borderRadius: BorderRadius.circular(12),
                    child: TextField(
                      controller: _amountController,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      style: GoogleFonts.inter(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        prefixText: 'NGN ',
                        prefixStyle: GoogleFonts.inter(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primaryColor,
                        ),
                        hintText: "0.00",
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.all(24),
                        hintStyle: TextStyle(color: Colors.grey[400]),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Token Selection (Mock)
                  Text(
                    'Select Token',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildTokenSelector('Gona', true),
                  const SizedBox(height: 12),
                  _buildTokenSelector('USDT', false),
                  const SizedBox(height: 40),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_amountController.text.isNotEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Savings created successfully!'),
                            ),
                          );
                          context.pop();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please enter an amount'),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Complete',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTokenSelector(String token, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedToken = token;
        });
      },
      child: GlassContainer(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        borderRadius: BorderRadius.circular(12),
        child: Row(
          children: [
            Icon(
              Icons.circle, // Placeholder for token logo
              color: token == 'Gona' ? AppTheme.primaryColor : Colors.green,
            ),
            const SizedBox(width: 12),
            Text(
              token,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const Spacer(),
            if (_selectedToken == token)
              const Icon(Icons.check_circle, color: AppTheme.primaryColor),
          ],
        ),
      ),
    );
  }
}
