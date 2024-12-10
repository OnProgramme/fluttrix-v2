import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttrix/shared/navigation/routes.dart';
import 'package:get/get.dart';

class NonAuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (FirebaseAuth.instance.currentUser != null) {
      return RouteSettings(name: Routes.DASHBOARD);
    }
    return null;
  }
}