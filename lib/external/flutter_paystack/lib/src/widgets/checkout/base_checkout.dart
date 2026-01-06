import 'package:flutter/material.dart';
import '../../common/paystack.dart';
import '../../models/checkout_response.dart';
import '../animated_widget.dart';
import 'checkout_widget.dart';

abstract class BaseCheckoutMethodState<T extends StatefulWidget>
    extends BaseAnimatedState<T> {
  final OnResponse<CheckoutResponse> onResponse;
  final CheckoutMethod _method;

  BaseCheckoutMethodState(this.onResponse, this._method);

  CheckoutMethod get method => _method;
}
