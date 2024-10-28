// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      shortId: json['short_id'] as String,
      totalBeforeAdditions: (json['total_before_additions'] as num).toInt(),
      totalTax: (json['total_tax'] as num).toInt(),
      totalGross: (json['total_gross'] as num).toInt(),
      totalFee: (json['total_fee'] as num).toInt(),
      status: json['status'] as String,
      refundStatus: json['refund_status'],
      paymentStatus: json['payment_status'],
      currency: json['currency'] as String,
      isExpired: json['is_expired'] as bool,
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      publicId: json['public_id'] as String,
      isPaymentRequired: json['is_payment_required'] as bool,
      promoCode: json['promo_code'],
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'short_id': instance.shortId,
      'total_before_additions': instance.totalBeforeAdditions,
      'total_tax': instance.totalTax,
      'total_gross': instance.totalGross,
      'total_fee': instance.totalFee,
      'status': instance.status,
      'refund_status': instance.refundStatus,
      'payment_status': instance.paymentStatus,
      'currency': instance.currency,
      'is_expired': instance.isExpired,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'email': instance.email,
      'public_id': instance.publicId,
      'is_payment_required': instance.isPaymentRequired,
      'promo_code': instance.promoCode,
    };

OrderItem _$OrderItemFromJson(Map<String, dynamic> json) => OrderItem(
      id: (json['id'] as num).toInt(),
      orderId: (json['order_id'] as num).toInt(),
      totalBeforeAdditions: (json['total_before_additions'] as num).toInt(),
      totalBeforeDiscount: (json['total_before_discount'] as num).toInt(),
      price: (json['price'] as num).toInt(),
      priceBeforeDiscount: json['price_before_discount'],
      quantity: (json['quantity'] as num).toInt(),
      ticketId: (json['ticket_id'] as num).toInt(),
      ticketPriceId: (json['ticket_price_id'] as num).toInt(),
      itemName: json['item_name'] as String,
      totalServiceFee: (json['total_service_fee'] as num).toInt(),
      totalTax: (json['total_tax'] as num).toInt(),
      totalGross: (json['total_gross'] as num).toInt(),
    );

Map<String, dynamic> _$OrderItemToJson(OrderItem instance) => <String, dynamic>{
      'id': instance.id,
      'order_id': instance.orderId,
      'total_before_additions': instance.totalBeforeAdditions,
      'total_before_discount': instance.totalBeforeDiscount,
      'price': instance.price,
      'price_before_discount': instance.priceBeforeDiscount,
      'quantity': instance.quantity,
      'ticket_id': instance.ticketId,
      'ticket_price_id': instance.ticketPriceId,
      'item_name': instance.itemName,
      'total_service_fee': instance.totalServiceFee,
      'total_tax': instance.totalTax,
      'total_gross': instance.totalGross,
    };

TaxesAndFeesRollup _$TaxesAndFeesRollupFromJson(Map<String, dynamic> json) =>
    TaxesAndFeesRollup(
      fees: (json['fees'] as List<dynamic>)
          .map((e) => Fee.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TaxesAndFeesRollupToJson(TaxesAndFeesRollup instance) =>
    <String, dynamic>{
      'fees': instance.fees,
    };

Fee _$FeeFromJson(Map<String, dynamic> json) => Fee(
      name: json['name'] as String,
      rate: (json['rate'] as num).toInt(),
      type: json['type'] as String,
      value: (json['value'] as num).toInt(),
    );

Map<String, dynamic> _$FeeToJson(Fee instance) => <String, dynamic>{
      'name': instance.name,
      'rate': instance.rate,
      'type': instance.type,
      'value': instance.value,
    };

PaymentIntent _$PaymentIntentFromJson(Map<String, dynamic> json) =>
    PaymentIntent(
      clientSecret: json['client_secret'] as String,
      accountId: json['account_id'] as String?,
    );

Map<String, dynamic> _$PaymentIntentToJson(PaymentIntent instance) =>
    <String, dynamic>{
      'client_secret': instance.clientSecret,
      'account_id': instance.accountId,
    };
