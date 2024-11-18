import 'dart:math';

String generateRandomImage({int width = 400, int height = 300}) {
  final random = Random();
  final randomNumber = random.nextInt(1000);
  return 'https://picsum.photos/$width/$height?random=$randomNumber';
}
