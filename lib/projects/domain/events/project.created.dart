import 'package:fluttrix/shared/events/domain/events/event.dart';

class ProjectCreated extends Event{
  final String projectId;
  ProjectCreated({required this.projectId});
}