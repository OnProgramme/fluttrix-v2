import 'package:fluttrix/shared/helpers/generate.uuid.dart';

class Component {
  final String id;
  final String name;
  final String projectId;
  final Map<String, dynamic> data;
  Component._({
    required this.id,
    required this.name,
    required this.projectId,
    required this.data,
  });

  Component.create({
    String? id,
    required String name,
    required String projectId,
    required Map<String, dynamic> data,
  }) : this._(
            id: id ?? generateUuid(),
            name: name,
            projectId: projectId,
            data: data);

  factory Component.fromJson(Map<String, dynamic> json) {
    return Component._(
      id: json['id'],
      name: json['name'],
      projectId: json['projectId'],
      data: Map<String, dynamic>.from(json['data'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'projectId': projectId,
        'data': data,
      };
}
