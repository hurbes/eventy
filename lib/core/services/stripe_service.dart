import 'package:eventy/core/mixins/logger_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

//  'pi_3QEbYCDGwbbsfVRh1a3wmwTl_secret_kMUHmfqeZPcK7L1CnrFWUNftd',

class StripeService with AppLogger {
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

    Stripe.instance.presentPaymentSheet();
  }

  @override
  bool get enableLogs => true;
}
