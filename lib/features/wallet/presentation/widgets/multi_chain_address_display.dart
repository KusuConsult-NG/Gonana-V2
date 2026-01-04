import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';

/// Widget to display multi-chain crypto addresses with copy and QR features
class MultiChainAddressDisplay extends StatelessWidget {
  final Map<String, String> addresses;

  const MultiChainAddressDisplay({super.key, required this.addresses});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Multi-Chain Addresses',
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        ...addresses.entries.map((entry) {
          return _buildAddressCard(
            context,
            chainName: entry.key,
            address: entry.value,
            isDark: isDark,
          );
        }),
      ],
    );
  }

  Widget _buildAddressCard(
    BuildContext context, {
    required String chainName,
    required String address,
    required bool isDark,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xff1f2937) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? const Color(0xff374151) : const Color(0xffe5e7eb),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Chain name header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: _getChainColor(chainName).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  chainName,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _getChainColor(chainName),
                  ),
                ),
              ),
              const Spacer(),
              // QR Code button
              IconButton(
                icon: const Icon(Icons.qr_code_2, size: 20),
                onPressed: () => _showQRCode(context, chainName, address),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Address display
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: (isDark ? Colors.black : const Color(0xfff9fafb)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    address,
                    style: GoogleFonts.robotoMono(
                      fontSize: 12,
                      color: isDark
                          ? const Color(0xff9ca3af)
                          : const Color(0xff6b7280),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                InkWell(
                  onTap: () => _copyToClipboard(context, address),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: const Color(0xff22c55e).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Icon(
                      Icons.copy,
                      size: 16,
                      color: Color(0xff22c55e),
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
      default:
        return const Color(0xff22c55e);
    }
  }

  void _copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Address copied to clipboard',
          style: GoogleFonts.inter(),
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        backgroundColor: const Color(0xff22c55e),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showQRCode(BuildContext context, String chainName, String address) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$chainName Address',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 24),
              QrImageView(
                data: address,
                version: QrVersions.auto,
                size: 250,
                backgroundColor: Colors.white,
              ),
              const SizedBox(height: 16),
              Text(
                address,
                style: GoogleFonts.robotoMono(fontSize: 10),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Close', style: GoogleFonts.inter()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
