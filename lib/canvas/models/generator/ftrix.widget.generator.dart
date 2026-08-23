import '../enums/widget.type.dart';
import '../utils/parse.snake.to.pascal.dart';

enum FTrixWidgetStateType { STATELESS, STATEFUL }

class FTrixComponentRef {
  final String name;
  final Map<String, dynamic> json;
  FTrixComponentRef({required this.name, required this.json});
}

class FTrixWidgetGenerator {

  static String generateCodeFromJson({
    required Map<String, dynamic> jsonMap,
    required String className,
    FTrixWidgetStateType stateType = FTrixWidgetStateType.STATELESS,
    int indentLevel = 0,
  }) {
    final buffer = StringBuffer();
    // Imports
    buffer.writeln('import \'package:flutter/material.dart\';');
    buffer.writeln();

    // Générer la classe selon le type
    if (stateType == FTrixWidgetStateType.STATELESS) {
      buffer.write(_generateStatelessWidget(
        jsonMap,
        className: className,
        indentLevel: indentLevel,
      ));
    } else {
      buffer.write(_generateStatefulWidget(
        jsonMap,
        className: className,
        indentLevel: indentLevel,
      ));
    }

    return buffer.toString();
  }

  /// Collecte les composants utilisés dans l'arbre JSON (dédupliqué par nom).
  static List<FTrixComponentRef> collectComponents(Map<String, dynamic> json,
      [Map<String, FTrixComponentRef>? accumulator]) {
    final components = accumulator ?? {};
    if (json['type'] == WidgetType.COMPONENT.name &&
        json['componentName'] != null &&
        !components.containsKey(json['componentName'])) {
      components[json['componentName']] = FTrixComponentRef(
        name: json['componentName'],
        json: Map<String, dynamic>.from(json),
      );
    }
    final child = json['child'];
    if (child is Map) {
      collectComponents(Map<String, dynamic>.from(child), components);
    }
    final children = json['children'];
    if (children is List) {
      for (final element in children) {
        if (element is Map) {
          collectComponents(Map<String, dynamic>.from(element), components);
        }
      }
    }
    return components.values.toList();
  }

  /// Nom de classe PascalCase à partir du nom du composant.
  static String pascalClassName(String name) {
    return parseSnakeToPascal(name.trim().replaceAll(RegExp(r'\s+'), '_'));
  }

