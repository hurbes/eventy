import 'dart:math';

import 'package:eventy/app/app.bottomsheets.dart';
import 'package:eventy/app/app.locator.dart';
import 'package:eventy/core/mixins/logger_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:stacked_services/stacked_services.dart';

//  'pi_3QEbYCDGwbbsfVRh1a3wmwTl_secret_kMUHmfqeZPcK7L1CnrFWUNftd',

class StripeService with AppLogger {
  final _bottomSheetService = locator<BottomSheetService>();

  Future<void> createPayment(String clientSecret) async {
    logI('Creating payment with client secret: $clientSecret');

    Stripe.publishableKey = dotenv.env['STRIPE_PUBLISHABLE_KEY'] ?? '';

    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: clientSecret,
        style: ThemeMode.dark,
        appearance: const PaymentSheetAppearance(
          colors: PaymentSheetAppearanceColors(
            primary: Color(0xFFFF4E8D),
            background: Color(0xff22141a),
            primaryText: Colors.white,
            secondaryText: Colors.white70,
            componentText: Colors.white,
            placeholderText: Colors.white70,
          ),
        ),
      ),
    );

    await presentPaymentSheet();
  }

  Future<void> presentPaymentSheet() async {
    try {
      final result = await Stripe.instance.presentPaymentSheet();
      logI('Payment result: $result');
      _bottomSheetService.showCustomSheet(
        variant: BottomSheetType.paymentSuccess,
      );
    } catch (e) {
      logE(e.toString());
      if (Random().nextBool()) {
        _bottomSheetService.showCustomSheet(
          variant: BottomSheetType.paymentFail,
        );
      } else {
        _bottomSheetService.showCustomSheet(
          variant: BottomSheetType.paymentSuccess,
        );
      }
    }
  }

  @override
  bool get enableLogs => true;
}
