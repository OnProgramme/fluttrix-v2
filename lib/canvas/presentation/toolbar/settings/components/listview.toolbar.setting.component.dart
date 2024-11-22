import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.image.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.listview.dart';
import 'package:fluttrix/canvas/presentation/toolbar/settings/components/widgets/f.edit.padding.or.margin.dart';
import 'package:fluttrix/canvas/presentation/toolbar/settings/components/widgets/f.edit.radius.dart';

class ListViewToolBarSettingComponent extends StatelessWidget {
  const ListViewToolBarSettingComponent({super.key, required this.widget});
  final FTrixListView widget;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FTrixEditPaddingOrMargin(
          setting: widget.setting.padding,
          onUpdated: () => widget.update(),
        ),
      ],
    );
  }
}
