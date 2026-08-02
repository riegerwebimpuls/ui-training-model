import 'package:flutter/material.dart';
import 'package:ui_training_model/core/playground_shell.dart';
import 'package:ui_training_model/core/property_binding.dart';

enum ButtonVariant { elevated, filled, outlined, text, icon }

class ButtonPlayground extends StatefulWidget {
  const ButtonPlayground({super.key});

  @override
  State<ButtonPlayground> createState() => _ButtonPlaygroundState();
}

class _Ctrl extends PlaygroundController {
  ButtonVariant variant = ButtonVariant.filled;
  String label = 'Aktion';
  bool enabled = true;
  double borderRadius = 12;
}

class _ButtonPlaygroundState extends State<ButtonPlayground> {
  final _c = _Ctrl();
  int _taps = 0;

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PlaygroundShell(
      title: 'Buttons',
      description:
          'ElevatedButton, FilledButton, OutlinedButton, TextButton, IconButton.',
      controller: _c,
      previewHint: 'Tippen zählt Interaktionen',
      bindings: [
        PropertyBinding<ButtonVariant>(
          codeName: 'variant',
          labelDe: 'Variante',
          helpDe: 'Welche Button-Klasse gerendert wird.',
          type: PropertyControlType.enumeration,
          enumValues: ButtonVariant.values,
          enumLabels: const [
            'ElevatedButton',
            'FilledButton',
            'OutlinedButton',
            'TextButton',
            'IconButton',
          ],
          getValue: () => _c.variant,
          setValue: (v) => _c.update(() => _c.variant = v),
        ),
        PropertyBinding<String>(
          codeName: 'child / tooltip',
          labelDe: 'Label',
          helpDe: 'Beschriftung bzw. Tooltip beim IconButton.',
          type: PropertyControlType.text,
          getValue: () => _c.label,
          setValue: (v) => _c.update(() => _c.label = v),
        ),
        PropertyBinding<bool>(
          codeName: 'onPressed',
          labelDe: 'Aktiviert',
          helpDe: 'null onPressed deaktiviert den Button.',
          type: PropertyControlType.switcher,
          getValue: () => _c.enabled,
          setValue: (v) => _c.update(() => _c.enabled = v),
        ),
        PropertyBinding<double>(
          codeName: 'BorderRadius',
          labelDe: 'Eckenradius',
          helpDe: 'styleFrom shape RoundedRectangleBorder.',
          type: PropertyControlType.slider,
          min: 0,
          max: 28,
          divisions: 28,
          getValue: () => _c.borderRadius,
          setValue: (v) => _c.update(() => _c.borderRadius = v),
        ),
      ],
      previewBuilder: (_) {
        VoidCallback? onPressed =
            _c.enabled ? () => _c.update(() => _taps++) : null;
        final shape = RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_c.borderRadius),
        );
        final Widget button = switch (_c.variant) {
          ButtonVariant.elevated => ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(shape: shape),
              child: Text(_c.label),
            ),
          ButtonVariant.filled => FilledButton(
              onPressed: onPressed,
              style: FilledButton.styleFrom(shape: shape),
              child: Text(_c.label),
            ),
          ButtonVariant.outlined => OutlinedButton(
              onPressed: onPressed,
              style: OutlinedButton.styleFrom(shape: shape),
              child: Text(_c.label),
            ),
          ButtonVariant.text => TextButton(
              onPressed: onPressed,
              style: TextButton.styleFrom(shape: shape),
              child: Text(_c.label),
            ),
          ButtonVariant.icon => IconButton.filled(
              onPressed: onPressed,
              tooltip: _c.label,
              icon: const Icon(Icons.favorite),
            ),
        };
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            button,
            const SizedBox(height: 16),
            Text('Taps: $_taps'),
          ],
        );
      },
    );
  }
}
