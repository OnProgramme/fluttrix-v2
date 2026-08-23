import 'package:flutter/material.dart';
import 'package:flutter_syntax_view/flutter_syntax_view.dart';
import 'package:fluttrix/presentation/preview_code/components/ftrix.file.tree.component.dart';
import 'package:get/get.dart';

import 'controllers/preview_code.controller.dart';

class PreviewCodeScreen extends GetView<PreviewCodeController> {
  const PreviewCodeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Visualiseur de code'),
        centerTitle: true,
      ),
      body: Row(
        children: [
          Container(
            width: 250,
            height: MediaQuery.sizeOf(context).height,
            color: Colors.black.withOpacity(.87),
            padding: EdgeInsets.all(10),
            child: Obx(() => FTrixFileTreeComponent(
                  files: controller.files,
                  selectedFileName: controller.selectedFile.value?.name,
                  onFileTap: controller.handleSelectFile,
                )),
          ),
          Expanded(
            child: Obx(() {
              final file = controller.selectedFile.value;
              if (file == null) {
                return Center(
                  child: Text(
                    "Sélectionner un fichier",
                    style: TextStyle(color: Colors.grey),
                  ),
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    color: Colors.black.withOpacity(.6),
                    child: Text(
                      file.name,
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                  ),
                  Expanded(
                    child: SyntaxView(
                      code: controller.selectedCode,
                      syntax: Syntax.DART,
                      syntaxTheme: SyntaxTheme.vscodeDark(),
                      fontSize: 14.0,
                      expanded: true,
                    ),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
