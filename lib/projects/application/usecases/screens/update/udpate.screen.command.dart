class UpdateScreenCommand {
  String screenId;
  String? name;
  Map<String, dynamic>? data;

  UpdateScreenCommand({
    required this.screenId,
    this.data,
    this.name,
  });

  Map<String, dynamic> toJson() {
    return {
      "data": data,
      "name": name,
    }..removeWhere((k, v) => v == null);
  }
}
