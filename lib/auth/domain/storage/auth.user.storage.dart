import 'package:fluttrix/auth/domain/entities/auth.user.entity.dart';
import 'package:fluttrix/shared/services/storage/domain/core/base.storage.dart';
import 'package:fluttrix/user/domain/entities/user.entity.dart';

abstract class AuthUserStorage implements BaseStorage{
  Future<String?> getToken();
  Future<AuthUser?> getAuthUser();
  Future<void> saveToken(String token);
  Future<void> saveAuthUser(User user);
  Stream<AuthUser?> get onChangeAuthUser;
  Future<bool> get isLogin;
}