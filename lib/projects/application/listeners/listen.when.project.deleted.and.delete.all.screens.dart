import 'package:fluttrix/projects/application/usecases/screens/delete_all/delete.all.screens.async.dart';
import 'package:fluttrix/projects/application/usecases/screens/delete_all/delete.all.screens.command.dart';
import 'package:fluttrix/projects/domain/events/project.deleted.dart';
import 'package:fluttrix/shared/events/domain/interfaces/event.listener.dart';

class ListenWhenProjectDeletedAndDeleteAllScreens
    extends EventListener<ProjectDeleted> {
  final DeleteAllScreensAsync useCase;

  ListenWhenProjectDeletedAndDeleteAllScreens({required this.useCase});

  @override
  void handle(ProjectDeleted event) {
    useCase.execute(DeleteAllScreensCommand(projectId: event.projectId));
  }
}
