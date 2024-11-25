import 'package:fluttrix/canvas/models/base/ftrix.event.dart';
import 'package:fluttrix/canvas/models/base/ftrix.stream.dart';
import 'package:fluttrix/canvas/models/base/i.widget.dart';
import 'package:get/get.dart';

class FTrixToolbarSettingsControllerBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<FTrixToolbarSettingsController>(
          () => FTrixToolbarSettingsController(),
    );
  }
}

class FTrixToolbarSettingsController extends GetxController{
  final selectedWidget = Rxn<IWidget>();
  @override
  void onInit() {
    super.onInit();
    FTrixStream.instance.selectWidgetEvent.listen((event){
      if(event.type == FTrixWidgetEventType.SELECT){
        handleWidgetSelected(event.selectWidget);
        return;
      }
      handleWidgetSelected(null);
    });
  }


  void handleWidgetSelected(IWidget? widget){
    selectedWidget.value = widget;
  }
}