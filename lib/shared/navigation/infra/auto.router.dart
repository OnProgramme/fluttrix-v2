// import 'package:auto_route/annotations.dart';
// import 'package:auto_route/auto_route.dart';
// import 'package:fluttrix/auth/ui/login/controllers/login.controller.dart';
// import 'package:fluttrix/auth/ui/login/login.screen.dart';
// import 'package:fluttrix/auth/ui/register/controllers/register.controller.dart';
// import 'package:fluttrix/auth/ui/register/register.screen.dart';
// import 'package:fluttrix/shared/navigation/domain/navigator.service.dart';
// import 'package:fluttrix/shared/navigation/routes.dart';
//
// class AppAutoRouterService extends NavigatorService {
//   final router = AppRouter();
//   @override
//   Future<void> back([result]) async{
//     router.back();
//   }
//
//   @override
//   Future navigate(String route, {arguments}) async{
//     router.pushNamed(route);
//   }
// }
//
// @AutoRouterConfig()
// class AppRouter extends RootStackRouter {
//
//   @override
//   RouteType get defaultRouteType => RouteType.material();
//
//   @override
//   List<AutoRoute> get routes => [
//         AutoRoute(
//           page: PageInfo(
//             Routes.LOGIN,
//             builder: (data) {
//               LoginControllerBinding().dependencies();
//               return LoginScreen();
//             },
//           ),
//         ),
//         AutoRoute(
//           page: PageInfo(
//             Routes.REGISTER,
//             builder: (data) {
//               RegisterControllerBinding().dependencies();
//               return RegisterScreen();
//             },
//           ),
//         ),
//       ];
// }
