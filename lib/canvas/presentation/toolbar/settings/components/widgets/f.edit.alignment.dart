import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:fluttrix/canvas/models/settings/ftrix.align.setting.dart';
import 'package:fluttrix/canvas/models/utils/abbreviateCamelCase.dart';
import 'package:fluttrix/canvas/presentation/toolbar/settings/components/widgets/f.divider.dart';
import 'package:fluttrix/utils/app.colors.dart';

class FTrixEditAlignment extends StatelessWidget {
  const FTrixEditAlignment({
    super.key,
    required this.alignment,
    required this.onChanged,
  });
  final FTrixAlignmentSetting alignment;
  final void Function(FTrixAlignmentSetting alignment) onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FTrixDivider(label: "Alignment"),
        SizedBox(
          height: 10,
        ),
        LayoutGrid(
          columnSizes: [1.fr, 1.fr, 1.fr],
          rowSizes: [auto, auto, auto],
          rowGap: 5,
          children: FTrixAlignmentSettingEnum.values
              .map((e) => Center(
                    child: Radio(
                      activeColor: AppColors.buttonColor,
                      value: e.setting,
                      groupValue: alignment,
                      onChanged: (value) => onChanged(value!),
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }
}
