import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/settings/ftrix.align.setting.dart';
import 'package:fluttrix/canvas/models/settings/ftrix.icon.button.setting.dart';
import 'package:fluttrix/canvas/models/utils/parseSnakeToPascal.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.align.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.icon.button.dart';
import 'package:fluttrix/canvas/presentation/icons/choose.icon.modal.dart';
import 'package:fluttrix/canvas/presentation/toolbar/settings/components/widgets/f.color.picker.dart';
import 'package:fluttrix/canvas/presentation/toolbar/settings/components/widgets/f.edit.alignment.dart';
import 'package:fluttrix/utils/app.colors.dart';
import 'package:get/get.dart';

class IconButtonToolBarSettingComponent extends StatefulWidget {
  const IconButtonToolBarSettingComponent({super.key, required this.widget});
  final FTrixIconButton widget;

  @override
  State<IconButtonToolBarSettingComponent> createState() =>
      _IconButtonToolBarSettingComponentState();
}

class _IconButtonToolBarSettingComponentState
    extends State<IconButtonToolBarSettingComponent> {
  FTrixIconButton get icon => widget.widget;

  @override
  Widget build(BuildContext context) {
    final setting = icon.setting as FTrixIconButtonSetting;
    return Column(
      key: ValueKey(icon.id),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FTrixColorPicker(
          label: "Icon Color",
          onChanged: (color) {
            setting.color = color;
            icon.update();
          },
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "Icône",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 5),
          width: double.infinity,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                backgroundColor: Colors.transparent,
                side: BorderSide(
                  color: AppColors.buttonColor,
                )),
            onPressed: () {
              Get.dialog(ChooseIconModal()).then((iconResult) {
                if (iconResult == null) return;
                icon.icon = iconResult;
                icon.update();
                setState(() {});
              });
            },
            icon: Icon(
              icon.icon.iconData,
              color: AppColors.white,
            ),
            label: Text(
              parseSnakeToPascal(icon.icon.iconName),
              style: TextStyle(
                color: AppColors.white,
              ),
            ),
          ),
        )
      ],
    );
  }
}
