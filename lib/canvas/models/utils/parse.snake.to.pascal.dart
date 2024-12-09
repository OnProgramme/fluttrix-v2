String parseSnakeToPascal(String input) {
  return input.split(RegExp('[_-]'))
      .map((word) => word.isNotEmpty
      ? word[0].toUpperCase() + word.substring(1)
      : '')
      .join('');
}