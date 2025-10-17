import 'package:fluttrix/auth/domain/storage/auth.user.storage.dart';
import 'package:fluttrix/utils/app.dependencies.dart';

class Routes {
  static Future<String> get initialRoute async {
    final userStorage = AppDependencies.get<AuthUserStorage>();
    return (await userStorage.isLogin) ? DASHBOARD : LOGIN;
  }

  static const APP = '/';
  static const DASHBOARD = '${APP}dashboard';
  static const PROJECT_DETAILS = '${APP}project-details';
  static const PREVIEW_CODE = '${APP}preview-code';
  static const NOT_FOUND = '${APP}not-found';
  static const LOGIN = '/login';
  static const REGISTER = '/register';
}
