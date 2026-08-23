import 'package:flutter/material.dart';
import 'package:fluttrix/shared/navigation/routes.dart';
import 'package:get/get.dart';

class CheckProjectIdMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if(Get.parameters.containsKey('projectId') != true){
      return RouteSettings(name: Routes.DASHBOARD);
    }
    return null;
  }
}