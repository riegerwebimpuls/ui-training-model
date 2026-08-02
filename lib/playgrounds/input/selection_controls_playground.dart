import 'package:flutter/material.dart';
import 'package:ui_training_model/catalog/widget_module.dart';
import 'package:ui_training_model/core/playground_shell.dart';
import 'package:ui_training_model/core/property_binding.dart';

class SelectionControlsPlayground extends StatefulWidget {
  const SelectionControlsPlayground({super.key});

  @override
  State<SelectionControlsPlayground> createState() =>
      _SelectionControlsPlaygroundState();
}

class _Ctrl extends PlaygroundController {
  bool switchValue = true;
  bool? checkboxValue = false;
  bool checkboxTristate = false;
  double sliderValue = 40;
  double sliderMin = 0;
  double sliderMax = 100;
  String dropdownValue = 'Eins';
}

class _SelectionControlsPlaygroundState
    extends State<SelectionControlsPlayground> {
  final _c = _Ctrl();

  static const _faq = [
    ModuleFaq(
      question: 'Was bedeutet tristate bei Checkbox?',
      answer:
          'tristate: true erlaubt null als dritten Zustand (indeterminate) – z. B. „teilweise ausgewählt“ in Baum-Listen.',
    ),
    ModuleFaq(
      question: 'Warum min und max beim Slider setzen?',
      answer:
          'Slider braucht einen Wertebereich. min/max definieren Skala und Grenzen – z. B. 0–100 für Prozent oder 1–5 für Sterne.',
    ),
  ];

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  void _toggleCheckbox(bool? value) {
    _c.update(() {
      if (_c.checkboxTristate) {
        _c.checkboxValue = value;
      } else {
        _c.checkboxValue = value ?? false;
      }
    });
  }

  void _cycleTristateCheckbox() {
    _c.update(() {
      if (_c.checkboxValue == false) {
        _c.checkboxValue = true;
      } else if (_c.checkboxValue == true) {
        _c.checkboxValue = null;
      } else {
        _c.checkboxValue = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return PlaygroundShell(
      title: 'Switch / Checkbox / Slider / Dropdown',
      description: 'Auswahl-Controls und ihre Kern-Properties.',
      moduleId: 'selection',
      explanationDe:
          'Switch, Checkbox, Slider und DropdownButton decken die häufigsten Auswahl-Patterns ab. Slider min/max begrenzen den Wertebereich; Checkbox kann tristate sein.',
      useCaseDe:
          'Einstellungen, Filter, Formulare und jede binäre oder skalierte Benutzerauswahl.',
      faq: _faq,
      previewHint: 'Controls in der Vorschau sind interaktiv',
      controller: _c,
      bindings: [
        PropertyBinding<bool>(
          codeName: 'Switch.value',
          labelDe: 'Switch',
          helpDe: 'Aktueller Bool-Wert des Switches.',
          useCaseDe: 'Ein/Aus-Einstellungen: Benachrichtigungen, Dark Mode.',
          type: PropertyControlType.switcher,
          getValue: () => _c.switchValue,
          setValue: (v) => _c.update(() => _c.switchValue = v),
        ),
        PropertyBinding<bool>(
          codeName: 'Checkbox.tristate',
          labelDe: 'Checkbox Tristate',
          helpDe: 'Checkbox.tristate erlaubt null (indeterminate).',
          useCaseDe: 'Master-Checkbox in Listen mit Teilauswahl.',
          type: PropertyControlType.switcher,
          getValue: () => _c.checkboxTristate,
          setValue: (v) => _c.update(() {
            _c.checkboxTristate = v;
            if (!v && _c.checkboxValue == null) {
              _c.checkboxValue = false;
            }
          }),
        ),
        PropertyBinding<bool>(
          codeName: 'Checkbox.value',
          labelDe: 'Checkbox',
          helpDe: 'Aktueller Wert – bei Tristate auch null möglich.',
          useCaseDe: 'Mehrfachauswahl, Zustimmung, Feature-Toggles in Listen.',
          type: PropertyControlType.switcher,
          getValue: () => _c.checkboxValue ?? false,
          setValue: (v) => _c.update(() => _c.checkboxValue = v),
        ),
        PropertyBinding<double>(
          codeName: 'Slider.min',
          labelDe: 'Slider Min',
          helpDe: 'Untere Grenze des Slider-Wertebereichs.',
          useCaseDe: 'Startwert der Skala, z. B. 0 oder 1.',
          type: PropertyControlType.slider,
          min: 0,
          max: 50,
          divisions: 50,
          getValue: () => _c.sliderMin,
          setValue: (v) => _c.update(() {
            _c.sliderMin = v;
            if (_c.sliderMax <= _c.sliderMin) {
              _c.sliderMax = _c.sliderMin + 1;
            }
            _c.sliderValue = _c.sliderValue.clamp(_c.sliderMin, _c.sliderMax);
          }),
        ),
        PropertyBinding<double>(
          codeName: 'Slider.max',
          labelDe: 'Slider Max',
          helpDe: 'Obere Grenze des Slider-Wertebereichs.',
          useCaseDe: 'Endwert der Skala, z. B. 100 für Prozent.',
          type: PropertyControlType.slider,
          min: 1,
          max: 100,
          divisions: 99,
          getValue: () => _c.sliderMax,
          setValue: (v) => _c.update(() {
            _c.sliderMax = v;
            if (_c.sliderMax <= _c.sliderMin) {
              _c.sliderMin = _c.sliderMax - 1;
            }
            _c.sliderValue = _c.sliderValue.clamp(_c.sliderMin, _c.sliderMax);
          }),
        ),
        PropertyBinding<double>(
          codeName: 'Slider.value',
          labelDe: 'Slider',
          helpDe: 'Aktueller Wert zwischen min und max.',
          useCaseDe: 'Lautstärke, Preisbereich, Fortschritt oder Intensität.',
          type: PropertyControlType.slider,
          min: 0,
          max: 100,
          divisions: 100,
          getValue: () => _c.sliderValue,
          setValue: (v) => _c.update(
            () => _c.sliderValue = v.clamp(_c.sliderMin, _c.sliderMax),
          ),
        ),
        PropertyBinding<String>(
          codeName: 'DropdownButton.value',
          labelDe: 'Dropdown',
          helpDe: 'Aktuell gewählter Eintrag.',
          useCaseDe: 'Auswahl aus wenigen festen Optionen: Sortierung, Land.',
          type: PropertyControlType.enumeration,
          enumValues: const ['Eins', 'Zwei', 'Drei'],
          enumLabels: const ['Eins', 'Zwei', 'Drei'],
          getValue: () => _c.dropdownValue,
          setValue: (v) => _c.update(() => _c.dropdownValue = v),
        ),
      ],
      previewBuilder: (context) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SwitchListTile(
              title: const Text('Switch'),
              value: _c.switchValue,
              onChanged: (v) => _c.update(() => _c.switchValue = v),
            ),
            CheckboxListTile(
              title: const Text('Checkbox'),
              tristate: _c.checkboxTristate,
              value: _c.checkboxValue,
              onChanged: _c.checkboxTristate
                  ? _toggleCheckbox
                  : (v) => _toggleCheckbox(v),
            ),
            if (_c.checkboxTristate)
              TextButton(
                onPressed: _cycleTristateCheckbox,
                child: const Text('Tristate durchschalten'),
              ),
            Row(
              children: [
                Text(
                  _c.sliderMin.toStringAsFixed(0),
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                Expanded(
                  child: Slider(
                    min: _c.sliderMin,
                    max: _c.sliderMax,
                    value: _c.sliderValue,
                    label: _c.sliderValue.toStringAsFixed(0),
                    onChanged: (v) => _c.update(() => _c.sliderValue = v),
                  ),
                ),
                Text(
                  _c.sliderMax.toStringAsFixed(0),
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ],
            ),
            Text(
              'Wert: ${_c.sliderValue.toStringAsFixed(1)}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 8),
            DropdownButton<String>(
              value: _c.dropdownValue,
              items: const [
                DropdownMenuItem(value: 'Eins', child: Text('Eins')),
                DropdownMenuItem(value: 'Zwei', child: Text('Zwei')),
                DropdownMenuItem(value: 'Drei', child: Text('Drei')),
              ],
              onChanged: (v) {
                if (v != null) _c.update(() => _c.dropdownValue = v);
              },
            ),
          ],
        ),
      ),
    );
  }
}
