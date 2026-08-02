import 'package:flutter/cupertino.dart';
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
      controller: _c,
      bindings: [
        PropertyBinding<String>(
          codeName: 'child',
          labelDe: 'Label',
          helpDe: 'Kind-Text des Buttons.',
          type: PropertyControlType.text,
          getValue: () => _c.label,
          setValue: (v) => _c.update(() => _c.label = v),
        ),
        PropertyBinding<bool>(
          codeName: 'CupertinoButton.filled',
          labelDe: 'Filled',
          helpDe: 'CupertinoButton.filled vs. plain.',
          type: PropertyControlType.switcher,
          getValue: () => _c.filled,
          setValue: (v) => _c.update(() => _c.filled = v),
        ),
        PropertyBinding<bool>(
          codeName: 'onPressed',
          labelDe: 'Aktiviert',
          helpDe: 'null onPressed deaktiviert.',
          type: PropertyControlType.switcher,
          getValue: () => _c.enabled,
          setValue: (v) => _c.update(() => _c.enabled = v),
        ),
        PropertyBinding<double>(
          codeName: 'pressedOpacity',
          labelDe: 'Pressed Opacity',
          helpDe: 'Deckkraft beim Drücken.',
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
          helpDe: 'CupertinoButton.borderRadius',
          type: PropertyControlType.slider,
          min: 0,
          max: 24,
          divisions: 24,
          getValue: () => _c.borderRadius,
          setValue: (v) => _c.update(() => _c.borderRadius = v),
        ),
      ],
      previewBuilder: (_) {
        final onPressed =
            _c.enabled ? () => _c.update(() => _c.taps++) : null;
        final child = Text(_c.label);
        final button = _c.filled
            ? CupertinoButton.filled(
                onPressed: onPressed,
                pressedOpacity: _c.pressedOpacity,
                borderRadius: BorderRadius.circular(_c.borderRadius),
                child: child,
              )
            : CupertinoButton(
                onPressed: onPressed,
                pressedOpacity: _c.pressedOpacity,
                borderRadius: BorderRadius.circular(_c.borderRadius),
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
