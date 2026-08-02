import 'package:flutter/material.dart';
import 'package:ui_training_model/core/playground_shell.dart';
import 'package:ui_training_model/core/property_binding.dart';

class IconPlayground extends StatefulWidget {
  const IconPlayground({super.key});

  @override
  State<IconPlayground> createState() => _IconPlaygroundState();
}

class _Ctrl extends PlaygroundController {
  double size = 48;
  Color color = Colors.teal;
  double fill = 0;
  int iconIndex = 0;
}

class _IconPlaygroundState extends State<IconPlayground> {
  final _c = _Ctrl();
  static const _icons = [
    Icons.favorite,
    Icons.home,
    Icons.settings,
    Icons.star,
    Icons.bolt,
  ];

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PlaygroundShell(
      title: 'Icon',
      description: 'Material Icons mit size, color und fill.',
      controller: _c,
      bindings: [
        PropertyBinding<double>(
          codeName: 'icon',
          labelDe: 'Icon-Auswahl',
          helpDe: 'Welches IconData verwendet wird.',
          type: PropertyControlType.slider,
          min: 0,
          max: (_icons.length - 1).toDouble(),
          divisions: _icons.length - 1,
          getValue: () => _c.iconIndex.toDouble(),
          setValue: (v) => _c.update(() => _c.iconIndex = v.round()),
        ),
        PropertyBinding<double>(
          codeName: 'size',
          labelDe: 'Größe',
          helpDe: 'Icon.size in logischen Pixeln.',
          type: PropertyControlType.slider,
          min: 16,
          max: 96,
          divisions: 40,
          getValue: () => _c.size,
          setValue: (v) => _c.update(() => _c.size = v),
        ),
        PropertyBinding<double>(
          codeName: 'fill',
          labelDe: 'Fill',
          helpDe: 'Icon.fill (0–1) für variable Fonts.',
          type: PropertyControlType.slider,
          min: 0,
          max: 1,
          divisions: 10,
          getValue: () => _c.fill,
          setValue: (v) => _c.update(() => _c.fill = v),
        ),
        PropertyBinding<Color>(
          codeName: 'color',
          labelDe: 'Farbe',
          helpDe: 'Icon.color',
          type: PropertyControlType.color,
          getValue: () => _c.color,
          setValue: (v) => _c.update(() => _c.color = v),
        ),
      ],
      previewBuilder: (_) => Center(
        child: Icon(
          _icons[_c.iconIndex],
          size: _c.size,
          color: _c.color,
          fill: _c.fill,
        ),
      ),
    );
  }
}
