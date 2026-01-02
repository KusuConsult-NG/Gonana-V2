import 'dart:async';
import 'dart:math';
import 'package:injectable/injectable.dart';

@lazySingleton
class CurrencyService {
  final _rateController = StreamController<double>.broadcast();
  Timer? _timer;

  // Base rate: 1 USD = 1500 NGN (Example)
  double _currentRate = 1500.0;

  Stream<double> get rateStream => _rateController.stream;
  double get currentRate => _currentRate;

  CurrencyService() {
    // Simulate live updates every 5 seconds
    _timer = Timer.periodic(const Duration(seconds: 5), (_) {
      _simulateRateChange();
    });
  }

  void _simulateRateChange() {
    final random = Random();
    // Fluctuate by +/- 5.0 NGN
    final change = (random.nextDouble() * 10) - 5;
    _currentRate += change;
    _rateController.add(_currentRate);
  }

  void dispose() {
    _timer?.cancel();
    _rateController.close();
  }
}
