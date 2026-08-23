class CreateComponentCommand {
  final String projectId;
  final String name;
  final Map<String, dynamic> data;

  CreateComponentCommand({
    required this.projectId,
    required this.name,
    required this.data,
  });
}
