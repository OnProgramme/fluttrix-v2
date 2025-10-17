import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:fluttrix/shared/exceptions/fail.to.import.file.exception.dart';
import 'package:fluttrix/shared/services/files/domain/file.picker.service.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as Im;
import 'package:image_picker/image_picker.dart';

class FilePickerPackageService implements FilePickerService {
  final imagePicker = ImagePicker();
  final filePicker = FilePicker.platform;

  @override
  Future<List<File>> openGallery([multiple = false]) async {
    final files = (await _getImageWithImagePicker(
      ImageSource.gallery,
      multiple,
    ))
        .$2;
    if (files == null) {
      throw FailToImportFileException('Canceled file import');
    }
    return files;
  }

  @override
  Future<File> openCamera() async {
    final file = (await _getImageWithImagePicker(ImageSource.camera)).$1;
    if (file == null) {
      throw FailToImportFileException('Canceled file import');
    }
    return file;
  }

  @override
  Future<List<File>> pickFiles({
    List<ExtensionFile> allowedExtensions = const [],
  }) async {
    final result = await filePicker.pickFiles(
      allowMultiple: true,
      allowedExtensions: allowedExtensions.map((e) => e.name).toList(),
      type: allowedExtensions.isNotEmpty ? FileType.custom : FileType.any,
    );
    if (result == null) {
      throw FailToImportFileException('Canceled file import');
    }
    return result.files.map((file) => File(file.path!)).toList();
  }

  @override
  Future<File> pickFile(
      {List<ExtensionFile> allowedExtensions = const []}) async {
    final result = await filePicker.pickFiles(
      allowMultiple: false,
      allowedExtensions: allowedExtensions.map((e) => e.name).toList(),
      type: allowedExtensions.isNotEmpty ? FileType.custom : FileType.any,
    );
    if (result == null || result.files.isEmpty) {
      throw FailToImportFileException('Canceled file import');
    }
    return File(result.files.first.path!);
  }

  Future<(File?, List<File>?)> _getImageWithImagePicker(
    ImageSource source, [
    bool multiple = false,
  ]) async {
    if (source == ImageSource.gallery) {
      if (multiple) {
        final result = await imagePicker.pickMultiImage();
        if (result.isEmpty) return (null, null);
        final compressedFiles = <File>[];
        for (var e in result) {
          final compressedFile = await _compressFile(File(e.path));
          if (compressedFile != null) {
            compressedFiles.add(compressedFile);
          }
        }
        return (null, compressedFiles);
      }
      final result = await _pickSingleImage(source);
      return (null, result != null ? [result] : null);
    }
    return (await _pickSingleImage(source), null);
  }

  Future<File?> _pickSingleImage(ImageSource source) async {
    final result = await imagePicker.pickImage(source: source);
    if (result == null) return null;
    return await _compressFile(File(result.path));
  }

  Future<File?> _compressFile(File file) async {
    String filePath = file.absolute.path;
    int lastIndex = filePath.lastIndexOf(RegExp(r'.jpg|.jpeg|.gif|.png'));
    if (lastIndex != -1) {
      CompressFormat format = filePath.substring(lastIndex) == ".png"
          ? CompressFormat.png
          : CompressFormat.jpeg;
      if (format == CompressFormat.png) {
        var f = _parseImage(file.parent.path, filePath).absolute.path;
        lastIndex = f.lastIndexOf(RegExp(r'.jpg|.jpeg|.gif|.png'));
        filePath = f;
      }
      final splitted = filePath.substring(0, (lastIndex));
      final outPath = "${splitted}_out${filePath.substring(lastIndex)}";
      var size = await _getSizeImage(file);
      double ratio = size.height / size.width;
      double newWidth =
          Get.width * 3 == size.width ? Get.width * 2.5 : Get.width * 2.9;
      double newHeight = newWidth * ratio;
      var result = await FlutterImageCompress.compressAndGetFile(
        filePath,
        outPath,
        quality: 50,
        minHeight: newHeight.toInt(),
        minWidth: newWidth.toInt(),
      );
      return File(result!.path);
    }
    return null;
  }

  File _parseImage(String parent, String path) {
    File imagePath = File(path);
    var image = Im.decodeImage(imagePath.readAsBytesSync());
    return File(
      '$parent/img_${DateTime.now().toString().replaceAll(' ', '')}.jpg',
    )..writeAsBytesSync(Im.encodeJpg(image!));
  }

  Future<Size> _getSizeImage(File file) async {
    var decodedImage = await decodeImageFromList(file.readAsBytesSync());
    return Size(decodedImage.width.toDouble(), decodedImage.height.toDouble());
  }
}
