import 'package:fluttrix/projects/application/usecases/screens/create/create.screen.async.dart';
import 'package:fluttrix/projects/domain/events/project.created.dart';
import 'package:fluttrix/shared/events/domain/interfaces/event.listener.dart';

class ListenWhenProjectCreatedAndCreateFirstScreen
    extends EventListener<ProjectCreated> {
  final CreateScreenAsync useCase;

  ListenWhenProjectCreatedAndCreateFirstScreen({
    required this.useCase,
  });

  @override
  void handle(ProjectCreated event) {}
}
