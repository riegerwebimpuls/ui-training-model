import 'package:flutter/material.dart';
import 'package:ui_training_model/catalog/widget_module.dart';
import 'package:ui_training_model/core/playground_shell.dart';
import 'package:ui_training_model/core/property_binding.dart';

class FlexPlayground extends StatefulWidget {
  const FlexPlayground({super.key});

  @override
  State<FlexPlayground> createState() => _FlexPlaygroundState();
}

class _Ctrl extends PlaygroundController {
  bool isRow = true;
  bool useExpanded = false;
  MainAxisSize mainAxisSize = MainAxisSize.max;
  MainAxisAlignment mainAxisAlignment = MainAxisAlignment.center;
  CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center;
  int flexA = 1;
  int flexB = 2;
}

class _FlexPlaygroundState extends State<FlexPlayground> {
  final _c = _Ctrl();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  Widget _childA() {
    if (_c.useExpanded) {
      return Expanded(
        flex: _c.flexA,
        child: Container(
          color: Colors.teal,
          alignment: Alignment.center,
          child: Text(
            'A (${_c.flexA})',
            style: const TextStyle(color: Colors.white),
          ),
        ),
      );
    }
    return Container(
      width: _c.isRow ? 56 : null,
      height: _c.isRow ? null : 48,
      color: Colors.teal,
      alignment: Alignment.center,
      child: const Text('A', style: TextStyle(color: Colors.white)),
    );
  }

  Widget _childB() {
    if (_c.useExpanded) {
      return Expanded(
        flex: _c.flexB,
        child: Container(
          color: Colors.orange,
          alignment: Alignment.center,
          child: Text(
            'B (${_c.flexB})',
            style: const TextStyle(color: Colors.white),
          ),
        ),
      );
    }
    return Container(
      width: _c.isRow ? 72 : null,
      height: _c.isRow ? null : 64,
      color: Colors.orange,
      alignment: Alignment.center,
      child: const Text('B', style: TextStyle(color: Colors.white)),
    );
  }

