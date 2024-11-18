import 'package:flutter/material.dart';
import 'package:flutter_syntax_view/flutter_syntax_view.dart';
import 'package:fluttrix/canvas/models/generator/ftrix.widget.generator.dart';
import 'package:fluttrix/presentation/preview_code/components/ftrix.file.tree.component.dart';
import 'package:get/get.dart';

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
      body: Row(
        children: [
          Container(
            width: 250,
            height: Get.height,
            color: Colors.black.withOpacity(.87),
            padding: EdgeInsets.all(10),
            child: FTrixFileTreeComponent(files: controller.files),
            // child: Column(
            //   children: [
            //     Row(
            //       children: [
            //         Icon(Icons.keyboard_arrow_down_outlined, color: Colors.grey,size: 20,),
            //         Icon(Icons.folder_open, color: Colors.grey,size: 20,),
            //         SizedBox(width: 5,),
            //         Text("lib", style: TextStyle(color: Colors.grey),)
            //       ],
            //     )
            //   ],
            // ),
          ),
          Expanded(
            child: SyntaxView(
                code: FTrixWidgetGenerator.generateCodeFromJson(jsonMap: controller.canvasJson, className: 'Home', stateType: FTrixWidgetStateType.STATEFUL),	// Code text
                syntax: Syntax.DART,	// Language
                syntaxTheme: SyntaxTheme.vscodeDark(),	// Theme
                fontSize: 14.0,	// Font size
                expanded: true,
            ),
          ),
        ],
      ),
    );
  }
}
