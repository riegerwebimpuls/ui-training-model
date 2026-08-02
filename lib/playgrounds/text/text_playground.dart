import 'package:flutter/material.dart';
import 'package:ui_training_model/core/playground_shell.dart';
import 'package:ui_training_model/core/property_binding.dart';

class TextPlayground extends StatefulWidget {
  const TextPlayground({super.key});

  @override
  State<TextPlayground> createState() => _TextPlaygroundState();
}

class _Ctrl extends PlaygroundController {
  String data = 'Hallo Flutter';
  double fontSize = 24;
  FontWeight fontWeight = FontWeight.w400;
  Color color = Colors.teal;
  TextAlign textAlign = TextAlign.center;
  double letterSpacing = 0;
}

class _TextPlaygroundState extends State<TextPlayground> {
  final _c = _Ctrl();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PlaygroundShell(
      title: 'Text / TextStyle',
      description: 'Typografie-Properties von Text und TextStyle.',
      controller: _c,
      bindings: [
        PropertyBinding<String>(
          codeName: 'data',
          labelDe: 'Text',
          helpDe: 'Angezeigter String-Inhalt.',
          type: PropertyControlType.text,
          getValue: () => _c.data,
          setValue: (v) => _c.update(() => _c.data = v),
        ),
        PropertyBinding<double>(
          codeName: 'fontSize',
          labelDe: 'Schriftgröße',
          helpDe: 'TextStyle.fontSize',
          type: PropertyControlType.slider,
          min: 10,
          max: 48,
          divisions: 38,
          getValue: () => _c.fontSize,
          setValue: (v) => _c.update(() => _c.fontSize = v),
        ),
        PropertyBinding<FontWeight>(
          codeName: 'fontWeight',
          labelDe: 'Schriftstärke',
          helpDe: 'TextStyle.fontWeight',
          type: PropertyControlType.enumeration,
          enumValues: const [
            FontWeight.w300,
            FontWeight.w400,
            FontWeight.w600,
            FontWeight.w800,
          ],
          enumLabels: const ['w300', 'w400', 'w600', 'w800'],
          getValue: () => _c.fontWeight,
          setValue: (v) => _c.update(() => _c.fontWeight = v),
        ),
        PropertyBinding<double>(
          codeName: 'letterSpacing',
          labelDe: 'Zeichenabstand',
          helpDe: 'TextStyle.letterSpacing',
          type: PropertyControlType.slider,
          min: -2,
          max: 8,
          divisions: 20,
          getValue: () => _c.letterSpacing,
          setValue: (v) => _c.update(() => _c.letterSpacing = v),
        ),
        PropertyBinding<TextAlign>(
          codeName: 'textAlign',
          labelDe: 'Ausrichtung',
          helpDe: 'Text.textAlign',
          type: PropertyControlType.enumeration,
          enumValues: const [
            TextAlign.left,
            TextAlign.center,
            TextAlign.right,
            TextAlign.justify,
          ],
          enumLabels: const ['left', 'center', 'right', 'justify'],
          getValue: () => _c.textAlign,
          setValue: (v) => _c.update(() => _c.textAlign = v),
        ),
        PropertyBinding<Color>(
          codeName: 'color',
          labelDe: 'Farbe',
          helpDe: 'TextStyle.color',
          type: PropertyControlType.color,
          getValue: () => _c.color,
          setValue: (v) => _c.update(() => _c.color = v),
        ),
      ],
      previewBuilder: (_) => Padding(
        padding: const EdgeInsets.all(24),
        child: Text(
          _c.data,
          textAlign: _c.textAlign,
          style: TextStyle(
            fontSize: _c.fontSize,
            fontWeight: _c.fontWeight,
            color: _c.color,
            letterSpacing: _c.letterSpacing,
          ),
        ),
      ),
    );
  }
}
