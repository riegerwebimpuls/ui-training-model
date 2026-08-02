import 'package:flutter/material.dart';
import 'package:ui_training_model/catalog/widget_module.dart';
import 'package:ui_training_model/core/playground_shell.dart';
import 'package:ui_training_model/core/property_binding.dart';

/// Icons mit Variable-Font-Unterstützung für [Icon.fill] und [Icon.weight].
/// Nicht alle Material Icons reagieren auf fill – hier nur solche mit FILL-Achse.
class _VariableIcon {
  const _VariableIcon(this.data, this.labelDe);

  final IconData data;
  final String labelDe;
}

class IconPlayground extends StatefulWidget {
  const IconPlayground({super.key});

  @override
  State<IconPlayground> createState() => _IconPlaygroundState();
}

class _Ctrl extends PlaygroundController {
  double size = 48;
  Color color = Colors.teal;
  double fill = 0;
  double opticalSize = 24;
  int iconIndex = 0;
}

class _IconPlaygroundState extends State<IconPlayground> {
  final _c = _Ctrl();

  static const _icons = [
    _VariableIcon(Icons.favorite, 'favorite'),
    _VariableIcon(Icons.grade, 'grade'),
    _VariableIcon(Icons.bookmark, 'bookmark'),
    _VariableIcon(Icons.thumb_up, 'thumb_up'),
    _VariableIcon(Icons.home, 'home'),
  ];

  static const _faq = [
    ModuleFaq(
      question: 'Warum ändert sich fill bei manchen Icons nicht?',
      answer:
          'fill und opticalSize wirken nur bei Material Symbols mit Variable-Font-Achsen (z. B. favorite, grade). Einfache Icons ignorieren fill.',
    ),
    ModuleFaq(
      question: 'Was ist der Unterschied zwischen size und opticalSize?',
      answer:
          'size skaliert die Render-Größe. opticalSize steuert die optische Strichstärke der Variable Font – sinnvoll bei kleinen Icons in dichten UIs.',
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
      title: 'Icon',
      description: 'Material Icons mit size, color, fill und opticalSize.',
      moduleId: 'icon',
      explanationDe:
          'Icons sind vektorbasierte Glyphen. Variable Material Symbols unterstützen fill (0–1) und opticalSize für feinere Kontrolle. Die Auswahl enthält nur Icons mit FILL-Achse.',
      useCaseDe:
          'Navigation, Buttons, Statusanzeigen und dekorative Akzente in Toolbars und Listen.',
      faq: _faq,
      previewHint: 'Nur Variable-Font-Icons reagieren auf fill',
      controller: _c,
      bindings: [
        PropertyBinding<double>(
          codeName: 'icon',
          labelDe: 'Icon-Auswahl',
          helpDe: 'IconData – nur Symbole mit Variable-Font-FILL.',
          useCaseDe: 'Passendes Metapher-Icon für Aktion oder Kategorie wählen.',
          type: PropertyControlType.enumeration,
          enumValues: List.generate(_icons.length, (i) => i.toDouble()),
          enumLabels: _icons.map((e) => e.labelDe).toList(),
          getValue: () => _c.iconIndex.toDouble(),
          setValue: (v) => _c.update(() => _c.iconIndex = v.round()),
        ),
        PropertyBinding<double>(
          codeName: 'size',
          labelDe: 'Größe',
          helpDe: 'Icon.size in logischen Pixeln.',
          useCaseDe: '24 px Standard, 18 px kompakt, 32+ px für Hero-Bereiche.',
          type: PropertyControlType.slider,
          min: 16,
          max: 96,
          divisions: 40,
          getValue: () => _c.size,
          setValue: (v) => _c.update(() => _c.size = v),
        ),
        PropertyBinding<double>(
          codeName: 'fill',
          labelDe: 'Fill',
          helpDe: 'Icon.fill (0–1) – Füllgrad bei Variable Fonts.',
          useCaseDe: 'Aktiver vs. inaktiver Zustand (z. B. favorisiert = fill 1).',
          type: PropertyControlType.slider,
          min: 0,
          max: 1,
          divisions: 10,
          getValue: () => _c.fill,
          setValue: (v) => _c.update(() => _c.fill = v),
        ),
        PropertyBinding<double>(
          codeName: 'opticalSize',
          labelDe: 'Optische Größe',
          helpDe: 'Icon.opticalSize – Strichstärke der Variable Font.',
          useCaseDe: 'Feinabstimmung in AppBars und dichten Icon-Reihen.',
          type: PropertyControlType.slider,
          min: 20,
          max: 48,
          divisions: 28,
          getValue: () => _c.opticalSize,
          setValue: (v) => _c.update(() => _c.opticalSize = v),
        ),
        PropertyBinding<Color>(
          codeName: 'color',
          labelDe: 'Farbe',
          helpDe: 'Icon.color der Glyphe.',
          useCaseDe: 'Theme.onSurface, primary für Aktionen, error für Warnungen.',
          type: PropertyControlType.color,
          getValue: () => _c.color,
          setValue: (v) => _c.update(() => _c.color = v),
        ),
      ],
      previewBuilder: (context) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              _icons[_c.iconIndex].data,
              size: _c.size,
              color: _c.color,
              fill: _c.fill,
              opticalSize: _c.opticalSize,
            ),
            const SizedBox(height: 12),
            Text(
              '${_icons[_c.iconIndex].labelDe} · fill ${_c.fill.toStringAsFixed(1)}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
