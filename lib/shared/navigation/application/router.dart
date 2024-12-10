import 'package:fluttrix/shared/navigation/domain/navigator.service.dart';
import 'package:fluttrix/utils/app.dependencies.dart';

class AppRouter{
  AppRouter._();
  static final _navigator = AppDependencies.resolve<NavigatorService>();
  static Future<dynamic> navigate(String route, {dynamic argument}){
    return _navigator.navigate(route, arguments: argument);
  }
  static void back([dynamic result]){
    _navigator.back(result);
  }
}