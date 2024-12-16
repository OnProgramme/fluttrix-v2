import 'package:fluttrix/shared/services/storage/domain/core/base.storage.dart';
import 'package:fluttrix/user/domain/entities/user.entity.dart';

abstract class AuthUserStorage implements BaseStorage{
  Future<String?> getToken();
  Future<User?> getAuthUser();
  Future<void> saveToken(String token);
  Future<void> saveAuthUser(User user);
  Stream<User?> get onChangeAuthUser;
  Future<bool> get isLogin;
}