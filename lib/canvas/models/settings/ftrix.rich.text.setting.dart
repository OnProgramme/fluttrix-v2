import 'package:fluttrix/canvas/models/settings/ftrix.text.setting.dart';

class FTrixRichTextSetting {
  String text;
  int index;
  final FTrixTextSetting setting;

  FTrixRichTextSetting({
    required this.text,
    required this.setting,
    this.index = 0,
  });

  factory FTrixRichTextSetting.fromJson(Map<String, dynamic> json) => FTrixRichTextSetting(
    text: json['text'],
    index: json['index'],
    setting: FTrixTextSetting.fromJson(json['setting']),
  );

  static FTrixRichTextSetting get empty => FTrixRichTextSetting(text: '', setting: FTrixTextSetting.zero);

  FTrixRichTextSetting copyWith({
    String? text,
    int? index,
    FTrixTextSetting? setting,
  }) => FTrixRichTextSetting(
    text: text ?? this.text,
    index: index ?? this.index,
    setting: setting ?? this.setting,
  );

  Map<String, dynamic> toJson() => {
    'text': text,
    'index': index,
    'setting': setting.toJson(),
  };
}