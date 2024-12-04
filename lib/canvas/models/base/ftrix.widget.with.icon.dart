import 'package:fluttrix/canvas/models/base/ftrix.custom.icon.dart';
import 'package:fluttrix/canvas/models/base/i.widget.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.icon.button.dart';

mixin FTrixWidgetWithIcon implements IWidget{
  FTrixCustomIcon icon = FTrixCustomIcon(60582, 'arrow_back');

  @override
  void loadFromJson(Map<String, dynamic> json) {
    icon = FTrixCustomIcon.fromJson(json['icon']);
  }
}