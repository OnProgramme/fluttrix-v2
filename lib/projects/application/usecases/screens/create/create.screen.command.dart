class CreateScreenCommand {
  final String projectId;
  final String name;
  final Map<String, dynamic> screenData;

  CreateScreenCommand({
    required this.projectId,
    required this.name,
    required this.screenData,
  });

  Map<String, dynamic> toJson(){
    return {
      "projectId": projectId,
      "name": name,
      "screenData": screenData,
    };
  }
}
