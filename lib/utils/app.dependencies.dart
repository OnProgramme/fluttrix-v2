import 'package:fluttrix/auth/application/facades/auth.facade.dart';
import 'package:fluttrix/auth/application/usecases/login/login.async.dart';
import 'package:fluttrix/auth/application/usecases/register/register.async.dart';
import 'package:fluttrix/auth/domain/facades/i.auth.facade.dart';
import 'package:fluttrix/auth/domain/storage/auth.user.storage.dart';
import 'package:fluttrix/auth/infra/services/auth.user.storage.service.dart';
import 'package:fluttrix/auth/infra/services/firebase.auth.service.dart';
import 'package:fluttrix/canvas/presentation/icons/choose.icon.controller.dart';
import 'package:fluttrix/dashboard/application/usecases/all/get.all.projects.async.dart';
import 'package:fluttrix/dashboard/application/usecases/create/create.project.async.dart';
import 'package:fluttrix/dashboard/infra/repo/firestore/firestore.project.repository.dart';
import 'package:fluttrix/shared/events/domain/events/event.name.dart';
import 'package:fluttrix/shared/events/domain/interfaces/event.dispatcher.dart';
import 'package:fluttrix/shared/events/infra/in.memory.event.dispatcher.dart';
import 'package:fluttrix/shared/injection/domain/dependency.injector.dart';
import 'package:fluttrix/shared/navigation/domain/navigator.service.dart';
import 'package:fluttrix/shared/navigation/infra/auto.router.dart';
import 'package:fluttrix/shared/navigation/infra/get.router.dart';
import 'package:fluttrix/shared/navigation/infra/go.router.dart';
import 'package:fluttrix/shared/navigation/routes.dart';
import 'package:fluttrix/shared/services/storage/infra/services/get.storage.service.dart';
import 'package:fluttrix/user/application/facades/user.facade.dart';
import 'package:fluttrix/user/application/listeners/get.user.to.firestore.after.login.listener.dart';
import 'package:fluttrix/user/application/listeners/save.user.to.firestore.after.register.listener.dart';
import 'package:fluttrix/user/application/usecases/profile/get.profile.async.dart';
import 'package:fluttrix/user/application/usecases/save/save.user.async.dart';
import 'package:fluttrix/user/domain/facades/i.user.facade.dart';
import 'package:fluttrix/user/domain/repo/i.user.repository.dart';
import 'package:fluttrix/user/infra/repo/firestore.user.repository.dart';
import 'package:get/get.dart';

class AppDependencies {
  static late DependencyInjector _injector;
  AppDependencies._();

  static Future<void> init(DependencyInjector injector) async {
    _injector = injector;
    final dispatcher = InMemoryEventDispatcher();
    injector.register<NavigatorService>(GetRouterService());
    injector.register<EventDispatcher>(dispatcher);
    final storageService = GetStorageService();
    final authUserStorage = AuthUserStorageService(storageService);

    injector.register<AuthUserStorage>(authUserStorage);
    injector.register<IAuthFacade>(AuthFacade(FirebaseAuthService()));
    injector.register<IUserFacade>(UserFacade(FirestoreUserRepository(), authUserStorage));

    _initUseCase(injector);
    _subscribeToEvents(dispatcher);



    Get.put(ChooseIconController());
  }

  static T resolve<T>() {
    return _injector.resolve<T>();
  }

  static void _initUseCase(DependencyInjector injector){
    final userFacade = resolve<IUserFacade>();
    final authFacade = resolve<IAuthFacade>();
    final firestoreProjects = FirestoreProjectRepository();

    injector.register<LoginAsync>(LoginAsync(authFacade));
    injector.register<RegisterAsync>(RegisterAsync(authFacade));
    injector.register<SaveUserAsync>(SaveUserAsync(userFacade));
    injector.register<GetProfileAsync>(GetProfileAsync(userFacade));
    injector.register<GetProfileAsync>(GetProfileAsync(userFacade));

    injector.register<GetAllProjectsAsync>(GetAllProjectsAsync(firestoreProjects));
    injector.register<CreateProjectAsync>(CreateProjectAsync(firestoreProjects));
  }

  static void _subscribeToEvents(EventDispatcher dispatcher){
    final authStorage = resolve<AuthUserStorage>();
    dispatcher.subscribe(EventName.login, GetUserToFirestoreAfterLoginListener(
      useCase: resolve<GetProfileAsync>(),
      storage: authStorage,
    ));
    dispatcher.subscribe(EventName.register, SaveUserToFirestoreAfterRegisterListener(
      useCase: resolve<SaveUserAsync>(),
      storage: authStorage,
    ));
  }
}
