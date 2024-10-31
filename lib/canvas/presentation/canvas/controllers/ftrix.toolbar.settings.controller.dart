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
    FTrixStream.instance.stream.listen((event){
      if(event.type == FTrixWidgetEventType.SELECT){
        handleWidgetSelected(event.widget);
      }else{
        handleWidgetSelected(null);
      }
    });
  }


  void handleWidgetSelected(IWidget? widget){
    selectedWidget(widget);
  }
}