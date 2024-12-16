import 'package:fluttrix/shared/helpers/generate.uuid.dart';

class Project {
  String id;
  String userId;
  String name;
  Project._({required this.userId, required this.id, required this.name});

  factory Project.create(
          {required String userId,
          required String projectName,
          String? projectId}) =>
      Project._(
          userId: userId, id: projectId ?? generateUuid(), name: projectName);

  Project.fromJson(Map<String, dynamic> json)
      : userId = json['userId'],
        id = json['id'],
        name = json['name'];

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "userId": userId,
      "name": name,
    };
  }
}
