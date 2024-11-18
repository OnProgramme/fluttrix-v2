import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/base/ftrix.widget.setting.dart';
import 'package:fluttrix/canvas/presentation/toolbar/settings/components/widgets/f.divider.dart';
import 'package:fluttrix/canvas/presentation/toolbar/settings/components/widgets/f.small.input.dart';

class FTrixEditRadius extends StatefulWidget {
  const FTrixEditRadius({
    super.key,
    required this.setting,
    this.onUpdated,
  });
  final BorderRadiusSetting setting;
  final VoidCallback? onUpdated;

  @override
  State<FTrixEditRadius> createState() => _FTrixEditRadiusState();
}

class _FTrixEditRadiusState extends State<FTrixEditRadius> {
  final topLeftController = TextEditingController();
  final topRightController = TextEditingController();
  final bottomLeftController = TextEditingController();
  final bottomRightController = TextEditingController();
  final allController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initController();
  }

  @override
  void didUpdateWidget(covariant FTrixEditRadius oldWidget) {
    super.didUpdateWidget(oldWidget);
    initController();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FTrixDivider(label: "Radius"),
        SizedBox(
          height: 10,
        ),
        Center(
          child: Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FSmallInput(
                    hint: "TL",
                    controller: topLeftController,
                    onChanged: (value) {
                      widget.setting.topLeft = double.tryParse(value);
                      allController.clear();
                      widget.onUpdated?.call();
                    },
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: 38,
                    height: 35,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  FSmallInput(
                    hint: "TR",
                    controller: topRightController,
                    onChanged: (value) {
                      widget.setting.topRight = double.tryParse(value);
                      allController.clear();
                      widget.onUpdated?.call();
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 38,
                    height: 35,
                  ),
                  FSmallInput(
                    hint: "A",
                    controller: allController,
                    onChanged: (value) {
                      topLeftController.text = value;
                      topRightController.text = value;
                      bottomLeftController.text = value;
                      bottomRightController.text = value;
                      widget.setting.topLeft = double.tryParse(value);
                      widget.setting.topRight = double.tryParse(value);
                      widget.setting.bottomLeft = double.tryParse(value);
                      widget.setting.bottomRight = double.tryParse(value);
                      widget.onUpdated?.call();
                    },
                  ),
                  SizedBox(
                    width: 38,
                    height: 35,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FSmallInput(
                    hint: "BL",
                    controller: bottomLeftController,
                    onChanged: (value) {
                      widget.setting.bottomLeft = double.tryParse(value);
                      allController.clear();
                      widget.onUpdated?.call();
                    },
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: 38,
                    height: 35,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  FSmallInput(
                    hint: "BR",
                    controller: bottomRightController,
                    onChanged: (value) {
                      widget.setting.bottomRight = double.tryParse(value);
                      allController.clear();
                      widget.onUpdated?.call();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  void initController() {
    topLeftController.text = widget.setting.topLeft?.toString() ?? "";
    topRightController.text = widget.setting.topRight?.toString() ?? "";
    bottomLeftController.text = widget.setting.bottomLeft?.toString() ?? "";
    bottomRightController.text = widget.setting.bottomRight?.toString() ?? "";
    allController.text =
        widget.setting.isEqual ? widget.setting.topLeft.toString() : "";
  }
}
