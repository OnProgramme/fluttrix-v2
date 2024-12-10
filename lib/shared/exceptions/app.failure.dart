import 'package:flutter/foundation.dart';
// ignore: depend_on_referenced_packages
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app.failure.freezed.dart';

@freezed
class AppFailure with _$AppFailure {
  factory AppFailure.emailAlreadyInUse() = EmailAlreadyInUse;
  factory AppFailure.emailOrPasswordInvalid() = EmailOrPasswordInvalid;
  factory AppFailure.internetConnection() = InternetConnection;
  factory AppFailure.userNotExist() = UserNotExist;
  factory AppFailure.failSaved() = FailSaved;
}