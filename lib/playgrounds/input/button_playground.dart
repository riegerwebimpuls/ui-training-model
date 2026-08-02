import 'package:flutter/material.dart';
import 'package:ui_training_model/catalog/widget_module.dart';
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
  double elevation = 4;
}

class _ButtonPlaygroundState extends State<ButtonPlayground> {
  final _c = _Ctrl();
  int _taps = 0;

  static const _faq = [
    ModuleFaq(
      question: 'Wann ElevatedButton statt FilledButton?',
      answer:
          'ElevatedButton hebt sich durch Schatten ab – gut auf flachen Hintergründen. FilledButton ist der M3-Standard für primäre Aktionen mit Vollfarbe.',
    ),
    ModuleFaq(
      question: 'Wie deaktiviere ich einen Button?',
      answer:
          'Setze onPressed auf null. Der Button wird ausgegraut und ignoriert Taps – wichtig bei laufenden Requests oder ungültigen Formularen.',
    ),
  ];

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
      moduleId: 'buttons',
      explanationDe:
          'Material 3 bietet mehrere Button-Varianten mit gemeinsamen styleFrom-Parametern: shape, elevation (Elevated) und onPressed für Interaktivität.',
      useCaseDe:
          'Primäre Aktionen (Filled/Elevated), sekundäre (Outlined/Text) und kompakte Icon-Aktionen in Toolbars.',
      faq: _faq,
      controller: _c,
      previewHint: 'Tippen zählt Interaktionen',
      bindings: [
        PropertyBinding<ButtonVariant>(
          codeName: 'variant',
          labelDe: 'Variante',
          helpDe: 'Welche Button-Klasse gerendert wird.',
          useCaseDe: 'Hierarchie: eine primäre, restliche sekundäre Varianten.',
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
          useCaseDe: 'Klare Verben: „Speichern“, „Abbrechen“, „Teilen“.',
          type: PropertyControlType.text,
          getValue: () => _c.label,
          setValue: (v) => _c.update(() => _c.label = v),
        ),
        PropertyBinding<bool>(
          codeName: 'onPressed',
          labelDe: 'Aktiviert',
          helpDe: 'null onPressed deaktiviert den Button.',
          useCaseDe: 'Während Laden oder bei fehlender Berechtigung deaktivieren.',
          type: PropertyControlType.switcher,
          getValue: () => _c.enabled,
          setValue: (v) => _c.update(() => _c.enabled = v),
        ),
        PropertyBinding<double>(
          codeName: 'shape',
          labelDe: 'Eckenradius',
          helpDe: 'styleFrom shape: RoundedRectangleBorder.',
          useCaseDe: 'Abgerundete Chips (28) vs. leicht gerundete Formulare (8–12).',
          type: PropertyControlType.slider,
          min: 0,
          max: 28,
          divisions: 28,
          getValue: () => _c.borderRadius,
          setValue: (v) => _c.update(() => _c.borderRadius = v),
        ),
        PropertyBinding<double>(
          codeName: 'elevation',
          labelDe: 'Elevation',
          helpDe: 'ElevatedButton.styleFrom elevation – nur bei ElevatedButton.',
          useCaseDe: 'Schattenhöhe für visuelle Hierarchie auf flachen Flächen.',
          type: PropertyControlType.slider,
          min: 0,
          max: 12,
          divisions: 12,
          getValue: () => _c.elevation,
          setValue: (v) => _c.update(() => _c.elevation = v),
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
              style: ElevatedButton.styleFrom(
                shape: shape,
                elevation: _c.elevation,
              ),
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
          ButtonVariant.icon => IconButton(
              onPressed: onPressed,
              tooltip: _c.label,
              style: IconButton.styleFrom(shape: shape),
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
