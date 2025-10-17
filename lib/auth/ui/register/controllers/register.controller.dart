import 'package:flutter/cupertino.dart';
import 'package:fluttrix/auth/application/usecases/register/register.async.dart';
import 'package:fluttrix/auth/application/usecases/register/register.command.dart';
import 'package:fluttrix/shared/form/validator/form.validator.dart';
import 'package:fluttrix/shared/navigation/application/router.dart';
import 'package:fluttrix/shared/navigation/routes.dart';
import 'package:fluttrix/utils/app.dependencies.dart';
import 'package:fluttrix/utils/message.dart';
import 'package:get/get.dart';

class RegisterControllerBinding extends Bindings{

@override
void dependencies() {
  Get.lazyPut<RegisterController>(
        () => RegisterController(),
  );
}
}


class RegisterController extends GetxController{

  late FormValidator form;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final registerAsync = AppDependencies.get<RegisterAsync>();

  @override
  void onInit() {
    super.onInit();
    form = FormValidator(onSubmit: _handleLogin);
  }

  void _handleLogin() {
    if(registerAsync.isPending) return;
    registerAsync.execute(RegisterCommand(emailController.text, passwordController.text)).then((response){
      response.fold((err){
        Message.errors("Email ou mot de passe incorrect");
      }, (result){
        AppRouter.navigate(Routes.DASHBOARD);
      });
    });
  }


  void handleNavigateToRegister() {
    AppRouter.back();
  }
}