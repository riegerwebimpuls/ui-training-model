import 'package:flutter/material.dart';
import 'package:ui_training_model/core/playground_shell.dart';
import 'package:ui_training_model/core/property_binding.dart';

class StackPlayground extends StatefulWidget {
  const StackPlayground({super.key});

  @override
  State<StackPlayground> createState() => _StackPlaygroundState();
}

class _Ctrl extends PlaygroundController {
  double top = 40;
  double left = 40;
  AlignmentGeometry alignment = Alignment.center;
  Clip clipBehavior = Clip.hardEdge;
}

class _StackPlaygroundState extends State<StackPlayground> {
  final _c = _Ctrl();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PlaygroundShell(
      title: 'Stack / Positioned',
      description: 'Überlagerte Widgets mit Alignment und Positioned.',
      controller: _c,
      bindings: [
        PropertyBinding<double>(
          codeName: 'Positioned.top',
          labelDe: 'Top',
          helpDe: 'Abstand des Positioned-Kinds vom oberen Rand.',
          type: PropertyControlType.slider,
          min: 0,
          max: 200,
          divisions: 40,
          getValue: () => _c.top,
          setValue: (v) => _c.update(() => _c.top = v),
        ),
        PropertyBinding<double>(
          codeName: 'Positioned.left',
          labelDe: 'Left',
          helpDe: 'Abstand des Positioned-Kinds vom linken Rand.',
          type: PropertyControlType.slider,
          min: 0,
          max: 200,
          divisions: 40,
          getValue: () => _c.left,
          setValue: (v) => _c.update(() => _c.left = v),
        ),
        PropertyBinding<Alignment>(
          codeName: 'alignment',
          labelDe: 'Alignment',
          helpDe: 'Standard-Ausrichtung nicht-positionierter Kinder.',
          type: PropertyControlType.enumeration,
          enumValues: const [
            Alignment.topLeft,
            Alignment.topCenter,
            Alignment.center,
            Alignment.bottomRight,
          ],
          enumLabels: const ['topLeft', 'topCenter', 'center', 'bottomRight'],
          getValue: () => _c.alignment as Alignment,
          setValue: (v) => _c.update(() => _c.alignment = v),
        ),
        PropertyBinding<Clip>(
          codeName: 'clipBehavior',
          labelDe: 'Clip',
          helpDe: 'Ob überstehende Kinder abgeschnitten werden.',
          type: PropertyControlType.enumeration,
          enumValues: const [Clip.none, Clip.hardEdge, Clip.antiAlias],
          enumLabels: const ['none', 'hardEdge', 'antiAlias'],
          getValue: () => _c.clipBehavior,
          setValue: (v) => _c.update(() => _c.clipBehavior = v),
        ),
      ],
      previewBuilder: (_) => Padding(
        padding: const EdgeInsets.all(24),
        child: Container(
          color: Colors.blueGrey.shade100,
          child: Stack(
            alignment: _c.alignment,
            clipBehavior: _c.clipBehavior,
            children: [
              Container(width: 180, height: 180, color: Colors.teal.shade200),
              Positioned(
                top: _c.top,
                left: _c.left,
                child: Container(
                  width: 72,
                  height: 72,
                  color: Colors.orange,
                  alignment: Alignment.center,
                  child: const Text('Pos'),
                ),
              ),
              Container(
                width: 48,
                height: 48,
                decoration: const BoxDecoration(
                  color: Colors.indigo,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
