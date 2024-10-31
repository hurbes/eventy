import 'package:eventy/ui/widgets/common/connection/connection_aware.dart';
import 'package:flutter/material.dart';
import 'package:eventy/app/app.bottomsheets.dart';
import 'package:eventy/app/app.dialogs.dart';
import 'package:eventy/app/app.locator.dart';
import 'package:eventy/app/app.router.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await setupLocator(stackedRouter: stackedRouter);
  setupDialogUi();
  setupBottomSheetUi();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData.dark().copyWith(
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Colors.transparent,
        ),
      ),
      routerDelegate: stackedRouter.delegate(),
      routeInformationParser: stackedRouter.defaultRouteParser(),
      builder: (context, child) =>
          ConnectionAwareOverlay(child: child ?? const SizedBox.shrink()),
    );
  }
}
