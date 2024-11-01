import 'package:fluttrix/canvas/models/widgets/ftrix.scaffold.dart';
import 'package:fluttrix/infrastructure/navigation/routes.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {

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

  void handlePreviewCode() {
    Get.toNamed(Routes.PREVIEW_CODE);
  }
}
