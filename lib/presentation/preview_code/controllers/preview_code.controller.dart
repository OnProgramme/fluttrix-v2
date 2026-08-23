import 'package:fluttrix/canvas/presentation/canvas/controllers/f.canvas.controller.dart';
import 'package:fluttrix/files/ftrix.base.file.dart';
import 'package:fluttrix/files/ftrix.file.dart';
import 'package:fluttrix/files/ftrix.folder.dart';
import 'package:get/get.dart';

class PreviewCodeControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PreviewCodeController>(
          () => PreviewCodeController(),
    );
  }
}

class PreviewCodeController extends GetxController {

  final canvasController = Get.isRegistered<FCanvasController>()
      ? Get.find<FCanvasController>()
      : Get.put(FCanvasController());

  final selectedFile = Rxn<FTrixFile>();

  Map<String, dynamic> get canvasJson => canvasController.canvas.toJson();

  List<FTrixBaseFile> get files => canvasController.canvas.files;

  String get selectedCode => selectedFile.value?.content ?? '';

  @override
  void onInit() {
    super.onInit();
    _selectDefaultFile();
  }

  void _selectDefaultFile() {
    for (final file in files) {
      if (file is FTrixFolder) {
        for (final child in file.files) {
          if (child is FTrixFile) {
            selectedFile.value = child;
            return;
          }
        }
      }
    }
  }

  void handleSelectFile(FTrixFile file) {
    selectedFile.value = file;
  }
}
