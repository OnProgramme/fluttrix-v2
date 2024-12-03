import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/settings/ftrix.image.setting.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.image.dart';
import 'package:fluttrix/canvas/presentation/toolbar/settings/components/widgets/f.edit.padding.or.margin.dart';
import 'package:fluttrix/canvas/presentation/toolbar/settings/components/widgets/f.edit.radius.dart';
import 'package:fluttrix/canvas/presentation/toolbar/settings/components/widgets/f.edit.size.dart';
import 'package:fluttrix/canvas/presentation/toolbar/settings/components/widgets/f.textfield.dart';

class ImageToolBarSettingComponent extends StatefulWidget {
  const ImageToolBarSettingComponent({super.key, required this.widget});
  final FTrixImage widget;

  @override
  State<ImageToolBarSettingComponent> createState() =>
      _ImageToolBarSettingComponentState();
}

class _ImageToolBarSettingComponentState
    extends State<ImageToolBarSettingComponent> {

  final imageUrlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final setting = widget.widget.setting as FTrixImageSetting;
    return Column(
      key: ValueKey(widget.widget.id),
      children: [
        FTextField(
          label: "Lien de l'image",
          initialValue: widget.widget.src,
          onChanged: (value) {
            widget.widget.src = value;
            widget.widget.update();
          },
        ),
        FTrixEditSize(
          width: setting.width,
          height: setting.height,
          onSizeChanged: (width, height) {
            setting.width = width;
            setting.height = height;
            widget.widget.update();
          },
        ),
        CheckboxListTile(
          contentPadding: EdgeInsets.zero,
          controlAffinity: ListTileControlAffinity.leading,
          value: setting.fullWidth,
          onChanged: (value) {
            setting.fullWidth = value!;
            widget.widget.update();
            setState(() {});
          },
          title: Text("Largeur de l'écran"),
        ),
        FTrixEditPaddingOrMargin(
          setting: widget.widget.setting.padding,
          onUpdated: () => widget.widget.update(),
        ),
        SizedBox(
          height: 10,
        ),
        FTrixEditPaddingOrMargin(
          isMargin: true,
          setting: widget.widget.setting.margin,
          onUpdated: () => widget.widget.update(),
        ),
        SizedBox(
          height: 10,
        ),
        FTrixEditRadius(
          setting: widget.widget.setting.radius,
          onUpdated: () => widget.widget.update(),
        ),
      ],
    );
  }
}
