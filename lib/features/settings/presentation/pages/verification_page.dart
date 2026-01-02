import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/glass_container.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({super.key});

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  String _selectedDocType = 'BVN';
  final List<String> _docTypes = ['BVN', 'NIN', 'Voters Card'];
  final _controller = TextEditingController();

  String get _hintText {
    switch (_selectedDocType) {
      case 'BVN':
        return 'Enter 11-digit BVN';
      case 'NIN':
        return 'Enter 11-digit NIN';
      case 'Voters Card':
        return 'Enter Voters Card VIN';
      default:
        return 'Enter ID Number';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Verification',
          style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Select Document Type',
                    style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  GlassContainer(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    borderRadius: BorderRadius.circular(12),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedDocType,
                        isExpanded: true,
                        dropdownColor:
                            Theme.of(context).brightness == Brightness.dark
                            ? const Color(0xFF2C2C2C)
                            : Colors.white,
                        items: _docTypes.map((String type) {
                          return DropdownMenuItem<String>(
                            value: type,
                            child: Text(type, style: GoogleFonts.montserrat()),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              _selectedDocType = newValue;
                              _controller.clear();
                            });
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Document Number',
                    style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  GlassContainer(
                    padding: EdgeInsets.zero,
                    borderRadius: BorderRadius.circular(12),
                    child: TextField(
                      controller: _controller,
                      keyboardType: _selectedDocType == 'Voters Card'
                          ? TextInputType.text
                          : TextInputType.number,
                      decoration: InputDecoration(
                        hintText: _hintText,
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.all(16),
                        hintStyle: TextStyle(color: Colors.grey[400]),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Why do I need to verify?',
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Verification is required to increase your transaction limits and ensure the security of your account.',
                    style: GoogleFonts.montserrat(color: Colors.grey),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_controller.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please enter valid number'),
                            ),
                          );
                          return;
                        }
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '$_selectedDocType verification submitted!',
                            ),
                          ),
                        );
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Verify Identity',
                        style: GoogleFonts.montserrat(
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
}
