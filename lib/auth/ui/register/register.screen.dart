import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttrix/auth/ui/register/controllers/register.controller.dart';
import 'package:fluttrix/shared/components/button/app.button.dart';
import 'package:fluttrix/shared/components/consumer.async.dart';
import 'package:fluttrix/shared/components/textfield/app.textfield.dart';
import 'package:fluttrix/shared/form/validator/validator.dart';
import 'package:fluttrix/utils/app.colors.dart';
import 'package:fluttrix/utils/app.images.dart';
import 'package:get/get.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class RegisterScreen extends GetView<RegisterController> {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              AppImages.loginBg,
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: ClipRRect(
              child: SizedBox(
                width: 550,
                child: Stack(
                  children: [
                    Positioned.fill(child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.grey.withOpacity(0.3),
                            width: 1.5,
                          ),
                        ),
                      ),
                    )),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 70, vertical: 48),
                      child: ConsumerAsync(
                        notifier: [controller.registerAsync],
                        builder: (context, async) {
                          return Obx(
                            () => Form(
                              autovalidateMode: controller.form.validateMode,
                              key: controller.form.key,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Créer votre compte",
                                    style: textTheme.bodyLarge?.copyWith(
                                      fontSize: 40,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 50,
                                  ),
                                  AppTextField(
                                    controller: controller.emailController,
                                    label: "Email",
                                    prefixIcon: Icon(LucideIcons.mail),
                                    hint: "Entrer votre email",
                                    validators: [
                                      Validator.required(),
                                      Validator.email(),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  AppTextField(
                                    controller: controller.passwordController,
                                    label: "Mot de passe",
                                    prefixIcon: Icon(LucideIcons.key),
                                    hint: "Entrer votre mot de passe",
                                    isPassword: true,
                                    validators: [
                                      Validator.required(),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  AppTextField(
                                    label: "Confirmer le mot de passe",
                                    prefixIcon: Icon(LucideIcons.key),
                                    hint: "Entrer votre mot de passe",
                                    isPassword: true,
                                    validators: [
                                      Validator.required(),
                                      Validator.confirmPassword(controller: controller.passwordController),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  AppButton(
                                    title: async[0].isPending
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Inscription...",
                                                style: TextStyle(
                                                  color: AppColors.white,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              SizedBox(
                                                width: 20,
                                                height: 20,
                                                child:
                                                    CircularProgressIndicator(
                                                  strokeWidth: 2,
                                                  valueColor:
                                                      AlwaysStoppedAnimation(
                                                          AppColors.white),
                                                ),
                                              )
                                            ],
                                          )
                                        : "Inscription",
                                    onPressed: controller.form.handleSubmit,
                                    fullWidth: true,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Vous n'avez pas de compte? "),
                                      TextButton(
                                        onPressed:
                                            controller.handleNavigateToRegister,
                                        child: Text(
                                          "Inscrivez-vous",
                                          style: TextStyle(
                                            color: AppColors.buttonColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
