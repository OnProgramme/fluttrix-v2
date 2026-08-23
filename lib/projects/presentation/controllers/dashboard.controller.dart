import 'package:fluttrix/auth/application/usecases/logout/logout.async.dart';
import 'package:fluttrix/auth/domain/storage/auth.user.storage.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.canvas.dart';
import 'package:fluttrix/projects/application/usecases/all/get.all.projects.async.dart';
import 'package:fluttrix/projects/application/usecases/create/create.project.command.dart';
import 'package:fluttrix/projects/application/usecases/delete/delete.project.async.dart';
import 'package:fluttrix/projects/application/usecases/screens/create/create.screen.async.dart';
import 'package:fluttrix/projects/application/usecases/screens/create/create.screen.command.dart';
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
  final createProjectAsync = AppDependencies.get<CreateProjectAsync>();
  final createScreenAsync = AppDependencies.get<CreateScreenAsync>();
  final getAllProjectsAsync = AppDependencies.get<GetAllProjectsAsync>();
  final deleteProjectAsync = AppDependencies.get<DeleteProjectAsync>();
  final getProfileAsync = AppDependencies.get<GetProfileAsync>();
  final logoutAsync = AppDependencies.get<LogoutAsync>();
  final storage = AppDependencies.get<AuthUserStorage>();

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
    createProjectAsync
        .execute(CreateProjectCommand(
            userId: user.userId, projectName: 'Mon projet'))
        .then((response) {
      response.fold((err) {}, (result) {
        createScreenAsync.execute(
          CreateScreenCommand(
            projectId: result.id,
            name: "HomePage",
            screenData: FTrixCanvas().toJson(),
          ),
        ).then((response){
          AppRouter.navigate(Routes.PROJECT_DETAILS, parameters: {
            'projectId': result.id,
          });
        });
      });
    });
  }

  void handleLogout() async {
    await logoutAsync.execute();
    AppRouter.offAllNames(Routes.LOGIN);
  }

  void handleDeleteProject(project) {
    deleteProjectAsync.execute(project);
  }

  void handleOpenProject(String id) {
    AppRouter.navigate(Routes.PROJECT_DETAILS, parameters: {
      'projectId': id,
    });
  }
}
