import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttrix/canvas/models/base/ftrix.dropped.widget.event.dart';
import 'package:fluttrix/canvas/models/base/ftrix.event.dart';
import 'package:fluttrix/canvas/models/base/ftrix.stream.dart';
import 'package:fluttrix/canvas/models/base/ftrix.widget.child.dart';
import 'package:fluttrix/canvas/models/base/ftrix.widget.children.dart';
import 'package:fluttrix/canvas/models/base/i.widget.dart';
import 'package:fluttrix/canvas/models/builder/ftrix.widget.icon.builder.dart';
import 'package:fluttrix/canvas/models/enums/drop.position.dart';
import 'package:fluttrix/canvas/models/enums/widget.type.dart';
import 'package:fluttrix/canvas/models/utils/parse.snake.to.pascal.dart';
import 'package:fluttrix/canvas/models/widgets/ftrix.scaffold.dart';
import 'package:fluttrix/canvas/presentation/canvas/controllers/f.canvas.controller.dart';
import 'package:fluttrix/canvas/presentation/canvas/tree/wrap/wrap.component.list.modal.dart';
import 'package:fluttrix/projects/application/usecases/components/create/create.component.async.dart';
import 'package:fluttrix/projects/application/usecases/components/create/create.component.command.dart';
import 'package:fluttrix/utils/app.colors.dart';
import 'package:fluttrix/utils/app.dependencies.dart';
import 'package:fluttrix/utils/message.dart';
import 'package:get/get.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class CanvasTreeWidgetExplorer extends StatefulWidget {
  final IWidget rootWidget;
  final Function(IWidget) onWidgetSelected;

  const CanvasTreeWidgetExplorer({
    super.key,
    required this.rootWidget,
    required this.onWidgetSelected,
  });

  @override
  _CanvasTreeWidgetExplorerState createState() =>
      _CanvasTreeWidgetExplorerState();
}

class _CanvasTreeWidgetExplorerState extends State<CanvasTreeWidgetExplorer> {
  Map<String, bool> expandedNodes = {};
  String selectedWidgetId = '';

  List<IWidget> getChildrenWidgets(IWidget widget) {
    List<IWidget> children = [];

    switch (widget.type) {
      case WidgetType.SCAFFOLD:
        final scaffoldWidget = widget as FTrixScaffold;
        if (scaffoldWidget.child != null) {
          children.add(scaffoldWidget.child!);
        }
        break;
      case WidgetType.CONTAINER:
      case WidgetType.BUTTON_WITH_CHILD:
      case WidgetType.ALIGN:
      case WidgetType.CENTER:
      case WidgetType.COMPONENT:
        final containerWidget = widget as FTrixWidgetWithChild;
        if (containerWidget.child != null) {
          children.add(containerWidget.child!);
        }
        break;
      case WidgetType.LISTVIEW:
      case WidgetType.COLUMN:
      case WidgetType.ROW:
      case WidgetType.WRAP:
      case WidgetType.GRIDVIEW:
        final multiChildWidget = widget as dynamic;
        if (multiChildWidget.children != null) {
          children.addAll(multiChildWidget.children);
        }
        break;
      default:
        break;
    }

    return children;
  }

