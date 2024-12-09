String abbreviateCamelCase(String input) {
  final RegExp camelCaseRegex = RegExp(r'[A-Z]?[a-z]+|[A-Z]+(?![a-z])');
  final matches = camelCaseRegex.allMatches(input);
  return matches.map((match) => match.group(0)!.substring(0, 1).toUpperCase()).join();
}