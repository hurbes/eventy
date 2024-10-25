import 'package:eventy/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:eventy/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:eventy/ui/views/home/home_view.dart';
import 'package:eventy/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
// @stacked-import

@StackedApp(
  routes: [
    CustomRoute(
      page: HomeView,
      transitionsBuilder: TransitionsBuilders.fadeIn,
    ),
    CustomRoute(
      page: StartupView,
      initial: true,
      transitionsBuilder: TransitionsBuilders.fadeIn,
    ),
    // @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: RouterService),
    // @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    // @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    // @stacked-dialog
  ],
)
class App {}
