import 'package:get/get.dart';

import '../../../../presentation/preview_code/controllers/preview_code.controller.dart';

class PreviewCodeControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PreviewCodeController>(
      () => PreviewCodeController(),
    );
  }
}
