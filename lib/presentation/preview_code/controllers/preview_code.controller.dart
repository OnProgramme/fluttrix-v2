import 'package:fluttrix/canvas/presentation/canvas/controllers/f.canvas.controller.dart';
import 'package:fluttrix/files/ftrix.base.file.dart';
import 'package:get/get.dart';

class PreviewCodeController extends GetxController {

  final canvasController = Get.put(FCanvasController());




  Map<String, dynamic> get canvasJson => canvasController.canvas.value.toJson();

  List<FTrixBaseFile> get files => canvasController.canvas.value.files;
}
