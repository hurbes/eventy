import 'package:eventy/core/models/order/order.dart';

final testOrder = Order(
  shortId: 'TEST123',
  totalBeforeAdditions: 200,
  totalTax: 20,
  totalGross: 230,
  totalFee: 10,
  status: 'pending',
  refundStatus: null,
  paymentStatus: null,
  currency: 'USD',
  isExpired: false,
  firstName: null,
  lastName: null,
  email: null,
  publicId: 'PUB123',
  isPaymentRequired: true,
  promoCode: null,
);

final testOrderItem = OrderItem(
  id: 1,
  orderId: 1,
  totalBeforeAdditions: 100,
  totalBeforeDiscount: 100,
  price: 50,
  priceBeforeDiscount: null,
  quantity: 2,
  ticketId: 1,
  ticketPriceId: 1,
  itemName: 'General Admission',
  totalServiceFee: 10,
  totalTax: 20,
  totalGross: 130,
);

final testPaymentIntent = PaymentIntent(
  clientSecret: 'pi_test_secret_key',
  accountId: 'acc_123456',
);

final testTaxesAndFeesRollup = TaxesAndFeesRollup(
  fees: [
    Fee(
      name: 'Service Fee',
      rate: 5,
      type: 'percentage',
      value: 10,
    ),
    Fee(
      name: 'Processing Fee',
      rate: 3,
      type: 'percentage',
      value: 6,
    ),
  ],
);
