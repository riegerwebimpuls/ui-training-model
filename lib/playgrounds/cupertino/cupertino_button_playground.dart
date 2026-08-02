import 'package:flutter/cupertino.dart';
import 'package:ui_training_model/catalog/widget_module.dart';
import 'package:ui_training_model/core/playground_shell.dart';
import 'package:ui_training_model/core/property_binding.dart';

class CupertinoButtonPlayground extends StatefulWidget {
  const CupertinoButtonPlayground({super.key});

  @override
  State<CupertinoButtonPlayground> createState() =>
      _CupertinoButtonPlaygroundState();
}

class _Ctrl extends PlaygroundController {
  String label = 'Cupertino';
  bool filled = true;
  bool enabled = true;
  double pressedOpacity = 0.4;
  double borderRadius = 8;
  double padding = 16;
  int taps = 0;
}

class _CupertinoButtonPlaygroundState extends State<CupertinoButtonPlayground> {
  final _c = _Ctrl();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PlaygroundShell(
      title: 'CupertinoButton',
      description: 'iOS-Style Button zum Kontrast mit Material Buttons.',
      moduleId: 'cupertino-button',
      explanationDe:
          'CupertinoButton folgt dem iOS-Look: flach oder filled, mit '
          'pressedOpacity beim Drücken und anpassbarem padding.',
      useCaseDe:
          'Cupertino-Apps, plattformübergreifende iOS-Optik oder '
          'Hybrid-Screens neben Material-Widgets.',
      faq: const [
        ModuleFaq(
          question: 'filled vs. plain?',
          answer:
              'CupertinoButton.filled hat Hintergrundfarbe (primär iOS-blau); '
              'plain ist Text-only mit Tap-Feedback.',
        ),
        ModuleFaq(
          question: 'Wozu padding?',
          answer:
              'Größere Tap-Fläche und luftigeres Layout – wichtig für '
              'Touch-Ziele nach HIG (~44 pt).',
        ),
      ],
      controller: _c,
      previewHint: 'Button antippen',
      bindings: [
        PropertyBinding<String>(
          codeName: 'child',
          labelDe: 'Label',
          helpDe: 'Kind-Text des Buttons.',
          useCaseDe:
              'Kurze Verben: „Weiter“, „Fertig“, „Abbrechen“.',
          type: PropertyControlType.text,
          getValue: () => _c.label,
          setValue: (v) => _c.update(() => _c.label = v),
        ),
        PropertyBinding<bool>(
          codeName: 'CupertinoButton.filled',
          labelDe: 'Filled',
          helpDe: 'CupertinoButton.filled vs. plain.',
          useCaseDe:
              'filled für primäre Aktion; plain für sekundäre Links.',
          type: PropertyControlType.switcher,
          getValue: () => _c.filled,
          setValue: (v) => _c.update(() => _c.filled = v),
        ),
        PropertyBinding<bool>(
          codeName: 'onPressed',
          labelDe: 'Aktiviert',
          helpDe: 'null onPressed deaktiviert den Button.',
          useCaseDe:
              'Deaktivieren, wenn Formular unvollständig oder Aktion gesperrt.',
          type: PropertyControlType.switcher,
          getValue: () => _c.enabled,
          setValue: (v) => _c.update(() => _c.enabled = v),
        ),
        PropertyBinding<double>(
          codeName: 'pressedOpacity',
          labelDe: 'Pressed Opacity',
          helpDe: 'Deckkraft beim Drücken (pressedOpacity).',
          useCaseDe:
              '~0,4 ist iOS-typisch; höher = weniger sichtbares Feedback.',
          type: PropertyControlType.slider,
          min: 0.1,
          max: 1,
          divisions: 18,
          getValue: () => _c.pressedOpacity,
          setValue: (v) => _c.update(() => _c.pressedOpacity = v),
        ),
        PropertyBinding<double>(
          codeName: 'borderRadius',
          labelDe: 'Eckenradius',
          helpDe: 'CupertinoButton.borderRadius.',
          useCaseDe:
              '8 px iOS-Standard; 0 für eckige Buttons.',
          type: PropertyControlType.slider,
          min: 0,
          max: 24,
          divisions: 24,
          getValue: () => _c.borderRadius,
          setValue: (v) => _c.update(() => _c.borderRadius = v),
        ),
        PropertyBinding<double>(
          codeName: 'padding',
          labelDe: 'Innenabstand',
          helpDe: 'CupertinoButton.padding – horizontal/vertikal.',
          useCaseDe:
              'Größeres padding für breitere Buttons und bessere Erreichbarkeit.',
          type: PropertyControlType.slider,
          min: 0,
          max: 32,
          divisions: 32,
          getValue: () => _c.padding,
          setValue: (v) => _c.update(() => _c.padding = v),
        ),
      ],
      previewBuilder: (_) {
        final onPressed =
            _c.enabled ? () => _c.update(() => _c.taps++) : null;
        final child = Text(_c.label);
        final edgePadding = EdgeInsets.all(_c.padding);
        final button = _c.filled
            ? CupertinoButton.filled(
                onPressed: onPressed,
                pressedOpacity: _c.pressedOpacity,
                borderRadius: BorderRadius.circular(_c.borderRadius),
                padding: edgePadding,
                child: child,
              )
            : CupertinoButton(
                onPressed: onPressed,
                pressedOpacity: _c.pressedOpacity,
                borderRadius: BorderRadius.circular(_c.borderRadius),
                padding: edgePadding,
                child: child,
              );
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            button,
            const SizedBox(height: 16),
            Text('Taps: ${_c.taps}'),
          ],
        );
      },
    );
  }
}
