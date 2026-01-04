import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import '../../domain/entities/transaction_entity.dart';

class TransactionDetailsPage extends StatefulWidget {
  final TransactionEntity transaction;

  const TransactionDetailsPage({super.key, required this.transaction});

  @override
  State<TransactionDetailsPage> createState() => _TransactionDetailsPageState();
}

class _TransactionDetailsPageState extends State<TransactionDetailsPage> {
  final ScreenshotController _screenshotController = ScreenshotController();
  bool _isSharing = false;

  @override
  Widget build(BuildContext context) {
    final transaction = widget.transaction;
    final isCredit = transaction.type == TransactionType.credit;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final reference = 'REF-${transaction.date.millisecondsSinceEpoch}';

    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xff111827)
          : const Color(0xfff3f4f6),
      appBar: AppBar(
        title: Text(
          'Transaction Details',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w700,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        backgroundColor: isDark ? const Color(0xff1f2937) : Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.download_outlined),
            tooltip: 'Download Receipt',
            onPressed: () => _downloadReceipt(context),
          ),
        ],
      ),
      body: Screenshot(
        controller: _screenshotController,
        child: Container(
          color: isDark ? const Color(0xff111827) : const Color(0xfff3f4f6),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // Status card
                FadeInDown(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: isCredit
                            ? [const Color(0xff22c55e), const Color(0xff16a34a)]
                            : [
                                const Color(0xffef4444),
                                const Color(0xffdc2626),
                              ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color:
                              (isCredit
                                      ? const Color(0xff22c55e)
                                      : const Color(0xffef4444))
                                  .withValues(alpha: 0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            isCredit
                                ? Icons.arrow_downward
                                : Icons.arrow_upward,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          isCredit ? 'Money Received' : 'Money Sent',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: Colors.white.withValues(alpha: 0.9),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'NGN ${transaction.amount.toStringAsFixed(2)}',
                          style: GoogleFonts.inter(
                            fontSize: 36,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            _getStatusText(transaction.status),
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Details card
                FadeInUp(
                  delay: const Duration(milliseconds: 100),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xff1f2937) : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isDark
                            ? const Color(0xff374151)
                            : const Color(0xffe5e7eb),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Transaction Information',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: isDark ? Colors.white : Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildDetailRow(
                          isDark,
                          Icons.description_outlined,
                          'Description',
                          transaction.description,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Divider(height: 1),
                        ),
                        _buildDetailRow(
                          isDark,
                          Icons.calendar_today_outlined,
                          'Date & Time',
                          DateFormat(
                            'MMM dd, yyyy • hh:mm a',
                          ).format(transaction.date),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Divider(height: 1),
                        ),
                        _buildDetailRow(
                          isDark,
                          Icons.receipt_long_outlined,
                          'Reference',
                          reference,
                          isCopyable: true,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Divider(height: 1),
                        ),
                        _buildDetailRow(
                          isDark,
                          Icons.category_outlined,
                          'Type',
                          transaction.type.name.toUpperCase(),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Payment Breakdown
                FadeInUp(
                  delay: const Duration(milliseconds: 150),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xff1f2937) : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isDark
                            ? const Color(0xff374151)
                            : const Color(0xffe5e7eb),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Payment Breakdown',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: isDark ? Colors.white : Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildDetailRow(
                          isDark,
                          Icons.attach_money,
                          'Amount',
                          'NGN ${transaction.amount.toStringAsFixed(2)}',
                        ),
                        const SizedBox(height: 16),
                        _buildDetailRow(
                          isDark,
                          Icons.local_offer_outlined,
                          'Service Fee (1.5%)',
                          'NGN ${(transaction.amount * 0.015).toStringAsFixed(2)}',
                        ),
                        if (!isCredit) ...[
                          // Only show network fee for debits/transfers
                          const SizedBox(height: 16),
                          _buildDetailRow(
                            isDark,
                            Icons.network_check,
                            'Network Fee (Est.)',
                            'NGN 50.00',
                          ),
                        ],
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Divider(height: 1),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total',
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: isDark ? Colors.white : Colors.black87,
                              ),
                            ),
                            Text(
                              'NGN ${(transaction.amount + (transaction.amount * 0.015) + (!isCredit ? 50 : 0)).toStringAsFixed(2)}',
                              style: GoogleFonts.inter(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                color: const Color(0xff22c55e),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Status timeline
                if (transaction.status != TransactionStatus.failed) ...[
                  FadeInUp(
                    delay: const Duration(milliseconds: 200),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xff1f2937) : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isDark
                              ? const Color(0xff374151)
                              : const Color(0xffe5e7eb),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Transaction Timeline',
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: isDark ? Colors.white : Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 20),
                          _buildTimelineItem(
                            isDark,
                            'Initiated',
                            DateFormat('hh:mm a').format(transaction.date),
                            true,
                          ),
                          _buildTimelineItem(
                            isDark,
                            'Processing',
                            DateFormat('hh:mm a').format(
                              transaction.date.add(const Duration(minutes: 2)),
                            ),
                            transaction.status != TransactionStatus.pending,
                          ),
                          _buildTimelineItem(
                            isDark,
                            'Completed',
                            transaction.status == TransactionStatus.completed
                                ? DateFormat('hh:mm a').format(
                                    transaction.date.add(
                                      const Duration(minutes: 5),
                                    ),
                                  )
                                : 'Pending',
                            transaction.status == TransactionStatus.completed,
                            isLast: true,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],

                // Action buttons
                FadeInUp(
                  delay: const Duration(milliseconds: 300),
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: _isSharing
                              ? null
                              : () => _shareReceipt(context, reference),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            side: BorderSide(
                              color: isDark
                                  ? const Color(0xff374151)
                                  : const Color(0xffe5e7eb),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          icon: _isSharing
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : Icon(
                                  Icons.share_outlined,
                                  size: 20,
                                  color: isDark ? Colors.white : Colors.black87,
                                ),
                          label: Text(
                            _isSharing ? 'Generating...' : 'Share Receipt',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w600,
                              color: isDark ? Colors.white : Colors.black87,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            _showSupportDialog(context);
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            backgroundColor: const Color(0xff22c55e),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          icon: const Icon(
                            Icons.support_agent,
                            size: 20,
                            color: Colors.white,
                          ),
                          label: Text(
                            'Support',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(
    bool isDark,
    IconData icon,
    String label,
    String value, {
    bool isCopyable = false,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xff22c55e).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: const Color(0xff22c55e), size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: isDark
                      ? const Color(0xff9ca3af)
                      : const Color(0xff6b7280),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
            ],
          ),
        ),
        if (isCopyable)
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.copy, size: 18),
              color: const Color(0xff22c55e),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: value));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Copied!', style: GoogleFonts.inter()),
                    backgroundColor: const Color(0xff22c55e),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }

  Widget _buildTimelineItem(
    bool isDark,
    String title,
    String time,
    bool isCompleted, {
    bool isLast = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: isCompleted
                    ? const Color(0xff22c55e)
                    : Colors.grey.withValues(alpha: 0.3),
                shape: BoxShape.circle,
                border: Border.all(
                  color: isCompleted
                      ? const Color(0xff22c55e)
                      : (isDark
                            ? const Color(0xff374151)
                            : const Color(0xffe5e7eb)),
                  width: 2,
                ),
              ),
              child: isCompleted
                  ? const Icon(Icons.check, color: Colors.white, size: 14)
                  : null,
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 40,
                color: isCompleted
                    ? const Color(0xff22c55e)
                    : (isDark
                          ? const Color(0xff374151)
                          : const Color(0xffe5e7eb)),
              ),
          ],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isCompleted
                        ? (isDark ? Colors.white : Colors.black87)
                        : (isDark
                              ? const Color(0xff6b7280)
                              : const Color(0xff9ca3af)),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  time,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: isDark
                        ? const Color(0xff9ca3af)
                        : const Color(0xff6b7280),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _getStatusText(TransactionStatus status) {
    switch (status) {
      case TransactionStatus.completed:
        return 'SUCCESSFUL';
      case TransactionStatus.pending:
        return 'PROCESSING';
      case TransactionStatus.failed:
        return 'FAILED';
    }
  }

  Future<void> _shareReceipt(BuildContext context, String reference) async {
    setState(() => _isSharing = true);
    try {
      final image = await _screenshotController.capture();
      if (image == null) return;

      final directory = await getTemporaryDirectory();
      final imagePath = await File(
        '${directory.path}/receipt_$reference.png',
      ).create();
      await imagePath.writeAsBytes(image);

      final xFile = XFile(imagePath.path);
      // ignore: deprecated_member_use
      await Share.shareXFiles([
        xFile,
      ], text: 'Transaction Receipt - $reference');
    } catch (e) {
      debugPrint('Error sharing receipt: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to share receipt')),
        );
      }
    } finally {
      setState(() => _isSharing = false);
    }
  }

  void _downloadReceipt(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Receipt downloaded!', style: GoogleFonts.inter()),
        backgroundColor: const Color(0xff22c55e),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  void _showSupportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          'Contact Support',
          style: GoogleFonts.inter(fontWeight: FontWeight.w700),
        ),
        content: Text(
          'Need help with this transaction? Our support team is here to assist you.',
          style: GoogleFonts.inter(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Cancel', style: GoogleFonts.inter()),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
            },
            child: Text(
              'Chat Now',
              style: GoogleFonts.inter(color: const Color(0xff22c55e)),
            ),
          ),
        ],
      ),
    );
  }
}
