import 'package:flutter/material.dart';
import 'package:get/get.dart';

typedef ValidatorType = String? Function(String value);
typedef Validators = List<ValidatorType>;

class Validator {
  Validator._();

  static ValidatorType required({String? msg}) {
    return (String value) {
      return value.isEmpty ? (msg ?? "Ce champ est requis") : null;
    };
  }

  static ValidatorType number({String? msg, double? min}) {
    return (String value) {
      if (required()(value) != null) {
        return required()(value);
      }
      if (num.tryParse(value) == null) {
        return "Ce champ doit être un nombre";
      }
    };
  }

  static ValidatorType email({String? msg}) {
    return (String value) {
      if (value.trim().isEmpty) return null;
      return RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
              .hasMatch(value.trim())
          ? null
          : (msg ?? "Le format de l'email est incorrect");
    };
  }

  static ValidatorType confirmPassword(
      {required TextEditingController controller, String? msg}) {
    return (String value) {
      if (value != controller.text) {
        return msg ?? "Les mots de passes sont différents";
      }
      return null;
    };
  }
}
