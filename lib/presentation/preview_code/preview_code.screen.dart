import 'package:flutter/material.dart';
import 'package:flutter_syntax_view/flutter_syntax_view.dart';
import 'package:fluttrix/canvas/models/generator/ftrix.widget.generator.dart';

import 'package:get/get.dart';
import 'package:monaco_editor/monaco_editor.dart';

import 'controllers/preview_code.controller.dart';

class PreviewCodeScreen extends GetView<PreviewCodeController> {
  const PreviewCodeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Visualiseur le code'),
        centerTitle: true,
      ),
      body: SyntaxView(
          code: FTrixWidgetGenerator.generateCodeFromJson(jsonMap: controller.canvasJson, className: 'Home'),	// Code text
          syntax: Syntax.DART,	// Language
          syntaxTheme: SyntaxTheme.vscodeDark(),	// Theme
          fontSize: 14.0,	// Font size
          expanded: true,
      ),
    );
  }
}