  Widget buildTreeItem(IWidget widget, int depth) {
    final children = getChildrenWidgets(widget);
    final hasChildren = children.isNotEmpty;
    final isExpanded = expandedNodes[widget.id] ?? false;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            widget.select();
            if (isExpanded && selectedWidgetId != widget.id) {
              selectedWidgetId = widget.id;
              return;
            }
            if (hasChildren) {
              setState(() {
                expandedNodes[widget.id] = !isExpanded;
              });
            }
          },
          child: Container(
            height: 40,
            color: widget.isWidgetSelected
                ? Colors.blue.withOpacity(0.1)
                : Colors.transparent,
            padding: EdgeInsets.symmetric(vertical: 0),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      SizedBox(width: depth * 24.0),
                      if (hasChildren)
                        Icon(
                          isExpanded ? Icons.expand_more : Icons.chevron_right,
                          size: 20,
                        ),
                      if (!hasChildren) SizedBox(width: 20),
                      Icon(
                        FTrixWidgetIconBuilder.build(widget.type),
                        size: 20,
                      ),
                      SizedBox(width: 8),
                      Text(
                        parseSnakeToPascal(widget.type.name.capitalizeFirst!),
                        style: TextStyle(
                          fontWeight: widget.isWidgetSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                if (widget.parentId != null)
                  PopupMenuButton(
                    constraints: BoxConstraints(minHeight: 0, minWidth: 0),
                    tooltip: "Plus d'options",
                    icon: Icon(
                      LucideIcons.moreVertical,
                      size: 20,
                    ),
                    onSelected: (i) async {
                      if (i == 2) {
                        await _handleDefineAsComponent(widget);
                        return;
                      }
                      Get.dialog(WrapComponentListModal(
                        excludeWidgetType: i == 0
                            ? [
                                WidgetType.TEXT,
                                WidgetType.RICH_TEXT,
                                WidgetType.INPUT,
                                WidgetType.IMAGE,
                                WidgetType.BUTTON,
                              ]
                            : [],
                      )).then((type) {
                        if (type == null) return;
                        if (i == 0) {
                          widget.wrapParent(type);
                        }
                        if (i == 1 && widget is FTrixWidgetWithChildren) {
                          widget.handleDropWidget(DroppedWidgetEvent(DropPosition.INSIDE, type));
                          setState(() {});
                        }
                      });
                    },
                    itemBuilder: (context) {
                      return [
                        if (widget.parentId != null)
                          PopupMenuItem(
                            value: 0,
                            child: Row(
                              children: [
                                Icon(LucideIcons.box),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Ajouter un parent",
                                  style: TextStyle(color: AppColors.white),
                                )
                              ],
                            ),
                          ),
                        if (widget is FTrixWidgetWithChildren) ...[
                          PopupMenuItem(
                            value: 1,
                            child: Row(
                              children: [
                                Icon(LucideIcons.plus),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Ajouter un enfant",
                                  style: TextStyle(color: AppColors.white),
                                )
                              ],
                            ),
                          ),
                        ],
                        PopupMenuItem(
                          value: 2,
                          child: Row(
                            children: [
                              Icon(LucideIcons.puzzle),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Définir comme composant",
                                style: TextStyle(color: AppColors.white),
                              )
                            ],
                          ),
                        )
                      ];
                    },
                  )
              ],
            ),
          ),
        ),
        if (hasChildren && isExpanded)
          ...children.map((child) => buildTreeItem(child, depth + 1)),
      ],
    );
  }

  Future<void> _handleDefineAsComponent(IWidget widget) async {
    final nameController = TextEditingController(
      text: parseSnakeToPascal(widget.type.name.toLowerCase()),
    );
    final componentName = await Get.dialog<String>(
      AlertDialog(
        backgroundColor: AppColors.background,
        title: Text(
          "Définir comme composant",
          style: TextStyle(color: AppColors.white, fontSize: 18),
        ),
        content: TextField(
          controller: nameController,
          autofocus: true,
          decoration: InputDecoration(
            hintText: "Nom du composant",
            hintStyle: TextStyle(color: AppColors.grey),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text("Annuler"),
          ),
          ElevatedButton(
            onPressed: () => Get.back(result: nameController.text.trim()),
            child: Text("Créer"),
          ),
        ],
      ),
      barrierColor: Colors.black54,
    );
    if (componentName == null || componentName.isEmpty) return;
    final canvasController = Get.find<FCanvasController>();
    final createComponentAsync = AppDependencies.get<CreateComponentAsync>();
    final result = await createComponentAsync.execute(
      CreateComponentCommand(
        projectId: canvasController.projectId,
        name: componentName,
        data: widget.toJson(),
      ),
    );
    result.fold(
      (err) => Message.errors("Erreur lors de la création du composant"),
      (component) {
        widget.componentize(
          componentId: component.id,
          componentName: component.name,
        );
      },
    );
  }

  List<String> _findPathToWidget(IWidget root, String targetId,
      [List<String> currentPath = const []]) {    if (root.id == targetId) {
      return currentPath;
    }

    final children = getChildrenWidgets(root);
    for (var child in children) {
      final newPath = [...currentPath, root.id];
      final result = _findPathToWidget(child, targetId, newPath);
      if (result.isNotEmpty) {
        return result;
      }
    }

    return [];
  }

  void _expandParents(IWidget selectedWidget) {
    final path = _findPathToWidget(widget.rootWidget, selectedWidget.id);
    setState(() {
      for (var id in path) {
        expandedNodes[id] = true;
      }
    });
  }

  StreamSubscription? _selectSubscription;

  @override
  void initState() {
    super.initState();
    _selectSubscription = FTrixStream.instance.selectWidgetEvent.listen((event) {
      if (!mounted) return;
      if (event.type == FTrixWidgetEventType.SELECT) {
        selectedWidgetId = event.selectWidget.id;
        _expandParents(event.selectWidget);
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    _selectSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildTreeItem(widget.rootWidget, 0),
        ],
      ),
    );
  }
}

class WidgetExplorerPanel extends StatelessWidget {
  final IWidget rootWidget;
  final Function(IWidget) onWidgetSelected;

  const WidgetExplorerPanel({
    super.key,
    required this.rootWidget,
    required this.onWidgetSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        color: AppColors.primary,
        border: Border(
          left: BorderSide(
            color: AppColors.background,
            width: 3,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Structure',
              style: Get.textTheme.titleMedium?.copyWith(color: Colors.white),
            ),
          ),
          Expanded(
            child: CanvasTreeWidgetExplorer(
              rootWidget: rootWidget,
              onWidgetSelected: onWidgetSelected,
            ),
          ),
        ],
      ),
    );
  }
}
