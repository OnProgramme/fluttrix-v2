import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/presentation/toolbar/settings/components/widgets/f.divider.dart';
import 'package:fluttrix/canvas/presentation/toolbar/settings/components/widgets/f.small.input.dart';

import '../../../../../models/base/ftrix.widget.setting.dart';

class FTrixEditPaddingOrMargin extends StatefulWidget {
  const FTrixEditPaddingOrMargin({
    super.key,
    this.isMargin = false,
    required this.setting,
    this.onUpdated,
  });
  final bool isMargin;
  final EdgeInsetsSetting setting;
  final VoidCallback? onUpdated;

  @override
  State<FTrixEditPaddingOrMargin> createState() =>
      _FTrixEditPaddingOrMarginState();
}

class _FTrixEditPaddingOrMarginState extends State<FTrixEditPaddingOrMargin> {
  final leftController = TextEditingController();
  final topController = TextEditingController();
  final rightController = TextEditingController();
  final bottomController = TextEditingController();
  final allController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initController();
  }

  @override
  void didUpdateWidget(covariant FTrixEditPaddingOrMargin oldWidget) {
    super.didUpdateWidget(oldWidget);
    initController();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FTrixDivider(label: widget.isMargin ? "Margin" : "Padding"),
        SizedBox(
          height: 10,
        ),
        Center(
          child: Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 38,
                    height: 35,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  FSmallInput(
                    hint: "T",
                    controller: topController,
                    onChanged: (value) {
                      allController.clear();
                      widget.setting.top = double.tryParse(value);
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
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FSmallInput(
                    hint: "L",
                    controller: leftController,
                    onChanged: (value) {
                      allController.clear();
                      widget.setting.left = double.tryParse(value);
                      widget.onUpdated?.call();
                    },
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  FSmallInput(
                    hint: "A",
                    controller: allController,
                    onChanged: (value) {
                      leftController.text = value;
                      topController.text = value;
                      rightController.text = value;
                      bottomController.text = value;
                      widget.setting.left = double.tryParse(value);
                      widget.setting.top = double.tryParse(value);
                      widget.setting.right = double.tryParse(value);
                      widget.setting.bottom = double.tryParse(value);
                      widget.onUpdated?.call();
                    },
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  FSmallInput(
                    hint: "R",
                    controller: rightController,
                    onChanged: (value) {
                      allController.clear();
                      widget.setting.right = double.tryParse(value);
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
                  SizedBox(
                    width: 10,
                  ),
                  FSmallInput(
                    hint: "B",
                    controller: bottomController,
                    onChanged: (value) {
                      allController.clear();
                      widget.setting.bottom = double.tryParse(value);
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
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }


  void initController(){
    leftController.text = widget.setting.left?.toString() ?? "";
    topController.text = widget.setting.top?.toString() ?? "";
    rightController.text = widget.setting.right?.toString() ?? "";
    bottomController.text = widget.setting.bottom?.toString() ?? "";
    allController.text = widget.setting.isEqual? widget.setting.top.toString():"";
  }
}
