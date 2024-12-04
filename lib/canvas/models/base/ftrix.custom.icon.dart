import 'package:flutter/cupertino.dart';

class FTrixCustomIcon {
  int icon;
  String iconName;
  FTrixCustomIcon(this.icon, this.iconName);

  factory FTrixCustomIcon.fromJson(Map<String, dynamic> json) =>
      FTrixCustomIcon(json['icon'] ?? json['code'], json['iconName'] ?? json['css']);

  Map<String, dynamic> toJson() => {"icon": icon, "iconName": iconName};

  IconData get iconData => IconData(icon, fontFamily: "materialIcons");
}