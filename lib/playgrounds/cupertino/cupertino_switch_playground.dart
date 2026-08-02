import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
      controller: _c,
      bindings: [
        PropertyBinding<bool>(
          codeName: 'value',
          labelDe: 'Wert',
          helpDe: 'CupertinoSwitch.value',
          type: PropertyControlType.switcher,
          getValue: () => _c.value,
          setValue: (v) => _c.update(() => _c.value = v),
        ),
        PropertyBinding<Color>(
          codeName: 'activeTrackColor',
          labelDe: 'Aktive Farbe',
          helpDe: 'Farbe im eingeschalteten Zustand.',
          type: PropertyControlType.color,
          getValue: () => _c.activeColor,
          setValue: (v) => _c.update(() => _c.activeColor = v),
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
              onChanged: (v) => _c.update(() => _c.value = v),
            ),
          ],
        ),
      ),
    );
  }
}
