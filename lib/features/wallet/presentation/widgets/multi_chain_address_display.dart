import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';

/// Widget to display multi-chain crypto addresses with dropdown selector
class MultiChainAddressDisplay extends StatefulWidget {
  final Map<String, String> addresses;

  const MultiChainAddressDisplay({super.key, required this.addresses});

  @override
  State<MultiChainAddressDisplay> createState() =>
      _MultiChainAddressDisplayState();
}

class _MultiChainAddressDisplayState extends State<MultiChainAddressDisplay> {
  late String _selectedChain;

  @override
  void initState() {
    super.initState();
    // Default to first chain if available
    _selectedChain = widget.addresses.keys.isNotEmpty
        ? widget.addresses.keys.first
        : 'Ethereum';
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (widget.addresses.isEmpty) {
      return const SizedBox.shrink();
    }

    final currentAddress = widget.addresses[_selectedChain] ?? '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Multi-Chain Wallet',
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        _buildWalletCard(
          context,
          isDark: isDark,
          currentAddress: currentAddress,
        ),
      ],
    );
  }

  Widget _buildWalletCard(
    BuildContext context, {
    required bool isDark,
    required String currentAddress,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xff1f2937) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? const Color(0xff374151) : const Color(0xffe5e7eb),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Dropdown selector
          Row(
            children: [
              Icon(Icons.link, size: 20, color: _getChainColor(_selectedChain)),
              const SizedBox(width: 8),
              Text(
                'Select Network',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: isDark
                      ? const Color(0xff9ca3af)
                      : const Color(0xff6b7280),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Dropdown button
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.black.withValues(alpha: 0.3)
                  : const Color(0xfff9fafb),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: _getChainColor(_selectedChain).withValues(alpha: 0.3),
                width: 1.5,
              ),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedChain,
                isExpanded: true,
                icon: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: _getChainColor(_selectedChain),
                ),
                dropdownColor: isDark ? const Color(0xff1f2937) : Colors.white,
                borderRadius: BorderRadius.circular(12),
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white : Colors.black87,
                ),
                items: widget.addresses.keys.map((String chain) {
                  return DropdownMenuItem<String>(
                    value: chain,
                    child: Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: _getChainColor(chain),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          chain,
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: isDark ? Colors.white : Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _selectedChain = newValue;
                    });
                  }
                },
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Address section header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.account_balance_wallet,
                    size: 18,
                    color: isDark
                        ? const Color(0xff9ca3af)
                        : const Color(0xff6b7280),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Wallet Address',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: isDark
                          ? const Color(0xff9ca3af)
                          : const Color(0xff6b7280),
                    ),
                  ),
                ],
              ),
              // QR Code button
              InkWell(
                onTap: () =>
                    _showQRCode(context, _selectedChain, currentAddress),
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _getChainColor(
                      _selectedChain,
                    ).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.qr_code_2,
                    size: 20,
                    color: _getChainColor(_selectedChain),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Address display with copy button
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.black.withValues(alpha: 0.4)
                  : const Color(0xfff9fafb),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isDark
                    ? const Color(0xff374151)
                    : const Color(0xffe5e7eb),
              ),
            ),
            child: Column(
              children: [
                Text(
                  currentAddress,
                  style: GoogleFonts.robotoMono(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: isDark
                        ? const Color(0xffd1d5db)
                        : const Color(0xff374151),
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () => _copyToClipboard(context, currentAddress),
                    icon: const Icon(Icons.copy, size: 18),
                    label: Text(
                      'Copy Address',
                      style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _getChainColor(_selectedChain),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getChainColor(String chainName) {
    switch (chainName.toUpperCase()) {
      case 'ETHEREUM':
      case 'ETH':
        return const Color(0xff627EEA);
      case 'TRON':
      case 'TRX':
        return const Color(0xffEC0928);
      case 'BINANCE':
      case 'BNB':
      case 'BSC':
        return const Color(0xffF3BA2F);
      case 'POLYGON':
      case 'MATIC':
        return const Color(0xff8247E5);
      case 'SOLANA':
      case 'SOL':
        return const Color(0xff14F195);
      default:
        return const Color(0xff22c55e);
    }
  }

  void _copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white, size: 20),
            const SizedBox(width: 12),
            Text(
              'Address copied to clipboard!',
              style: GoogleFonts.inter(fontWeight: FontWeight.w500),
            ),
          ],
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: const Color(0xff22c55e),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showQRCode(BuildContext context, String chainName, String address) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: isDark ? const Color(0xff1f2937) : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header with chain indicator
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: _getChainColor(chainName).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  chainName.toUpperCase(),
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: _getChainColor(chainName),
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              Text(
                'Scan to receive',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white70 : Colors.black54,
                ),
              ),
              const SizedBox(height: 24),

              // QR Code with border
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: _getChainColor(chainName).withValues(alpha: 0.2),
                      blurRadius: 20,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: QrImageView(
                  data: address,
                  version: QrVersions.auto,
                  size: 220,
                  backgroundColor: Colors.white,
                  eyeStyle: QrEyeStyle(
                    eyeShape: QrEyeShape.square,
                    color: _getChainColor(chainName),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Address text
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.black.withValues(alpha: 0.3)
                      : const Color(0xfff9fafb),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  address,
                  style: GoogleFonts.robotoMono(
                    fontSize: 10,
                    color: isDark ? Colors.white70 : Colors.black54,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(height: 24),

              // Close button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _getChainColor(chainName),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Close',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
