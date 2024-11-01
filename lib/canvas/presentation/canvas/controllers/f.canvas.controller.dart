import 'package:fluttrix/canvas/models/widgets/ftrix.canvas.dart';
import 'package:get/get.dart';

class FCanvasControllerBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<FCanvasController>(
      () => FCanvasController(),
    );
  }
}

class FCanvasController extends GetxController {
  final canvas = FTrixCanvas().obs;

  @override
  void onInit() {
    super.onInit();
    handleUpdateCanvas();
  }

  void handleUpdateCanvas(){
    canvas.value.update.listen((type){
      print(canvas.value.toJson());
      canvas.refresh();
    });
  }
}