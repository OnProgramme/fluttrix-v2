import 'package:flutter/cupertino.dart';
import 'package:fluttrix/auth/application/usecases/login/login.async.dart';
import 'package:fluttrix/auth/application/usecases/login/login.command.dart';
import 'package:fluttrix/auth/application/usecases/register/register.async.dart';
import 'package:fluttrix/auth/application/usecases/register/register.command.dart';
import 'package:fluttrix/auth/domain/facades/i.auth.facade.dart';
import 'package:fluttrix/infrastructure/navigation/routes.dart';
import 'package:fluttrix/shared/form/validator/form.validator.dart';
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
  final registerAsync = RegisterAsync(AppDependencies.resolve<IAuthFacade>());

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
        Get.offAllNamed(Routes.HOME);
      });
    });
  }


  void handleNavigateToRegister() {
    Get.toNamed(Routes.REGISTER);
  }
}