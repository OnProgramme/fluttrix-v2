import 'package:fluttrix/canvas/presentation/canvas/controllers/f.canvas.controller.dart';
import 'package:fluttrix/files/ftrix.base.file.dart';
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

  final canvasController = Get.put(FCanvasController());




  Map<String, dynamic> get canvasJson => canvasController.canvas.toJson();

  List<FTrixBaseFile> get files => canvasController.canvas.files;
}
