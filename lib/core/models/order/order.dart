import 'package:json_annotation/json_annotation.dart';

part 'order.g.dart';

@JsonSerializable()
class Order {
  @JsonKey(name: "short_id")
  String shortId;
  @JsonKey(name: "total_before_additions")
  int totalBeforeAdditions;
  @JsonKey(name: "total_tax")
  int totalTax;
  @JsonKey(name: "total_gross")
  int totalGross;
  @JsonKey(name: "total_fee")
  int totalFee;
  @JsonKey(name: "status")
  String status;
  @JsonKey(name: "refund_status")
  dynamic refundStatus;
  @JsonKey(name: "payment_status")
  dynamic paymentStatus;
  @JsonKey(name: "currency")
  String currency;
  @JsonKey(name: "is_expired")
  bool isExpired;
  @JsonKey(name: "first_name")
  dynamic firstName;
  @JsonKey(name: "last_name")
  dynamic lastName;
  @JsonKey(name: "email")
  dynamic email;
  @JsonKey(name: "public_id")
  String publicId;
  @JsonKey(name: "is_payment_required")
  bool isPaymentRequired;
  @JsonKey(name: "promo_code")
  dynamic promoCode;

  Order({
    required this.shortId,
    required this.totalBeforeAdditions,
    required this.totalTax,
    required this.totalGross,
    required this.totalFee,
    required this.status,
    required this.refundStatus,
    required this.paymentStatus,
    required this.currency,
    required this.isExpired,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.publicId,
    required this.isPaymentRequired,
    required this.promoCode,
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}

@JsonSerializable()
class OrderItem {
  @JsonKey(name: "id")
  int id;
  @JsonKey(name: "order_id")
  int orderId;
  @JsonKey(name: "total_before_additions")
  int totalBeforeAdditions;
  @JsonKey(name: "total_before_discount")
  int totalBeforeDiscount;
  @JsonKey(name: "price")
  int price;
  @JsonKey(name: "price_before_discount")
  dynamic priceBeforeDiscount;
  @JsonKey(name: "quantity")
  int quantity;
  @JsonKey(name: "ticket_id")
  int ticketId;
  @JsonKey(name: "ticket_price_id")
  int ticketPriceId;
  @JsonKey(name: "item_name")
  String itemName;
  @JsonKey(name: "total_service_fee")
  int totalServiceFee;
  @JsonKey(name: "total_tax")
  int totalTax;
  @JsonKey(name: "total_gross")
  int totalGross;

  OrderItem({
    required this.id,
    required this.orderId,
    required this.totalBeforeAdditions,
    required this.totalBeforeDiscount,
    required this.price,
    required this.priceBeforeDiscount,
    required this.quantity,
    required this.ticketId,
    required this.ticketPriceId,
    required this.itemName,
    required this.totalServiceFee,
    required this.totalTax,
    required this.totalGross,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) =>
      _$OrderItemFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemToJson(this);
}

@JsonSerializable()
class TaxesAndFeesRollup {
  @JsonKey(name: "fees")
  List<Fee> fees;

  TaxesAndFeesRollup({
    required this.fees,
  });

  factory TaxesAndFeesRollup.fromJson(Map<String, dynamic> json) =>
      _$TaxesAndFeesRollupFromJson(json);

  Map<String, dynamic> toJson() => _$TaxesAndFeesRollupToJson(this);
}

@JsonSerializable()
class Fee {
  @JsonKey(name: "name")
  String name;
  @JsonKey(name: "rate")
  int rate;
  @JsonKey(name: "type")
  String type;
  @JsonKey(name: "value")
  int value;

  Fee({
    required this.name,
    required this.rate,
    required this.type,
    required this.value,
  });

  factory Fee.fromJson(Map<String, dynamic> json) => _$FeeFromJson(json);

  Map<String, dynamic> toJson() => _$FeeToJson(this);
}

@JsonSerializable()
class PaymentIntent {
  @JsonKey(name: "client_secret")
  String clientSecret;
  @JsonKey(name: "account_id")
  String? accountId;

  PaymentIntent({
    required this.clientSecret,
    required this.accountId,
  });

  factory PaymentIntent.fromJson(Map<String, dynamic> json) =>
      _$PaymentIntentFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentIntentToJson(this);
}
