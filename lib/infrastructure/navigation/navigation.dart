import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/presentation/canvas/controllers/f.canvas.controller.dart';
import 'package:fluttrix/canvas/presentation/canvas/controllers/ftrix.toolbar.settings.controller.dart';
import 'package:fluttrix/canvas/presentation/controllers/home.controller.binding.dart';
import 'package:fluttrix/canvas/presentation/home.screen.dart';

import 'package:get/get.dart';

import '../../config.dart';
import 'routes.dart';

class EnvironmentsBadge extends StatelessWidget {
  final Widget child;
  const EnvironmentsBadge({required this.child});
  @override
  Widget build(BuildContext context) {
    var env = ConfigEnvironments.getEnvironments()['env'];
    return env != Environments.PRODUCTION
        ? Banner(
            location: BannerLocation.topStart,
            message: env!,
            color: env == Environments.QAS ? Colors.blue : Colors.purple,
            child: child,
          )
        : SizedBox(child: child);
  }
}

class Nav {
  static List<GetPage> routes = [
    GetPage(
        name: Routes.HOME,
        page: () => const HomeScreen(),
        binding: HomeControllerBinding(),
        bindings: [
          FCanvasControllerBinding(), FTrixToolbarSettingsControllerBinding(),
        ]),
  ];
}
