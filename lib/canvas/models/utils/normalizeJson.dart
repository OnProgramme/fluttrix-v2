Map<String, dynamic> normalizeJson(Map<dynamic, dynamic> input) {
  return input.map((key, value) {
    if (value is Map) {
      return MapEntry(key.toString(), normalizeJson(value));
    } else if (value is List) {
      return MapEntry(
        key.toString(),
        value.map((e) => e is Map ? normalizeJson(e) : e).toList(),
      );
    } else {
      return MapEntry(key.toString(), value);
    }
  });
}