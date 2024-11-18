import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.image.dart';
import 'package:fluttrix/canvas/presentation/toolbar/settings/components/widgets/f.edit.padding.or.margin.dart';
import 'package:fluttrix/canvas/presentation/toolbar/settings/components/widgets/f.edit.radius.dart';

class ImageToolBarSettingComponent extends StatelessWidget {
  const ImageToolBarSettingComponent({super.key, required this.widget});
  final FTrixImage widget;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FTrixEditPaddingOrMargin(
          setting: widget.setting.padding,
          onUpdated: () => widget.update(),
        ),
        SizedBox(
          height: 10,
        ),
        FTrixEditPaddingOrMargin(
          isMargin: true,
          setting: widget.setting.margin,
          onUpdated: () => widget.update(),
        ),
        SizedBox(
          height: 10,
        ),
        FTrixEditRadius(
          setting: widget.setting.radius,
          onUpdated: () => widget.update(),
        ),
      ],
    );
  }
}
