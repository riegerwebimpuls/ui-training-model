import 'package:flutter/material.dart';
import 'package:ui_training_model/catalog/widget_module.dart';
import 'package:ui_training_model/core/playground_shell.dart';
import 'package:ui_training_model/core/property_binding.dart';

class StackPlayground extends StatefulWidget {
  const StackPlayground({super.key});

  @override
  State<StackPlayground> createState() => _StackPlaygroundState();
}

class _Ctrl extends PlaygroundController {
  double top = 40;
  double left = 40;
  AlignmentGeometry alignment = Alignment.center;
  StackFit fit = StackFit.loose;
  Clip clipBehavior = Clip.hardEdge;
}

class _StackPlaygroundState extends State<StackPlayground> {
  final _c = _Ctrl();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PlaygroundShell(
      moduleId: 'stack',
      title: 'Stack / Positioned',
      description: 'Überlagerte Widgets mit Alignment und Positioned.',
      explanationDe:
          'Stack legt Kinder übereinander. Positioned platziert ein Kind '
          'absolut mit top/left/right/bottom. alignment richtet nicht-positionierte '
          'Kinder aus. fit steuert, wie groß der Stack wird.',
      useCaseDe:
          'Badges auf Avataren, Overlays, Karten mit schwebendem Button.',
      faq: const [
        ModuleFaq(
          question: 'Positioned vs. alignment?',
          answer:
              'Positioned: feste Abstände vom Rand (top, left, …). '
              'alignment: Standard für Kinder ohne Positioned – z. B. zentriert.',
        ),
        ModuleFaq(
          question: 'Was bedeutet StackFit?',
          answer:
              'loose: Stack so groß wie das größte Kind. expand: füllt den Eltern. '
              'passthrough: Größe vom Eltern-Constraints durchreichen.',
        ),
        ModuleFaq(
          question: 'Wann clipBehavior setzen?',
          answer:
              'hardEdge oder antiAlias schneiden überstehende Kinder ab. '
              'none lässt Inhalte über den Stack-Rand hinausragen.',
        ),
      ],
      controller: _c,
      bindings: [
        PropertyBinding<double>(
          codeName: 'Positioned.top',
          labelDe: 'Top',
          helpDe: 'Abstand des Positioned-Kinds vom oberen Stack-Rand.',
          useCaseDe: 'Badge oben rechts auf Avatar, schwebendes Label.',
          type: PropertyControlType.slider,
          min: 0,
          max: 200,
          divisions: 40,
          getValue: () => _c.top,
          setValue: (v) => _c.update(() => _c.top = v),
        ),
        PropertyBinding<double>(
          codeName: 'Positioned.left',
          labelDe: 'Left',
          helpDe: 'Abstand des Positioned-Kinds vom linken Stack-Rand.',
          useCaseDe: 'Overlay-Element von links einrücken, Tooltip-Pfeil.',
          type: PropertyControlType.slider,
          min: 0,
          max: 200,
          divisions: 40,
          getValue: () => _c.left,
          setValue: (v) => _c.update(() => _c.left = v),
        ),
        PropertyBinding<Alignment>(
          codeName: 'alignment',
          labelDe: 'Alignment',
          helpDe: 'Standard-Ausrichtung für Kinder ohne Positioned.',
          useCaseDe: 'Zentriertes Logo über Hintergrundbild.',
          type: PropertyControlType.enumeration,
          enumValues: const [
            Alignment.topLeft,
            Alignment.topCenter,
            Alignment.center,
            Alignment.bottomRight,
          ],
          enumLabels: const ['topLeft', 'topCenter', 'center', 'bottomRight'],
          getValue: () => _c.alignment as Alignment,
          setValue: (v) => _c.update(() => _c.alignment = v),
        ),
        PropertyBinding<StackFit>(
          codeName: 'fit',
          labelDe: 'StackFit',
          helpDe: 'Wie der Stack seine Größe aus den Kindern ableitet.',
          useCaseDe: 'Volle Fläche füllen (expand) vs. kompaktes Overlay (loose).',
          type: PropertyControlType.enumeration,
          enumValues: StackFit.values,
          enumLabels: const ['loose', 'expand', 'passthrough'],
          getValue: () => _c.fit,
          setValue: (v) => _c.update(() => _c.fit = v),
        ),
        PropertyBinding<Clip>(
          codeName: 'clipBehavior',
          labelDe: 'Clip',
          helpDe: 'Ob überstehende Kinder am Stack-Rand abgeschnitten werden.',
          useCaseDe: 'Runde Avatare mit Badge, das nicht überstehen soll.',
          type: PropertyControlType.enumeration,
          enumValues: const [Clip.none, Clip.hardEdge, Clip.antiAlias],
          enumLabels: const ['none', 'hardEdge', 'antiAlias'],
          getValue: () => _c.clipBehavior,
          setValue: (v) => _c.update(() => _c.clipBehavior = v),
        ),
      ],
      previewBuilder: (_) => Padding(
        padding: const EdgeInsets.all(24),
        child: SizedBox(
          width: 220,
          height: 220,
          child: ColoredBox(
            color: Colors.blueGrey.shade100,
            child: Stack(
              fit: _c.fit,
              alignment: _c.alignment,
              clipBehavior: _c.clipBehavior,
              children: [
                Container(width: 180, height: 180, color: Colors.teal.shade200),
                Positioned(
                  top: _c.top,
                  left: _c.left,
                  child: Container(
                    width: 72,
                    height: 72,
                    color: Colors.orange,
                    alignment: Alignment.center,
                    child: const Text('Pos'),
                  ),
                ),
                Container(
                  width: 48,
                  height: 48,
                  decoration: const BoxDecoration(
                    color: Colors.indigo,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
