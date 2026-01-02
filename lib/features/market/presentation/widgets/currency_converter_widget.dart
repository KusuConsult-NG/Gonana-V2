import 'package:flutter/material.dart';
import '../../../../core/services/currency_service.dart';
import '../../../../config/injection.dart';

class CurrencyConverterWidget extends StatelessWidget {
  const CurrencyConverterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final currencyService = getIt<CurrencyService>();

    return StreamBuilder<double>(
      stream: currencyService.rateStream,
      initialData: currencyService.currentRate,
      builder: (context, snapshot) {
        final rate = snapshot.data ?? 1500.0;
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Theme.of(context).primaryColor.withValues(alpha: 0.3),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.currency_exchange, size: 20),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Live Exchange Rate',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  Text(
                    '1 USD = ₦${rate.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
