import 'package:flutter/material.dart';
import 'package:ui_training_model/core/playground_shell.dart';
import 'package:ui_training_model/core/property_binding.dart';

class SizedBoxPlayground extends StatefulWidget {
  const SizedBoxPlayground({super.key});

  @override
  State<SizedBoxPlayground> createState() => _SizedBoxPlaygroundState();
}

class _Ctrl extends PlaygroundController {
  double width = 120;
  double height = 80;
}

class _SizedBoxPlaygroundState extends State<SizedBoxPlayground> {
  final _c = _Ctrl();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PlaygroundShell(
      title: 'SizedBox',
      description: 'Feste Größenbox – erzwingt width/height für das Kind.',
      controller: _c,
      bindings: [
        PropertyBinding<double>(
          codeName: 'width',
          labelDe: 'Breite',
          helpDe: 'SizedBox.width',
          type: PropertyControlType.slider,
          min: 20,
          max: 280,
          divisions: 52,
          getValue: () => _c.width,
          setValue: (v) => _c.update(() => _c.width = v),
        ),
        PropertyBinding<double>(
          codeName: 'height',
          labelDe: 'Höhe',
          helpDe: 'SizedBox.height',
          type: PropertyControlType.slider,
          min: 20,
          max: 280,
          divisions: 52,
          getValue: () => _c.height,
          setValue: (v) => _c.update(() => _c.height = v),
        ),
      ],
      previewBuilder: (_) => Center(
        child: ColoredBox(
          color: Colors.black12,
          child: SizedBox(
            width: _c.width,
            height: _c.height,
            child: const ColoredBox(
              color: Colors.teal,
              child: Center(
                child: Text('SizedBox', style: TextStyle(color: Colors.white)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
