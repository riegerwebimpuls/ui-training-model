import 'package:flutter/material.dart';
import 'package:ui_training_model/core/playground_shell.dart';
import 'package:ui_training_model/core/property_binding.dart';

class ContainerPlayground extends StatefulWidget {
  const ContainerPlayground({super.key});

  @override
  State<ContainerPlayground> createState() => _ContainerPlaygroundState();
}

class _Ctrl extends PlaygroundController {
  double width = 160;
  double height = 120;
  double borderRadius = 12;
  double padding = 16;
  Color color = Colors.teal;
  double elevation = 4;
}

class _ContainerPlaygroundState extends State<ContainerPlayground> {
  final _c = _Ctrl();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PlaygroundShell(
      title: 'Container / DecoratedBox',
      description: 'Größe, Farbe, Padding und BorderRadius eines Containers.',
      controller: _c,
      bindings: [
        PropertyBinding<double>(
          codeName: 'width',
          labelDe: 'Breite',
          helpDe: 'Feste Breite des Containers.',
          type: PropertyControlType.slider,
          min: 40,
          max: 280,
          divisions: 48,
          getValue: () => _c.width,
          setValue: (v) => _c.update(() => _c.width = v),
        ),
        PropertyBinding<double>(
          codeName: 'height',
          labelDe: 'Höhe',
          helpDe: 'Feste Höhe des Containers.',
          type: PropertyControlType.slider,
          min: 40,
          max: 280,
          divisions: 48,
          getValue: () => _c.height,
          setValue: (v) => _c.update(() => _c.height = v),
        ),
        PropertyBinding<double>(
          codeName: 'borderRadius',
          labelDe: 'Eckenradius',
          helpDe: 'BorderRadius.circular(...) der BoxDecoration.',
          type: PropertyControlType.slider,
          min: 0,
          max: 64,
          divisions: 64,
          getValue: () => _c.borderRadius,
          setValue: (v) => _c.update(() => _c.borderRadius = v),
        ),
        PropertyBinding<double>(
          codeName: 'padding',
          labelDe: 'Innenabstand',
          helpDe: 'padding um das Kind herum.',
          type: PropertyControlType.slider,
          min: 0,
          max: 48,
          divisions: 48,
          getValue: () => _c.padding,
          setValue: (v) => _c.update(() => _c.padding = v),
        ),
        PropertyBinding<double>(
          codeName: 'elevation',
          labelDe: 'Elevation',
          helpDe: 'Schattentiefe (Material elevation).',
          type: PropertyControlType.slider,
          min: 0,
          max: 24,
          divisions: 24,
          getValue: () => _c.elevation,
          setValue: (v) => _c.update(() => _c.elevation = v),
        ),
        PropertyBinding<Color>(
          codeName: 'color',
          labelDe: 'Farbe',
          helpDe: 'Hintergrundfarbe (color / BoxDecoration.color).',
          type: PropertyControlType.color,
          getValue: () => _c.color,
          setValue: (v) => _c.update(() => _c.color = v),
        ),
      ],
      previewBuilder: (_) => Center(
        child: Material(
          elevation: _c.elevation,
          borderRadius: BorderRadius.circular(_c.borderRadius),
          color: _c.color,
          child: Container(
            width: _c.width,
            height: _c.height,
            padding: EdgeInsets.all(_c.padding),
            alignment: Alignment.center,
            child: const Text('Kind', style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
    );
  }
}
