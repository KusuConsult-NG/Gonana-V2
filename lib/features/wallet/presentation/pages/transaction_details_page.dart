import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../core/widgets/glass_container.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/scaffold_with_background.dart';
import '../../domain/entities/transaction_entity.dart';

class TransactionDetailsPage extends StatelessWidget {
  final TransactionEntity transaction;

  const TransactionDetailsPage({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final isCredit = transaction.type == TransactionType.credit;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ScaffoldWithBackground(
      appBar: AppBar(
        title: Text(
          'Transaction Details',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              GlassContainer(
                padding: const EdgeInsets.all(24),
                borderRadius: BorderRadius.circular(24),
                opacity: 0.6,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: isCredit
                            ? Colors.green.withValues(alpha: 0.1)
                            : Colors.red.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isCredit ? Icons.arrow_downward : Icons.arrow_upward,
                        color: isCredit ? Colors.green : Colors.red,
                        size: 40,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      transaction.description,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${isCredit ? "+" : "-"} NGN ${transaction.amount.toStringAsFixed(2)}',
                      style: GoogleFonts.montserrat(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: isCredit ? Colors.green : Colors.red,
                      ),
                    ),
                    const SizedBox(height: 32),
                    _buildDetailRow(
                      context,
                      'Date',
                      transaction.date.toString().substring(0, 16),
                    ),
                    const SizedBox(height: 16),
                    _buildDetailRow(
                      context,
                      'Status',
                      transaction.status.name.toUpperCase(),
                    ),
                    const SizedBox(height: 16),
                    _buildDetailRow(
                      context,
                      'Type',
                      transaction.type.name.toUpperCase(),
                    ),
                    const SizedBox(height: 16),
                    _buildDetailRow(
                      context,
                      'Reference',
                      'REF-${transaction.date.millisecondsSinceEpoch}',
                    ),
                  ],
                ),
              ),
              const Spacer(),
              PrimaryButton(
                text: 'Share Receipt',
                onPressed: () {
                  SharePlus.instance.share(
                    ShareParams(
                      text:
                          'Transaction Receipt\n${transaction.description}\nDate: ${transaction.date}\nAmount: NGN ${transaction.amount.toStringAsFixed(2)}\nType: ${transaction.type.name.toUpperCase()}\nStatus: ${transaction.status.name.toUpperCase()}\nReference: REF-${transaction.date.millisecondsSinceEpoch}',
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, String label, String value) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.montserrat(
            fontSize: 14,
            color: isDark ? Colors.grey[400] : Colors.grey[600],
          ),
        ),
        Text(
          value,
          style: GoogleFonts.montserrat(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
      ],
    );
  }
}
