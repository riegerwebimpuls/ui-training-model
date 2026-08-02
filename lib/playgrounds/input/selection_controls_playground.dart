import 'package:flutter/material.dart';
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
  bool checkboxValue = false;
  double sliderValue = 0.4;
  String dropdownValue = 'Eins';
}

class _SelectionControlsPlaygroundState
    extends State<SelectionControlsPlayground> {
  final _c = _Ctrl();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PlaygroundShell(
      title: 'Switch / Checkbox / Slider / Dropdown',
      description: 'Auswahl-Controls und ihre Kern-Properties.',
      controller: _c,
      bindings: [
        PropertyBinding<bool>(
          codeName: 'Switch.value',
          labelDe: 'Switch',
          helpDe: 'Aktueller Bool-Wert des Switches.',
          type: PropertyControlType.switcher,
          getValue: () => _c.switchValue,
          setValue: (v) => _c.update(() => _c.switchValue = v),
        ),
        PropertyBinding<bool>(
          codeName: 'Checkbox.value',
          labelDe: 'Checkbox',
          helpDe: 'Aktueller Bool-Wert der Checkbox.',
          type: PropertyControlType.switcher,
          getValue: () => _c.checkboxValue,
          setValue: (v) => _c.update(() => _c.checkboxValue = v),
        ),
        PropertyBinding<double>(
          codeName: 'Slider.value',
          labelDe: 'Slider',
          helpDe: 'Wert zwischen min und max.',
          type: PropertyControlType.slider,
          min: 0,
          max: 1,
          divisions: 20,
          getValue: () => _c.sliderValue,
          setValue: (v) => _c.update(() => _c.sliderValue = v),
        ),
        PropertyBinding<String>(
          codeName: 'DropdownButton.value',
          labelDe: 'Dropdown',
          helpDe: 'Aktuell gewählter Eintrag.',
          type: PropertyControlType.enumeration,
          enumValues: const ['Eins', 'Zwei', 'Drei'],
          enumLabels: const ['Eins', 'Zwei', 'Drei'],
          getValue: () => _c.dropdownValue,
          setValue: (v) => _c.update(() => _c.dropdownValue = v),
        ),
      ],
      previewBuilder: (_) => Padding(
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
              value: _c.checkboxValue,
              onChanged: (v) =>
                  _c.update(() => _c.checkboxValue = v ?? false),
            ),
            Slider(
              value: _c.sliderValue,
              onChanged: (v) => _c.update(() => _c.sliderValue = v),
            ),
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
