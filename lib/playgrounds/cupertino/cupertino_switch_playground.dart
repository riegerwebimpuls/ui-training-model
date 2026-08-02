import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_training_model/catalog/widget_module.dart';
import 'package:ui_training_model/core/playground_shell.dart';
import 'package:ui_training_model/core/property_binding.dart';

class CupertinoSwitchPlayground extends StatefulWidget {
  const CupertinoSwitchPlayground({super.key});

  @override
  State<CupertinoSwitchPlayground> createState() =>
      _CupertinoSwitchPlaygroundState();
}

class _Ctrl extends PlaygroundController {
  bool value = true;
  Color activeColor = CupertinoColors.activeGreen;
  Color thumbColor = CupertinoColors.white;
}

class _CupertinoSwitchPlaygroundState extends State<CupertinoSwitchPlayground> {
  final _c = _Ctrl();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PlaygroundShell(
      title: 'CupertinoSwitch',
      description: 'iOS-Switch im Kontrast zum Material Switch.',
      moduleId: 'cupertino-switch',
      explanationDe:
          'CupertinoSwitch ist der iOS-Toggle: runde Thumb, farbige Spur '
          'im aktiven Zustand. thumbColor und activeTrackColor sind anpassbar.',
      useCaseDe:
          'Einstellungen in Cupertino-Apps, plattformgetreue iOS-Optik '
          'oder Vergleich mit Material Switch.',
      faq: const [
        ModuleFaq(
          question: 'Cupertino vs. Material Switch?',
          answer:
              'Cupertino: iOS-HIG mit grüner Spur; Material: Material-Design '
              'mit anderer Form und Animation.',
        ),
        ModuleFaq(
          question: 'Wann thumbColor ändern?',
          answer:
              'Selten nötig – Standard ist weiß. Anpassung für Dark Mode '
              'oder markenspezifische Themes.',
        ),
      ],
      controller: _c,
      previewHint: 'Schalter antippen',
      bindings: [
        PropertyBinding<bool>(
          codeName: 'value',
          labelDe: 'Wert',
          helpDe: 'CupertinoSwitch.value – ein/aus.',
          useCaseDe:
              'Boolean-Einstellungen: Benachrichtigungen, Dark Mode, WLAN.',
          type: PropertyControlType.switcher,
          getValue: () => _c.value,
          setValue: (v) => _c.update(() => _c.value = v),
        ),
        PropertyBinding<Color>(
          codeName: 'activeTrackColor',
          labelDe: 'Aktive Spur',
          helpDe: 'Farbe der Spur im eingeschalteten Zustand.',
          useCaseDe:
              'CupertinoColors.activeGreen ist iOS-Standard; Markenfarbe möglich.',
          type: PropertyControlType.color,
          getValue: () => _c.activeColor,
          setValue: (v) => _c.update(() => _c.activeColor = v),
        ),
        PropertyBinding<Color>(
          codeName: 'thumbColor',
          labelDe: 'Thumb-Farbe',
          helpDe: 'CupertinoSwitch.thumbColor – Farbe des Schiebeknopfs.',
          useCaseDe:
              'Meist weiß; anpassen für Dark Mode oder hohen Kontrast.',
          type: PropertyControlType.color,
          getValue: () => _c.thumbColor,
          setValue: (v) => _c.update(() => _c.thumbColor = v),
        ),
      ],
      previewBuilder: (_) => Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Material'),
            const SizedBox(width: 8),
            Switch(
              value: _c.value,
              onChanged: (v) => _c.update(() => _c.value = v),
            ),
            const SizedBox(width: 24),
            const Text('Cupertino'),
            const SizedBox(width: 8),
            CupertinoSwitch(
              value: _c.value,
              activeTrackColor: _c.activeColor,
              thumbColor: _c.thumbColor,
              onChanged: (v) => _c.update(() => _c.value = v),
            ),
          ],
        ),
      ),
    );
  }
}
