import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/base/ftrix.dropped.widget.event.dart';
import 'package:fluttrix/canvas/models/settings/ftrix.image.setting.dart';
import 'package:fluttrix/canvas/models/widgets/components/ftrix.base.component.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.image.dart';
import 'package:fluttrix/utils/app.colors.dart';

class FtrixImageComponent extends StatefulWidget {
  const FtrixImageComponent({
    super.key,
    this.onTap,
    this.isSelected = false,
    required this.setting,
    required this.onDrop,
    required this.widget,
  });

  final FTrixImageSetting setting;
  final VoidCallback? onTap;
  final bool isSelected;
  final FTrixImage widget;
  final ValueSetter<DroppedWidgetEvent> onDrop;

  @override
  State<FtrixImageComponent> createState() => _FtrixImageComponentState();
}

class _FtrixImageComponentState extends State<FtrixImageComponent> {
  @override
  Widget build(BuildContext context) {
    return FTrixBaseComponent(
        enableResizedChild: widget.isSelected,
        isSelected: widget.isSelected,
        onTap: widget.onTap,
        widget: widget.widget,
        setting: widget.setting,
        onDrop: widget.onDrop,
        onResized: (value) {
          if (mounted) {
            setState(() {});
          }
        },
        child: CachedNetworkImage(
          imageUrl: widget.widget.src,
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
          placeholder: (context, url) => Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border.all(
              color: AppColors.grey,
            )),
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.grey,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.error),
                  Text("Erreur de chargement de l'image")
                ],
              )),
          width:
              widget.setting.fullWidth ? double.infinity : widget.setting.width,
          height: widget.setting.height,
          fit: BoxFit.cover,
        )

        // Image.network(
        //   src,
        //   fit: BoxFit.cover,
        //   width: setting.fullWidth ? double.infinity : setting.width,
        // ),
        );
  }
}
