import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/presentation/icons/choose.icon.controller.dart';
import 'package:fluttrix/utils/app.colors.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';

import 'infrastructure/navigation/navigation.dart';
import 'infrastructure/navigation/routes.dart';

void main() async {
  var initialRoute = await Routes.initialRoute;
  Get.put(ChooseIconController());
  runApp(Main(initialRoute));
}

class Main extends StatelessWidget {
  final String initialRoute;
  const Main(this.initialRoute, {super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute,
      getPages: Nav.routes,
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
            bodyLarge: TextStyle(color: Colors.white),
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
