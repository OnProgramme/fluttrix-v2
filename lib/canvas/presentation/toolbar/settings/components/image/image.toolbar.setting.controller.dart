import 'package:flutter/material.dart';
import 'package:fluttrix/shared/services/files/domain/file.picker.service.dart';
import 'package:fluttrix/utils/app.dependencies.dart';
import 'package:get/get.dart';

class ImageToolbarSettingController extends GetxController {
  final imageUrlController = TextEditingController();

  void handleImportImage() {
    AppDependencies.get<FilePickerService>().pickFile().then((file) {});
  }
}
