import 'package:fluttrix/auth/domain/storage/auth.user.storage.dart';
import 'package:fluttrix/auth/infra/services/auth.user.storage.service.dart';
import 'package:fluttrix/canvas/presentation/icons/choose.icon.controller.dart';
import 'package:fluttrix/projects/application/listeners/listen.when.project.created.and.create.first.screen.dart';
import 'package:fluttrix/projects/application/listeners/listen.when.project.deleted.and.delete.all.screens.dart';
import 'package:fluttrix/projects/application/usecases/screens/create/create.screen.async.dart';
import 'package:fluttrix/projects/application/usecases/screens/delete_all/delete.all.screens.async.dart';
import 'package:fluttrix/shared/events/domain/events/event.name.dart';
import 'package:fluttrix/shared/events/domain/interfaces/event.dispatcher.dart';
import 'package:fluttrix/shared/events/infra/in.memory.event.dispatcher.dart';
import 'package:fluttrix/shared/injection/domain/dependency.injector.dart';
import 'package:fluttrix/shared/navigation/domain/navigator.service.dart';
import 'package:fluttrix/shared/navigation/infra/get.router.dart';
import 'package:fluttrix/shared/services/storage/infra/services/get.storage.service.dart';
import 'package:fluttrix/user/application/listeners/get.user.to.firestore.after.login.listener.dart';
import 'package:fluttrix/user/application/listeners/save.user.to.firestore.after.register.listener.dart';
import 'package:fluttrix/user/application/usecases/profile/get.profile.async.dart';
import 'package:fluttrix/user/application/usecases/save/save.user.async.dart';
import 'package:fluttrix/utils/app.usecase.dart';
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

    injector.register<AuthUserStorage>(AuthUserStorageService(storageService));

    AppDependenciesUseCases.init(injector);
    _subscribeToEvents(dispatcher);



    Get.put(ChooseIconController());
  }

  static T get<T>() {
    return _injector.resolve<T>();
  }


  static void _subscribeToEvents(EventDispatcher dispatcher){
    final authStorage = get<AuthUserStorage>();
    dispatcher.subscribe(EventName.login, GetUserToFirestoreAfterLoginListener(
      useCase: get<GetProfileAsync>(),
      storage: authStorage,
    ));
    dispatcher.subscribe(EventName.register, SaveUserToFirestoreAfterRegisterListener(
      useCase: get<SaveUserAsync>(),
      storage: authStorage,
    ));
    dispatcher.subscribe(EventName.projectCreated, ListenWhenProjectCreatedAndCreateFirstScreen(
      useCase: get<CreateScreenAsync>(),
    ));
    dispatcher.subscribe(EventName.projectDeleted, ListenWhenProjectDeletedAndDeleteAllScreens(
      useCase: get<DeleteAllScreensAsync>(),
    ));
  }
}
