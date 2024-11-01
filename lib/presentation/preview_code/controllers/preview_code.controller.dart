import 'package:fluttrix/canvas/models/widgets/ftrix.canvas.dart';
import 'package:fluttrix/canvas/presentation/canvas/controllers/f.canvas.controller.dart';
import 'package:get/get.dart';
import 'package:monaco_editor/monaco_editor.dart';

class PreviewCodeController extends GetxController {

  final editorController = MonacoEditorController();
  final canvasController = Get.find<FCanvasController>();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Map<String, dynamic> get canvasJson => canvasController.canvas.value.toJson();

}
