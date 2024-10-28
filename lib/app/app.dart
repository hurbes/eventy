import 'package:dio/dio.dart';
import 'package:eventy/core/interfaces/i_api_service.dart';
import 'package:eventy/core/interfaces/i_database_service.dart';
import 'package:eventy/core/models/event/event.dart';
import 'package:eventy/core/repository/app_repository.dart';
import 'package:eventy/core/repository/event_repository.dart';
import 'package:eventy/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:eventy/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:eventy/ui/views/home/home_view.dart';
import 'package:eventy/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:eventy/core/services/payment_service.dart';
import 'package:eventy/core/services/api_service.dart';
import 'package:eventy/core/services/database_service.dart';
import 'package:eventy/core/services/objectbox_service.dart';
import 'package:eventy/core/services/dio_service.dart';
import 'package:eventy/ui/views/event_details/event_details_view.dart';
import 'package:eventy/ui/views/ticket_selection/ticket_selection_view.dart';
import 'package:eventy/core/services/order_service.dart';
import 'package:eventy/ui/views/details_form/details_form_view.dart';
import 'package:eventy/ui/views/map_navigation/map_navigation_view.dart';
import 'package:eventy/ui/views/search_view/search_view_view.dart';
import 'package:eventy/core/services/stripe_service.dart';
import 'package:eventy/ui/bottom_sheets/payment_fail/payment_fail_sheet.dart';
import 'package:eventy/ui/bottom_sheets/payment_success/payment_success_sheet.dart';
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
    MaterialRoute(page: EventDetailsView),
    CustomRoute(
      page: TicketSelectionView,
      transitionsBuilder: TransitionsBuilders.slideBottom,
    ),
    MaterialRoute(page: DetailsFormView),
    MaterialRoute(page: MapNavigationView, fullscreenDialog: true),
    MaterialRoute(page: SearchView, fullscreenDialog: true),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: RouterService),
    LazySingleton(classType: PaymentService),
    LazySingleton(classType: ApiService, asType: IApiService),
    LazySingleton(classType: DatabaseService, asType: IDatabaseService),
    InitializableSingleton(classType: ObjectboxService),
    LazySingleton(
        classType: DioService, resolveUsing: DioService.init, asType: Dio),
    LazySingleton(classType: EventRepository, asType: Repository<Event>),
    LazySingleton(classType: OrderService),
    LazySingleton(classType: StripeService),
// @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    StackedBottomsheet(classType: PaymentFailSheet),
    StackedBottomsheet(classType: PaymentSuccessSheet),
// @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    // @stacked-dialog
  ],
  logger: StackedLogger(),
)
class App {}
