import 'package:fluttrix/auth/domain/storage/auth.user.storage.dart';
import 'package:fluttrix/dashboard/application/usecases/all/get.all.projects.async.dart';
import 'package:fluttrix/dashboard/application/usecases/create/create.project.async.dart';
import 'package:fluttrix/dashboard/application/usecases/create/create.project.command.dart';
import 'package:fluttrix/user/application/usecases/profile/get.profile.async.dart';
import 'package:fluttrix/utils/app.dependencies.dart';
import 'package:get/get.dart';

class DashboardControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() => DashboardController());
  }
}

class DashboardController extends GetxController {
  final createProjectAsync = AppDependencies.resolve<CreateProjectAsync>();
  final getAllProjectsAsync = AppDependencies.resolve<GetAllProjectsAsync>();
  final getProfileAsync = AppDependencies.resolve<GetProfileAsync>();
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
}
