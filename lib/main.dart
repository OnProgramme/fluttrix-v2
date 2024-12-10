import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/presentation/icons/choose.icon.controller.dart';
import 'package:fluttrix/firebase_options.dart';
import 'package:fluttrix/shared/injection/infra/memory.injector.dart';
import 'package:fluttrix/shared/navigation/infra/auto.router.dart';
import 'package:fluttrix/shared/navigation/infra/get.router.dart';
import 'package:fluttrix/shared/navigation/infra/go.router.dart';
import 'package:fluttrix/shared/navigation/routes.dart';
import 'package:fluttrix/utils/app.colors.dart';
import 'package:fluttrix/utils/app.dependencies.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:oktoast/oktoast.dart';
import 'package:url_strategy/url_strategy.dart';

void main() async {
  await GetStorage.init();
  setPathUrlStrategy();
  await AppDependencies.init(MemoryInjector());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  var initialRoute = await Routes.initialRoute;
  runApp(Main(initialRoute));
}

class Main extends StatelessWidget {
  final String initialRoute;
  const Main(this.initialRoute, {super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: initialRoute,
      // routerConfig: goRoutes(initialRoute),
      getPages: GetRouter.routes,
      debugShowCheckedModeBanner: false,
      builder: (context, child) => OKToast(child: child ?? const SizedBox()),
      theme: ThemeData(
          scaffoldBackgroundColor: AppColors.background,
          dialogBackgroundColor: AppColors.primary,
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          radioTheme: RadioThemeData(
            overlayColor: WidgetStatePropertyAll(Colors.transparent),
            fillColor: WidgetStatePropertyAll(AppColors.grey),
          ),
          textTheme: TextTheme(
            bodyLarge: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            bodyMedium: TextStyle(color: Colors.white),
            bodySmall: TextStyle(color: Colors.white),
          ),
          popupMenuTheme: PopupMenuThemeData(
            color: AppColors.primary,
            textStyle: TextStyle(color: Colors.white),
          ),
          switchTheme: SwitchThemeData(
            thumbColor: WidgetStatePropertyAll(Colors.white),
            // trackColor: WidgetStatePropertyAll(AppColors.buttonColor),
          ),
          listTileTheme: ListTileThemeData(
            textColor: Colors.white,
            iconColor: Colors.white,
          ),
          checkboxTheme: CheckboxThemeData(
              // overlayColor: WidgetStatePropertyAll(AppColors.buttonColor),

              )),
    );
  }
}
