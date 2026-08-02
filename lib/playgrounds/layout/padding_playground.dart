import 'package:flutter/material.dart';
import 'package:ui_training_model/core/playground_shell.dart';
import 'package:ui_training_model/core/property_binding.dart';

class PaddingPlayground extends StatefulWidget {
  const PaddingPlayground({super.key});

  @override
  State<PaddingPlayground> createState() => _PaddingPlaygroundState();
}

class _Ctrl extends PlaygroundController {
  double padding = 16;
  double margin = 12;
}

class _PaddingPlaygroundState extends State<PaddingPlayground> {
  final _c = _Ctrl();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PlaygroundShell(
      title: 'Padding / Margin',
      description: 'Unterschied zwischen Padding (innen) und Margin (außen).',
      controller: _c,
      bindings: [
        PropertyBinding<double>(
          codeName: 'padding',
          labelDe: 'Padding',
          helpDe: 'Innenabstand zwischen Rand und Inhalt.',
          type: PropertyControlType.slider,
          min: 0,
          max: 48,
          divisions: 48,
          getValue: () => _c.padding,
          setValue: (v) => _c.update(() => _c.padding = v),
        ),
        PropertyBinding<double>(
          codeName: 'margin',
          labelDe: 'Margin',
          helpDe: 'Außenabstand um den Container (über EdgeInsets).',
          type: PropertyControlType.slider,
          min: 0,
          max: 48,
          divisions: 48,
          getValue: () => _c.margin,
          setValue: (v) => _c.update(() => _c.margin = v),
        ),
      ],
      previewBuilder: (_) => Center(
        child: Container(
          color: Colors.teal.shade100,
          child: Container(
            margin: EdgeInsets.all(_c.margin),
            padding: EdgeInsets.all(_c.padding),
            color: Colors.teal,
            child: const Text('Inhalt', style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
    );
  }
}
