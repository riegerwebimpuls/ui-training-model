import 'package:flutter/material.dart';
import 'package:ui_training_model/core/playground_shell.dart';
import 'package:ui_training_model/core/property_binding.dart';

class TextFieldPlayground extends StatefulWidget {
  const TextFieldPlayground({super.key});

  @override
  State<TextFieldPlayground> createState() => _TextFieldPlaygroundState();
}

class _Ctrl extends PlaygroundController {
  String labelText = 'E-Mail';
  String hintText = 'name@example.com';
  String helperText = 'Wir senden keinen Spam.';
  bool obscureText = false;
  bool enabled = true;
  int maxLines = 1;
}

class _TextFieldPlaygroundState extends State<TextFieldPlayground> {
  final _c = _Ctrl();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PlaygroundShell(
      title: 'TextField / InputDecoration',
      description: 'Eingabefeld mit Label, Hint, Helper und Obscure.',
      controller: _c,
      bindings: [
        PropertyBinding<String>(
          codeName: 'labelText',
          labelDe: 'Label',
          helpDe: 'InputDecoration.labelText',
          type: PropertyControlType.text,
          getValue: () => _c.labelText,
          setValue: (v) => _c.update(() => _c.labelText = v),
        ),
        PropertyBinding<String>(
          codeName: 'hintText',
          labelDe: 'Hinweis',
          helpDe: 'InputDecoration.hintText',
          type: PropertyControlType.text,
          getValue: () => _c.hintText,
          setValue: (v) => _c.update(() => _c.hintText = v),
        ),
        PropertyBinding<String>(
          codeName: 'helperText',
          labelDe: 'Hilfetext',
          helpDe: 'InputDecoration.helperText',
          type: PropertyControlType.text,
          getValue: () => _c.helperText,
          setValue: (v) => _c.update(() => _c.helperText = v),
        ),
        PropertyBinding<bool>(
          codeName: 'obscureText',
          labelDe: 'Passwortmodus',
          helpDe: 'TextField.obscureText',
          type: PropertyControlType.switcher,
          getValue: () => _c.obscureText,
          setValue: (v) => _c.update(() => _c.obscureText = v),
        ),
        PropertyBinding<bool>(
          codeName: 'enabled',
          labelDe: 'Aktiviert',
          helpDe: 'TextField.enabled',
          type: PropertyControlType.switcher,
          getValue: () => _c.enabled,
          setValue: (v) => _c.update(() => _c.enabled = v),
        ),
        PropertyBinding<double>(
          codeName: 'maxLines',
          labelDe: 'Max. Zeilen',
          helpDe: 'TextField.maxLines (bei obscure immer 1).',
          type: PropertyControlType.slider,
          min: 1,
          max: 5,
          divisions: 4,
          getValue: () => _c.maxLines.toDouble(),
          setValue: (v) => _c.update(() => _c.maxLines = v.round()),
        ),
      ],
      previewBuilder: (_) => Padding(
        padding: const EdgeInsets.all(24),
        child: TextField(
          enabled: _c.enabled,
          obscureText: _c.obscureText,
          maxLines: _c.obscureText ? 1 : _c.maxLines,
          decoration: InputDecoration(
            labelText: _c.labelText,
            hintText: _c.hintText,
            helperText: _c.helperText,
            border: const OutlineInputBorder(),
          ),
        ),
      ),
    );
  }
}
