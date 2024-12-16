import 'package:fluttrix/shared/events/domain/events/event.dart';

class ProjectDeleted extends Event{
  final String projectId;
  ProjectDeleted({required this.projectId});
}