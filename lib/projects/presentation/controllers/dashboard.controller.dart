import 'package:fluttrix/auth/application/usecases/logout/logout.async.dart';
import 'package:fluttrix/auth/domain/storage/auth.user.storage.dart';
import 'package:fluttrix/projects/application/usecases/all/get.all.projects.async.dart';
import 'package:fluttrix/projects/application/usecases/create/create.project.command.dart';
import 'package:fluttrix/projects/application/usecases/delete/delete.project.async.dart';
import 'package:fluttrix/shared/navigation/application/router.dart';
import 'package:fluttrix/shared/navigation/routes.dart';
import 'package:fluttrix/user/application/usecases/profile/get.profile.async.dart';
import 'package:fluttrix/utils/app.dependencies.dart';
import 'package:get/get.dart';

import '../../application/usecases/create/create.project.async.dart';

class DashboardControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() => DashboardController());
  }
}

class DashboardController extends GetxController {
  final createProjectAsync = AppDependencies.resolve<CreateProjectAsync>();
  final getAllProjectsAsync = AppDependencies.resolve<GetAllProjectsAsync>();
  final deleteProjectAsync = AppDependencies.resolve<DeleteProjectAsync>();
  final getProfileAsync = AppDependencies.resolve<GetProfileAsync>();
  final logoutAsync = AppDependencies.resolve<LogoutAsync>();
  final storage = AppDependencies.resolve<AuthUserStorage>();

  @override
  void onInit() {
    super.onInit();
    getProfileAsync.addListener(handleGetProjects);
    handleGetProjects();
  }

  @override
  void onClose() {
    getProfileAsync.removeListener(handleGetProjects);
    super.onClose();
  }

  void handleGetProjects() async {
    final user = await storage.getAuthUser();
    if (user == null) return;
    getAllProjectsAsync.execute(user.userId);
  }

  void handleCreateNewProject() async {
    final user = await storage.getAuthUser();
    if (user == null) return;
    createProjectAsync.execute(
        CreateProjectCommand(userId: user.userId, projectName: 'Mon projet'));
  }

  void handleLogout() async {
    await logoutAsync.execute();
    AppRouter.offAllNames(Routes.LOGIN);
  }

  void handleDeleteProject(project) {
    deleteProjectAsync.execute(project);
  }
}
