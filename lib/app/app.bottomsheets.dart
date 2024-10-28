// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedBottomsheetGenerator
// **************************************************************************

import 'package:stacked_services/stacked_services.dart';

import 'app.locator.dart';
import '../ui/bottom_sheets/notice/notice_sheet.dart';
import '../ui/bottom_sheets/payment_fail/payment_fail_sheet.dart';
import '../ui/bottom_sheets/payment_success/payment_success_sheet.dart';

enum BottomSheetType {
  notice,
  paymentFail,
  paymentSuccess,
}

void setupBottomSheetUi() {
  final bottomsheetService = locator<BottomSheetService>();

  final Map<BottomSheetType, SheetBuilder> builders = {
    BottomSheetType.notice: (context, request, completer) =>
        NoticeSheet(request: request, completer: completer),
    BottomSheetType.paymentFail: (context, request, completer) =>
        PaymentFailSheet(request: request, completer: completer),
    BottomSheetType.paymentSuccess: (context, request, completer) =>
        PaymentSuccessSheet(request: request, completer: completer),
  };

  bottomsheetService.setCustomSheetBuilders(builders);
}
