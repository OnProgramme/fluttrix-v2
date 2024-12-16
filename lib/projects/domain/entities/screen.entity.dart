import 'package:fluttrix/shared/helpers/generate.uuid.dart';

class Screen {
  final String id;
  final String name;
  final String projectId;
  final Map<String, dynamic> data;
  Screen._({
    required this.id,
    required this.name,
    required this.projectId,
    required this.data,
  });

  Screen.create({
    String? id,
    required String name,
    required String projectId,
    required Map<String, dynamic> data,
  }) : this._(
            id: id ?? generateUuid(),
            name: name,
            projectId: projectId,
            data: data);

  Screen.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        projectId = json['projectId'],
        data = json['data'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'projectId': projectId,
        'data': data,
      };
}
