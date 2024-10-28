import 'package:eventy/core/models/event/event.dart';
import 'package:objectbox/objectbox.dart';

final testTicket1 = Ticket(
  id: 1,
  title: 'General Admission',
  type: 'regular',
  description: 'Standard entry ticket',
  maxPerOrder: 4,
  minPerOrder: 1,
  saleStartDate: DateTime(2024, 3, 1),
  saleEndDate: DateTime(2024, 4, 1),
  eventId: 1,
  isBeforeSaleStartDate: false,
  isAfterSaleEndDate: false,
  quantityAvailable: 5,
  price: 50.0,
  prices: ToMany<TicketPrice>(items: [testTicketPrice1]),
  isAvailable: true,
  isSoldOut: false,
);

final testTicket2 = Ticket(
  id: 2,
  title: 'VIP Access',
  type: 'vip',
  description: 'VIP entry with special perks',
  maxPerOrder: 2,
  minPerOrder: 1,
  saleStartDate: DateTime(2024, 3, 1),
  saleEndDate: DateTime(2024, 4, 1),
  eventId: 1,
  isBeforeSaleStartDate: false,
  isAfterSaleEndDate: false,
  quantityAvailable: 2,
  price: 150.0,
  prices: ToMany<TicketPrice>(items: [testTicketPrice2]),
  isAvailable: true,
  isSoldOut: false,
);

final testTicketPrice1 = TicketPrice(
  id: 1,
  label: 'Early Bird',
  price: 50.0,
  saleStartDate: DateTime(2024, 3, 1),
  saleEndDate: DateTime(2024, 3, 15),
  priceIncludingTaxesAndFees: 57.5,
  isDiscounted: false,
  taxTotal: 5.0,
  feeTotal: 2.5,
  isBeforeSaleStartDate: false,
  isAfterSaleEndDate: false,
  isAvailable: true,
  isSoldOut: false,
  quantityRemaining: 5,
);

final testTicketPrice2 = TicketPrice(
  id: 2,
  label: 'VIP Regular',
  price: 150.0,
  saleStartDate: DateTime(2024, 3, 1),
  saleEndDate: DateTime(2024, 4, 1),
  priceIncludingTaxesAndFees: 172.5,
  isDiscounted: false,
  taxTotal: 15.0,
  feeTotal: 7.5,
  isBeforeSaleStartDate: false,
  isAfterSaleEndDate: false,
  isAvailable: true,
  isSoldOut: false,
  quantityRemaining: 2,
);
