import 'package:flutter/material.dart';
import 'package:ui_training_model/core/playground_shell.dart';
import 'package:ui_training_model/core/property_binding.dart';

class FlexPlayground extends StatefulWidget {
  const FlexPlayground({super.key});

  @override
  State<FlexPlayground> createState() => _FlexPlaygroundState();
}

class _Ctrl extends PlaygroundController {
  bool isRow = true;
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

  @override
  Widget build(BuildContext context) {
    return PlaygroundShell(
      title: 'Row / Column / Expanded',
      description: 'Flex-Layout mit Main-/CrossAxisAlignment und Expanded-Flex.',
      controller: _c,
      bindings: [
        PropertyBinding<bool>(
          codeName: 'Row vs Column',
          labelDe: 'Als Row',
          helpDe: 'true = Row (horizontal), false = Column (vertikal).',
          type: PropertyControlType.switcher,
          getValue: () => _c.isRow,
          setValue: (v) => _c.update(() => _c.isRow = v),
        ),
        PropertyBinding<MainAxisAlignment>(
          codeName: 'mainAxisAlignment',
          labelDe: 'Hauptachse',
          helpDe: 'Ausrichtung entlang der Hauptachse.',
          type: PropertyControlType.enumeration,
          enumValues: MainAxisAlignment.values,
          enumLabels: MainAxisAlignment.values.map((e) => e.name).toList(),
          getValue: () => _c.mainAxisAlignment,
          setValue: (v) => _c.update(() => _c.mainAxisAlignment = v),
        ),
        PropertyBinding<CrossAxisAlignment>(
          codeName: 'crossAxisAlignment',
          labelDe: 'Querachse',
          helpDe: 'Ausrichtung entlang der Querachse.',
          type: PropertyControlType.enumeration,
          enumValues: [
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
          helpDe: 'Flex-Faktor des ersten Expanded-Kinds.',
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
          helpDe: 'Flex-Faktor des zweiten Expanded-Kinds.',
          type: PropertyControlType.slider,
          min: 1,
          max: 5,
          divisions: 4,
          getValue: () => _c.flexB.toDouble(),
          setValue: (v) => _c.update(() => _c.flexB = v.round()),
        ),
      ],
      previewBuilder: (_) {
        final children = [
          Expanded(
            flex: _c.flexA,
            child: Container(
              color: Colors.teal,
              alignment: Alignment.center,
              child: Text('A (${_c.flexA})', style: const TextStyle(color: Colors.white)),
            ),
          ),
          Expanded(
            flex: _c.flexB,
            child: Container(
              color: Colors.orange,
              alignment: Alignment.center,
              child: Text('B (${_c.flexB})', style: const TextStyle(color: Colors.white)),
            ),
          ),
          Container(
            width: 40,
            height: 40,
            color: Colors.indigo,
            alignment: Alignment.center,
            child: const Text('C', style: TextStyle(color: Colors.white)),
          ),
        ];
        return Padding(
          padding: const EdgeInsets.all(16),
          child: _c.isRow
              ? Row(
                  mainAxisAlignment: _c.mainAxisAlignment,
                  crossAxisAlignment: _c.crossAxisAlignment,
                  children: children,
                )
              : Column(
                  mainAxisAlignment: _c.mainAxisAlignment,
                  crossAxisAlignment: _c.crossAxisAlignment,
                  children: children,
                ),
        );
      },
    );
  }
}
