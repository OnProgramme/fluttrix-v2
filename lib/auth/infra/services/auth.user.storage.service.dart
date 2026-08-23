import 'package:fluttrix/auth/domain/storage/auth.user.storage.dart';
import 'package:fluttrix/shared/services/storage/domain/core/local.storage.dart';
import 'package:fluttrix/user/domain/entities/user.entity.dart';

const _USER_KEY = 'user-key';

class AuthUserStorageService implements AuthUserStorage{
  final LocalStorage _storage;
    AuthUserStorageService(this._storage);

  @override
  Future<void> clear() async{
    await _storage.delete(_USER_KEY);
  }

  @override
  Future<User?> getAuthUser() async{
    final data = await _storage.read(_USER_KEY);
    if(data == null) return null;
    return User.fromJson(data);
  }

  @override
  Future<String?> getToken() {
    throw UnimplementedError();
  }

  @override
  Future<bool> get isLogin async => (await getAuthUser()) != null;

  @override
  Stream<User?> get onChangeAuthUser => throw UnimplementedError();

  @override
  Future<void> saveAuthUser(User user) async{
    await _storage.write(_USER_KEY, user.toJson());
  }

  @override
  Future<void> saveToken(String token) {
    throw UnimplementedError();
  }

}