  Widget _childC() {
    return Container(
      width: 40,
      height: 40,
      color: Colors.indigo,
      alignment: Alignment.center,
      child: const Text('C', style: TextStyle(color: Colors.white)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlaygroundShell(
      moduleId: 'flex',
      title: 'Row / Column / Expanded',
      description: 'Flex-Layout mit Main-/CrossAxisAlignment und Expanded-Flex.',
      explanationDe:
          'Row ordnet Kinder horizontal, Column vertikal. mainAxisAlignment '
          'verteilt entlang der Hauptachse – am deutlichsten mit festen '
          'Kindgrößen (useExpanded aus). Mit Expanded füllen Kinder den '
          'freien Platz nach flex-Faktor.',
      useCaseDe:
          'Toolbars, Button-Reihen, Formularzeilen und responsive Layouts.',
      faq: const [
        ModuleFaq(
          question: 'Wann Expanded statt fester Größe?',
          answer:
              'Expanded, wenn Kinder den verfügbaren Platz teilen sollen '
              '(z. B. zwei Spalten). Feste Größen, wenn mainAxisAlignment '
              'sichtbar bleiben soll.',
        ),
        ModuleFaq(
          question: 'mainAxisSize.max vs. min?',
          answer:
              'max: Row/Column nimmt die volle Breite/Höhe des Elterns. '
              'min: nur so breit/hoch wie die Kinder – z. B. kompakte Chips.',
        ),
        ModuleFaq(
          question: 'Was macht crossAxisAlignment?',
          answer:
              'Ausrichtung senkrecht zur Hauptachse: start, center, end oder '
              'stretch (Kinder auf volle Querachse dehnen).',
        ),
      ],
      previewHint: 'useExpanded aus → mainAxisAlignment sichtbar',
      controller: _c,
      bindings: [
        PropertyBinding<bool>(
          codeName: 'Row vs Column',
          labelDe: 'Als Row',
          helpDe: 'true = Row (horizontal), false = Column (vertikal).',
          useCaseDe: 'Horizontale Toolbars vs. vertikale Formular-Spalten.',
          type: PropertyControlType.switcher,
          getValue: () => _c.isRow,
          setValue: (v) => _c.update(() => _c.isRow = v),
        ),
        PropertyBinding<bool>(
          codeName: 'useExpanded',
          labelDe: 'Expanded nutzen',
          helpDe: 'true = Expanded-Kinder mit flex; false = feste Kindgrößen.',
          useCaseDe: 'Platzverteilung vs. sichtbare mainAxisAlignment-Demo.',
          type: PropertyControlType.switcher,
          getValue: () => _c.useExpanded,
          setValue: (v) => _c.update(() => _c.useExpanded = v),
        ),
        PropertyBinding<MainAxisSize>(
          codeName: 'mainAxisSize',
          labelDe: 'Hauptachsen-Größe',
          helpDe: 'max = volle Elterngröße, min = nur so groß wie nötig.',
          useCaseDe: 'Volle Breite Toolbar vs. kompakte Button-Gruppe.',
          type: PropertyControlType.enumeration,
          enumValues: MainAxisSize.values,
          enumLabels: const ['max', 'min'],
          getValue: () => _c.mainAxisSize,
          setValue: (v) => _c.update(() => _c.mainAxisSize = v),
        ),
        PropertyBinding<MainAxisAlignment>(
          codeName: 'mainAxisAlignment',
          labelDe: 'Hauptachse',
          helpDe: 'Ausrichtung entlang der Hauptachse (start … spaceAround).',
          useCaseDe: 'Buttons links/rechts/zentriert oder gleichmäßig verteilt.',
          type: PropertyControlType.enumeration,
          enumValues: MainAxisAlignment.values,
          enumLabels: MainAxisAlignment.values.map((e) => e.name).toList(),
          getValue: () => _c.mainAxisAlignment,
          setValue: (v) => _c.update(() => _c.mainAxisAlignment = v),
        ),
        PropertyBinding<CrossAxisAlignment>(
          codeName: 'crossAxisAlignment',
          labelDe: 'Querachse',
          helpDe: 'Ausrichtung senkrecht zur Hauptachse.',
          useCaseDe: 'Icons und Text auf einer Linie oder gestreckt.',
          type: PropertyControlType.enumeration,
          enumValues: const [
            CrossAxisAlignment.start,
            CrossAxisAlignment.center,
            CrossAxisAlignment.end,
            CrossAxisAlignment.stretch,
          ],
          enumLabels: const ['start', 'center', 'end', 'stretch'],
          getValue: () => _c.crossAxisAlignment,
          setValue: (v) => _c.update(() => _c.crossAxisAlignment = v),
        ),
        PropertyBinding<double>(
          codeName: 'Expanded.flex (A)',
          labelDe: 'Flex Kind A',
          helpDe: 'Flex-Faktor des ersten Expanded-Kinds (nur bei useExpanded).',
          useCaseDe: 'Größere Sidebar vs. schmaleres Nebenpanel.',
          type: PropertyControlType.slider,
          min: 1,
          max: 5,
          divisions: 4,
          getValue: () => _c.flexA.toDouble(),
          setValue: (v) => _c.update(() => _c.flexA = v.round()),
        ),
        PropertyBinding<double>(
          codeName: 'Expanded.flex (B)',
          labelDe: 'Flex Kind B',
          helpDe: 'Flex-Faktor des zweiten Expanded-Kinds (nur bei useExpanded).',
          useCaseDe: 'Hauptinhalt breiter als Nebenleiste (z. B. flex 2:1).',
          type: PropertyControlType.slider,
          min: 1,
          max: 5,
          divisions: 4,
          getValue: () => _c.flexB.toDouble(),
          setValue: (v) => _c.update(() => _c.flexB = v.round()),
        ),
      ],
      previewBuilder: (_) {
        final children = [_childA(), _childB(), _childC()];
        return Padding(
          padding: const EdgeInsets.all(16),
          child: ColoredBox(
            color: Colors.grey.shade200,
            child: _c.isRow
                ? Row(
                    mainAxisSize: _c.mainAxisSize,
                    mainAxisAlignment: _c.mainAxisAlignment,
                    crossAxisAlignment: _c.crossAxisAlignment,
                    children: children,
                  )
                : Column(
                    mainAxisSize: _c.mainAxisSize,
                    mainAxisAlignment: _c.mainAxisAlignment,
                    crossAxisAlignment: _c.crossAxisAlignment,
                    children: children,
                  ),
          ),
        );
      },
    );
  }
}
