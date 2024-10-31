import 'dart:math';

String generateRandomImage({int width = 400, int height = 300}) {
  return "https://cors-anywhere.herokuapp.com/https://www.allaboutbirds.org/news/wp-content/uploads/2024/09/TOC-Autumn24-Ruby-crowned_Kinglet-Christopher_T-ML609692481-FI-480x360.jpg";
  final random = Random();
  final randomNumber = random.nextInt(1000);
  return 'https://picsum.photos/$width/$height?random=$randomNumber';
}
