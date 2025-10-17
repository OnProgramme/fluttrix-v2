import 'dart:io';

abstract class FilePickerService {
  Future<List<File>> openGallery([multiple = false]);

  Future<File> openCamera();
  Future<List<File>> pickFiles({
    List<ExtensionFile> allowedExtensions = const [],
  });
  Future<File> pickFile({
    List<ExtensionFile> allowedExtensions = const [],
  });
}

enum ExtensionFile { jpg, pdf, doc, png }