  /// Nom de fichier snake_case pour un composant.
  static String componentFileName(String name) {
    return '${pascalClassName(name)
        .replaceAllMapped(RegExp(r'[A-Z]'), (match) {
      return match.group(0) == null ? '' : '_${match.group(0)!.toLowerCase()}';
    }).replaceFirst(RegExp(r'^_'), '')}.dart';
  }

  /// Génère le contenu du fichier dart d'un composant réutilisable.
  static String generateComponentFile({
    required String componentName,
    required Map<String, dynamic> componentJson,
  }) {
    final className = pascalClassName(componentName);
    final body = componentJson['child'] ?? componentJson;
    return generateCodeFromJson(
      jsonMap: Map<String, dynamic>.from(body),
      className: className,
      stateType: FTrixWidgetStateType.STATELESS,
    );
  }

  /// Échappe une chaîne utilisateur pour un littéral Dart.
  static String escapeString(String value) {
    return value.replaceAll('\\', '\\\\').replaceAll("'", "\\'").replaceAll('\$', r'\$');
  }

  static String _generateStatelessWidget(
    Map<String, dynamic> json, {
    required String className,
    int indentLevel = 0,
  }) {
    final indent = '  ' * indentLevel;
    return '''
$indent class $className extends StatelessWidget {
$indent   const $className({Key? key}) : super(key: key);

$indent   @override
$indent   Widget build(BuildContext context) {
$indent     return ${_generateCode(json, indentLevel: indentLevel + 2)};
$indent   }
$indent }''';
  }

  static String _generateStatefulWidget(
    Map<String, dynamic> json, {
    required String className,
    int indentLevel = 0,
  }) {
    final indent = '  ' * indentLevel;
    return '''
$indent class $className extends StatefulWidget {
$indent   const $className({Key? key}) : super(key: key);

$indent   @override
$indent   State<$className> createState() => _${className}State();
$indent }

$indent class _${className}State extends State<$className> {
$indent   @override
$indent   Widget build(BuildContext context) {
$indent     return ${_generateCode(json, indentLevel: indentLevel + 2)};
$indent   }
$indent }''';
  }

  static String _generateCode(Map<String, dynamic> json,
      {int indentLevel = 0}) {
    final type = WidgetType.values.firstWhere((el) => el.name == json['type']);
    final indent = '  ' * indentLevel;

    switch (type) {
      case WidgetType.SCAFFOLD:
        return _generateScaffoldCode(json, indentLevel);
      case WidgetType.LISTVIEW:
        return _generateListViewCode(json, indentLevel);
      case WidgetType.INPUT:
        return _generateInputCode(json, indentLevel);
      case WidgetType.BUTTON:
        return _generateButtonCode(json, indentLevel);
      case WidgetType.TEXT:
        return _generateTextCode(json, indentLevel);
      case WidgetType.COLUMN:
        return _generateColumnCode(json, indentLevel);
      case WidgetType.ROW:
        return _generateRowCode(json, indentLevel);
      case WidgetType.CONTAINER:
        return _generateContainerCode(json, indentLevel);
      case WidgetType.IMAGE:
        return _generateImageCode(json, indentLevel);
      case WidgetType.COMPONENT:
        return _generateComponentCode(json, indentLevel);
      default:
        return '$indent Container()';
    }
  }

  static String _generateComponentCode(
      Map<String, dynamic> json, int indentLevel) {
    final indent = '  ' * indentLevel;
    final componentName =
        json['componentName']?.toString() ?? 'MyComponent';
    return '$indent ${pascalClassName(componentName)}()';
  }

  static String _generateColumnCode(
      Map<String, dynamic> json, int indentLevel) {
    final indent = '  ' * indentLevel;
    final buffer = StringBuffer();

    buffer.writeln('$indent Column(');
    buffer.writeln('$indent   children: [');

    final List<dynamic> children = json['children'] ?? [];
    for (var child in children) {
      buffer.writeln('${_generateCode(child, indentLevel: indentLevel + 2)},');
    }

    buffer.writeln('$indent   ],');
    buffer.write('$indent )');
    return buffer.toString();
  }

  static String _generateScaffoldCode(
      Map<String, dynamic> json, int indentLevel) {
    final indent = '  ' * indentLevel;
    final buffer = StringBuffer();

    buffer.writeln('$indent Scaffold(');

    if (json['appBar'] != null) {
      final appBarJson = Map<String, dynamic>.from(json['appBar']);
      final appBarChild = appBarJson['child'];
      buffer.writeln('$indent   appBar: AppBar(');
      if (appBarJson['centerTitle'] != null) {
        buffer.writeln(
            '$indent     centerTitle: ${appBarJson['centerTitle']},');
      }
      if (appBarChild != null) {
        buffer.writeln(
            '$indent     title: ${_generateCode(Map<String, dynamic>.from(appBarChild), indentLevel: indentLevel + 2)}');
      }
      buffer.writeln('$indent   ),');
    }

    if (json['child'] != null) {
      buffer.writeln(
          '$indent   body: ${_generateCode(Map<String, dynamic>.from(json['child']), indentLevel: indentLevel + 2)},');
    } else if (json['body'] != null) {
      buffer.writeln(
          '$indent   body: ${_generateCode(Map<String, dynamic>.from(json['body']), indentLevel: indentLevel + 2)},');
    }

    buffer.write('$indent )');
    return buffer.toString();
  }

  static String _generateListViewCode(
      Map<String, dynamic> json, int indentLevel) {
    final indent = '  ' * indentLevel;
    final buffer = StringBuffer();

    buffer.writeln('$indent ListView(');
    buffer.writeln('$indent   padding: const EdgeInsets.all(16),');
    buffer.writeln('$indent   children: [');

    final List<dynamic> children = json['children'] ?? [];
    for (var child in children) {
      buffer.writeln('${_generateCode(child, indentLevel: indentLevel + 2)},');
    }

    buffer.writeln('$indent   ],');
    buffer.write('$indent )');
    return buffer.toString();
  }

  static String _generateInputCode(Map<String, dynamic> json, int indentLevel) {
    final indent = '  ' * indentLevel;
    return '''$indent Padding(
$indent   padding: const EdgeInsets.symmetric(vertical: 8),
$indent   child: TextField(
$indent     decoration: InputDecoration(
$indent       labelText: '${escapeString(json['label']?.toString() ?? '')}',
$indent       hintText: ${json['hint'] != null ? "'${escapeString(json['hint'].toString())}'" : 'null'},
$indent       border: const OutlineInputBorder(),
$indent     ),
$indent     obscureText: ${json['isPassword'] ?? false},
$indent   ),
$indent )''';
  }

  static String _generateButtonCode(
      Map<String, dynamic> json, int indentLevel) {
    final indent = '  ' * indentLevel;
    return '''$indent ElevatedButton(
$indent   onPressed: () {},
$indent   child: Text('${escapeString(json['text']?.toString() ?? '')}'),
$indent   style: ElevatedButton.styleFrom(
$indent     minimumSize: const Size(double.infinity, 48),
$indent   ),
$indent )''';
  }

  static String _generateTextCode(Map<String, dynamic> json, int indentLevel) {
    final indent = '  ' * indentLevel;
    return '$indent Text("${escapeString(json['text']?.toString() ?? '')}")';
  }

  static String _generateRowCode(Map<String, dynamic> json, int indentLevel) {
    final indent = '  ' * indentLevel;
    final buffer = StringBuffer();

    buffer.writeln('$indent Row(');

    // Gestion du mainAxisAlignment
    if (json['mainAxisAlignment'] != null) {
      buffer.writeln(
          '$indent   mainAxisAlignment: MainAxisAlignment.${json['mainAxisAlignment']},');
    }

    // Gestion du crossAxisAlignment
    if (json['crossAxisAlignment'] != null) {
      buffer.writeln(
          '$indent   crossAxisAlignment: CrossAxisAlignment.${json['crossAxisAlignment']},');
    }

    // Gestion du mainAxisSize
    if (json['mainAxisSize'] != null) {
      buffer.writeln(
          '$indent   mainAxisSize: MainAxisSize.${json['mainAxisSize']},');
    }

    buffer.writeln('$indent   children: [');

    final List<dynamic> children = json['children'] ?? [];
    for (var child in children) {
      buffer.writeln('${_generateCode(child, indentLevel: indentLevel + 2)},');
    }

    buffer.writeln('$indent   ],');
    buffer.write('$indent )');
    return buffer.toString();
  }

  static String _generateContainerCode(
      Map<String, dynamic> json, int indentLevel) {
    final indent = '  ' * indentLevel;
    final buffer = StringBuffer();

    buffer.writeln('$indent Container(');

    // Gestion de la largeur
    if (json['width'] != null) {
      buffer.writeln('$indent   width: ${json['width']}.0,');
    }

    // Gestion de la hauteur
    if (json['height'] != null) {
      buffer.writeln('$indent   height: ${json['height']}.0,');
    }

    // Gestion du padding
    if (json['padding'] != null) {
      if (json['padding'] is num) {
        buffer.writeln(
            '$indent   padding: EdgeInsets.all(${json['padding']}.0),');
      } else if (json['padding'] is Map) {
        final padding = json['padding'] as Map;
        buffer.writeln('$indent   padding: EdgeInsets.only(');
        if (padding['left'] != null) {
          buffer.writeln('$indent     left: ${padding['left']}.0,');
        }
        if (padding['top'] != null) {
          buffer.writeln('$indent     top: ${padding['top']}.0,');
        }
        if (padding['right'] != null) {
          buffer.writeln('$indent     right: ${padding['right']}.0,');
        }
        if (padding['bottom'] != null) {
          buffer.writeln('$indent     bottom: ${padding['bottom']}.0,');
        }
        buffer.writeln('$indent   ),');
      }
    }

    // Gestion de la marge
    if (json['margin'] != null) {
      if (json['margin'] is num) {
        buffer
            .writeln('$indent   margin: EdgeInsets.all(${json['margin']}.0),');
      } else if (json['margin'] is Map) {
        final margin = json['margin'] as Map;
        buffer.writeln('$indent   margin: EdgeInsets.only(');
        if (margin['left'] != null) {
          buffer.writeln('$indent     left: ${margin['left']}.0,');
        }
        if (margin['top'] != null) {
          buffer.writeln('$indent     top: ${margin['top']}.0,');
        }
        if (margin['right'] != null) {
          buffer.writeln('$indent     right: ${margin['right']}.0,');
        }
        if (margin['bottom'] != null) {
          buffer.writeln('$indent     bottom: ${margin['bottom']}.0,');
        }
        buffer.writeln('$indent   ),');
      }
    }

    // Gestion de la décoration
    if (json['decoration'] != null ||
        json['backgroundColor'] != null ||
        json['borderRadius'] != null) {
      buffer.writeln('$indent   decoration: BoxDecoration(');

      // Couleur de fond
      if (json['backgroundColor'] != null) {
        buffer
            .writeln('$indent     color: Color(${json['backgroundColor']}),');
      }

      // Border radius
      if (json['borderRadius'] != null) {
        if (json['borderRadius'] is num) {
          buffer.writeln(
              '$indent     borderRadius: BorderRadius.circular(${json['borderRadius']}.0),');
        }
      }

      // Bordure
      if (json['border'] != null) {
        buffer.writeln('$indent     border: Border.all(');
        if (json['border']['color'] != null) {
          buffer.writeln(
              '$indent       color: Color(${json['border']['color']}),');
        }
        if (json['border']['width'] != null) {
          buffer.writeln('$indent       width: ${json['border']['width']}.0,');
        }
        buffer.writeln('$indent     ),');
      }

      buffer.writeln('$indent   ),');
    }

    // Gestion de l'enfant
    if (json['child'] != null) {
      buffer.writeln(
          '$indent   child: ${_generateCode(json['child'], indentLevel: indentLevel + 2)},');
    }

    buffer.write('$indent )');
    return buffer.toString();
  }

  static String _generateImageCode(Map<String, dynamic> json, int indentLevel) {
    final indent = '  ' * indentLevel;
    final buffer = StringBuffer();

    // Détermine le type d'image (network, asset, ou file)
    String imageType = json['imageType'] ?? 'network';
    String imageSource = json['src'] ?? '';

    buffer.writeln('$indent Image.$imageType(');

    // Source de l'image
    buffer.writeln('$indent   \'$imageSource\',');

    // Gestion de la largeur
    if (json['width'] != null) {
      buffer.writeln('$indent   width: ${json['width']}.0,');
    }

    // Gestion de la hauteur
    if (json['height'] != null) {
      buffer.writeln('$indent   height: ${json['height']}.0,');
    }

    // Gestion du fit
    if (json['fit'] != null) {
      buffer.writeln('$indent   fit: BoxFit.${json['fit']},');
    }

    // Gestion du loadingBuilder
    if (json['showLoadingIndicator'] == true) {
      buffer.writeln(
          '$indent   loadingBuilder: (context, child, loadingProgress) {');
      buffer.writeln('$indent     if (loadingProgress == null) return child;');
      buffer.writeln('$indent     return Center(');
      buffer.writeln('$indent       child: CircularProgressIndicator(');
      buffer.writeln(
          '$indent         value: loadingProgress.expectedTotalBytes != null');
      buffer.writeln(
          '$indent           ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!');
      buffer.writeln('$indent           : null,');
      buffer.writeln('$indent       ),');
      buffer.writeln('$indent     );');
      buffer.writeln('$indent   },');
    }

    // Gestion du errorBuilder
    if (json['showErrorWidget'] == true) {
      buffer.writeln('$indent   errorBuilder: (context, error, stackTrace) {');
      buffer.writeln('$indent     return Center(');
      buffer.writeln('$indent       child: Icon(Icons.error),');
      buffer.writeln('$indent     );');
      buffer.writeln('$indent   },');
    }

    buffer.write('$indent )');
    return buffer.toString();
  }
}
