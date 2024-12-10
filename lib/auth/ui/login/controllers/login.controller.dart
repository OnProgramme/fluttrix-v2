import 'package:flutter/cupertino.dart';
import 'package:fluttrix/auth/application/usecases/login/login.async.dart';
import 'package:fluttrix/auth/application/usecases/login/login.command.dart';
import 'package:fluttrix/auth/domain/facades/i.auth.facade.dart';
import 'package:fluttrix/shared/form/validator/form.validator.dart';
import 'package:fluttrix/shared/navigation/application/router.dart';
import 'package:fluttrix/shared/navigation/routes.dart';
import 'package:fluttrix/utils/app.dependencies.dart';
import 'package:fluttrix/utils/message.dart';
import 'package:get/get.dart';

class LoginControllerBinding extends Bindings{


  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
          () => LoginController(),
    );
  }
}


class LoginController extends GetxController{
  late FormValidator form;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final loginAsync = AppDependencies.resolve<LoginAsync>();

  @override
  void onInit() {
    super.onInit();
    form = FormValidator(onSubmit: _handleLogin);
  }

  void _handleLogin() {
    if(loginAsync.isPending) return;
    loginAsync.execute(LoginCommand(emailController.text, passwordController.text)).then((response){
      response.fold((err){
        Message.errors("Email ou mot de passe incorrect");
      }, (result){
        AppRouter.navigate(Routes.HOME);
      });
    });
  }


  void handleNavigateToRegister() {
    AppRouter.navigate(Routes.REGISTER);
  }
}