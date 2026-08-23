import 'package:flutter_test/flutter_test.dart';
import 'package:fluttrix/canvas/models/enums/widget.type.dart';
import 'package:fluttrix/canvas/models/generator/ftrix.widget.generator.dart';

Map<String, dynamic> textJson(String value) => {
      'id': 't1',
      'type': WidgetType.TEXT.name,
      'parentId': null,
      'setting': {},
      'text': value,
    };

Map<String, dynamic> scaffoldJson({
  Map<String, dynamic>? child,
  Map<String, dynamic>? appBar,
}) =>
    {
      'id': 's1',
      'type': WidgetType.SCAFFOLD.name,
      'parentId': null,
      'setting': {},
      if (appBar != null) 'appBar': appBar,
      if (child != null) 'child': child,
    };

void main() {
  group("FTrixWidgetGenerator", () {
    test("génère une classe StatelessWidget avec le bon nom", () {
      final code = FTrixWidgetGenerator.generateCodeFromJson(
        jsonMap: textJson('Bonjour'),
        className: 'Home',
      );
      expect(code, contains('class Home extends StatelessWidget'));
      expect(code, contains('Text("Bonjour")'));
    });

    test("le Scaffold génère le body à partir de la clé child", () {
      final code = FTrixWidgetGenerator.generateCodeFromJson(
        jsonMap: scaffoldJson(child: textJson('Salut')),
        className: 'Home',
      );
      expect(code, contains('Scaffold('));
      expect(code, contains('body:'));
      expect(code, contains('Text("Salut")'));
    });

    test("un composant est rendu comme un widget personnalisé", () {
      final code = FTrixWidgetGenerator.generateCodeFromJson(
        jsonMap: {
          'id': 'c1',
          'type': WidgetType.COMPONENT.name,
          'componentName': 'ma carte',
          'child': textJson('contenu'),
        },
        className: 'Home',
      );
      expect(code, contains('MaCarte()'));
    });

    test("collectComponents déduplique par nom et traverse en profondeur", () {
      final components = FTrixWidgetGenerator.collectComponents({
        'type': WidgetType.COLUMN.name,
        'children': [
          {'type': WidgetType.COMPONENT.name, 'componentName': 'Card'},
          {
            'type': WidgetType.COLUMN.name,
            'children': [
              {'type': WidgetType.COMPONENT.name, 'componentName': 'Card'},
              {
                'type': WidgetType.COMPONENT.name,
                'componentName': 'Header',
                'child': textJson('x'),
              },
            ],
          },
        ],
      });
      expect(components.length, 2);
      expect(components.map((c) => c.name), containsAll(['Card', 'Header']));
    });

    test("componentFileName convertit en snake_case", () {
      expect(
        FTrixWidgetGenerator.componentFileName('MonSuperComposant'),
        'mon_super_composant.dart',
      );
      expect(
        FTrixWidgetGenerator.componentFileName('Simple'),
        'simple.dart',
      );
    });

    test("generateComponentFile produit le fichier du composant", () {
      final code = FTrixWidgetGenerator.generateComponentFile(
        componentName: 'User Card',
        componentJson: {
          'type': WidgetType.COMPONENT.name,
          'componentName': 'User Card',
          'child': textJson('John Doe'),
        },
      );
      expect(code, contains('import \'package:flutter/material.dart\';'));
      expect(code, contains('class UserCard extends StatelessWidget'));
      expect(code, contains('Text("John Doe")'));
    });

    test("escapeString protège apostrophes, dollars et antislashs", () {
      expect(
        FTrixWidgetGenerator.escapeString("l'argent \$"),
        "l\\'argent \\\$",
      );
    });
  });
}
