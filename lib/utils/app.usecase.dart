import 'package:fluttrix/auth/application/facades/auth.facade.dart';
import 'package:fluttrix/auth/application/usecases/login/login.async.dart';
import 'package:fluttrix/auth/application/usecases/logout/logout.async.dart';
import 'package:fluttrix/auth/application/usecases/register/register.async.dart';
import 'package:fluttrix/auth/domain/facades/i.auth.facade.dart';
import 'package:fluttrix/auth/domain/storage/auth.user.storage.dart';
import 'package:fluttrix/auth/infra/services/firebase.auth.service.dart';
import 'package:fluttrix/projects/application/usecases/all/get.all.projects.async.dart';
import 'package:fluttrix/projects/application/usecases/create/create.project.async.dart';
import 'package:fluttrix/projects/application/usecases/delete/delete.project.async.dart';
import 'package:fluttrix/projects/application/usecases/screens/create/create.screen.async.dart';
import 'package:fluttrix/projects/application/usecases/screens/delete_all/delete.all.screens.async.dart';
import 'package:fluttrix/projects/infra/repo/firestore/firestore.project.repository.dart';
import 'package:fluttrix/projects/infra/repo/firestore/firestore.screen.repository.dart';
import 'package:fluttrix/shared/injection/domain/dependency.injector.dart';
import 'package:fluttrix/user/application/facades/user.facade.dart';
import 'package:fluttrix/user/application/usecases/profile/get.profile.async.dart';
import 'package:fluttrix/user/application/usecases/save/save.user.async.dart';
import 'package:fluttrix/user/infra/repo/firestore.user.repository.dart';

class AppDependenciesUseCases {
  AppDependenciesUseCases._();

  static void init(DependencyInjector injector){
    final authUserStorage = injector.resolve<AuthUserStorage>();
    final authFacade = AuthFacade(FirebaseAuthService(), authUserStorage);
    final userFacade = UserFacade(FirestoreUserRepository(), authUserStorage);

    final firestoreProjects = FirestoreProjectRepository();
    final firestoreScreens = FirestoreScreenRepository();

    injector.register<LoginAsync>(LoginAsync(authFacade));
    injector.register<RegisterAsync>(RegisterAsync(authFacade));
    injector.register<LogoutAsync>(LogoutAsync(authFacade));
    injector.register<SaveUserAsync>(SaveUserAsync(userFacade));
    injector.register<GetProfileAsync>(GetProfileAsync(userFacade));
    injector.register<GetAllProjectsAsync>(GetAllProjectsAsync(firestoreProjects));
    injector.register<CreateProjectAsync>(CreateProjectAsync(firestoreProjects));
    injector.register<DeleteProjectAsync>(DeleteProjectAsync(firestoreProjects));
    injector.register<CreateScreenAsync>(CreateScreenAsync(firestoreScreens));
    injector.register<DeleteAllScreensAsync>(DeleteAllScreensAsync(firestoreScreens));
  }
}