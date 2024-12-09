import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class FormValidator {
  final VoidCallback _onSubmit;
  final bool disableValidation;

  FormValidator(
      {required void Function() onSubmit, this.disableValidation = false})
      : _onSubmit = onSubmit;

  final _isInvalidForm = false.obs;
  final key = GlobalKey<FormState>();

  bool get isValid {
    return key.currentState?.validate() ?? false;
  }

  void handleSubmit() {
    if (!isValid && !disableValidation) {
      _isInvalidForm(true);
      return;
    }
    _isInvalidForm(false);
    _onSubmit.call();
  }

  void reset() {
    key.currentState?.reset();
  }

  AutovalidateMode get validateMode => _isInvalidForm.value
      ? AutovalidateMode.always
      : AutovalidateMode.disabled;
}
