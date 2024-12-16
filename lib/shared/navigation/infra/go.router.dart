// import 'package:fluttrix/auth/ui/login/controllers/login.controller.dart';
// import 'package:fluttrix/auth/ui/login/login.screen.dart';
// import 'package:fluttrix/auth/ui/register/controllers/register.controller.dart';
// import 'package:fluttrix/auth/ui/register/register.screen.dart';
// import 'package:fluttrix/canvas/presentation/canvas/controllers/f.canvas.controller.dart';
// import 'package:fluttrix/canvas/presentation/canvas/controllers/ftrix.toolbar.settings.controller.dart';
// import 'package:fluttrix/canvas/presentation/controllers/home.controller.binding.dart';
// import 'package:fluttrix/canvas/presentation/home.screen.dart';
// import 'package:fluttrix/shared/navigation/domain/navigator.service.dart';
// import 'package:fluttrix/shared/navigation/routes.dart';
// import 'package:get/get.dart';
// import 'package:go_router/go_router.dart';
//
// class GoRouterNavigatorService implements NavigatorService {
//   final GoRouter router;
//   GoRouterNavigatorService(this.router);
//
//   @override
//   Future<void> back([result]) async {
//     router.pop();
//   }
//
//   @override
//   Future navigate(String route, {arguments}) async {
//     router.push(route);
//   }
// }
//
// class CustomGoRoute extends GoRoute {
//   final List<Bindings>? bindings;
//   CustomGoRoute({
//     required super.path,
//     super.builder,
//     super.routes,
//     this.bindings,
//   }) {
//     bindings?.forEach((binding){
//       binding.dependencies();
//     });
//   }
// }
//
//
// GoRouter goRoutes(String initialRoute) => GoRouter(
//   initialLocation: initialRoute,
//   routes: [
//     CustomGoRoute(
//       bindings: [LoginControllerBinding()],
//       path: Routes.LOGIN,
//       builder: (context, state) {
//         return LoginScreen();
//       },
//     ),
//     CustomGoRoute(
//       bindings: [RegisterControllerBinding()],
//       path: Routes.REGISTER,
//       builder: (context, state) => RegisterScreen(),
//     ),
//     CustomGoRoute(
//         path: Routes.APP,
//         builder: (context, state) => RegisterScreen(),
//         routes: [
//           CustomGoRoute(
//             path: Routes.HOME,
//             builder: (context, state) => HomeScreen(),
//             bindings: [
//               HomeControllerBinding(),
//               FCanvasControllerBinding(),
//               FTrixToolbarSettingsControllerBinding(),
//             ]
//           )
//         ]),
//   ],
// );
