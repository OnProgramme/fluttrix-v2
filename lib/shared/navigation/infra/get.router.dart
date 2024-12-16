import 'package:flutter/cupertino.dart';
import 'package:fluttrix/auth/ui/login/controllers/login.controller.dart';
import 'package:fluttrix/auth/ui/login/login.screen.dart';
import 'package:fluttrix/auth/ui/register/controllers/register.controller.dart';
import 'package:fluttrix/auth/ui/register/register.screen.dart';
import 'package:fluttrix/canvas/presentation/canvas/controllers/f.canvas.controller.dart';
import 'package:fluttrix/canvas/presentation/canvas/controllers/ftrix.toolbar.settings.controller.dart';
import 'package:fluttrix/canvas/presentation/controllers/home.controller.binding.dart';
import 'package:fluttrix/canvas/presentation/home.screen.dart';
import 'package:fluttrix/presentation/preview_code/controllers/preview_code.controller.dart';
import 'package:fluttrix/presentation/preview_code/preview_code.screen.dart';
import 'package:fluttrix/projects/presentation/controllers/dashboard.controller.dart';
import 'package:fluttrix/projects/presentation/dashboard.screen.dart';
import 'package:fluttrix/shared/navigation/domain/navigator.service.dart';
import 'package:fluttrix/shared/navigation/middlewares/auth.middleware.dart';
import 'package:fluttrix/shared/navigation/middlewares/non.auth.middleware.dart';
import 'package:fluttrix/shared/navigation/routes.dart';
import 'package:get/get.dart';

class GetRouterService implements NavigatorService {
  @override
  Future<void> back([result]) async {
    Get.back(result: result);
  }

  @override
  Future navigate(String route, {arguments}) async {
    Get.toNamed(route, arguments: arguments);
  }

  @override
  Future ofAllNames(String route, {arguments}) async {
    Get.offAllNamed(route, arguments: arguments);
  }
}

class GetRouter {
  static List<GetPage> routes = [
    GetPage(
      name: Routes.LOGIN,
      page: () => const LoginScreen(),
      binding: LoginControllerBinding(),
      middlewares: [NonAuthMiddleware()],
    ),
    GetPage(
      name: Routes.REGISTER,
      page: () => const RegisterScreen(),
      binding: RegisterControllerBinding(),
      middlewares: [NonAuthMiddleware()],
    ),
    GetPage(
      name: Routes.APP,
      page: () => Container(),
      children: [
        GetPage(
          name: Routes.DASHBOARD,
          page: () => const DashboardScreen(),
          binding: DashboardControllerBinding(),
        ),
        GetPage(
            name: Routes.HOME,
            page: () => const HomeScreen(),
            binding: HomeControllerBinding(),
            bindings: [
              FCanvasControllerBinding(),
              FTrixToolbarSettingsControllerBinding(),
            ]),
        GetPage(
          name: Routes.PREVIEW_CODE,
          page: () => const PreviewCodeScreen(),
          binding: PreviewCodeControllerBinding(),
        ),
      ],
      middlewares: [AuthMiddleware()],
    )
  ];
}
