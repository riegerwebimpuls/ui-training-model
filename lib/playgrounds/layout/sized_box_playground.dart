import 'package:flutter/material.dart';
import 'package:ui_training_model/catalog/widget_module.dart';
import 'package:ui_training_model/core/playground_shell.dart';
import 'package:ui_training_model/core/property_binding.dart';

class SizedBoxPlayground extends StatefulWidget {
  const SizedBoxPlayground({super.key});

  @override
  State<SizedBoxPlayground> createState() => _SizedBoxPlaygroundState();
}

class _Ctrl extends PlaygroundController {
  bool useNullWidth = false;
  double width = 120;
  double height = 80;
}

class _SizedBoxPlaygroundState extends State<SizedBoxPlayground> {
  final _c = _Ctrl();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PlaygroundShell(
      moduleId: 'sized-box',
      title: 'SizedBox',
      description: 'Feste Größenbox – erzwingt width/height für das Kind.',
      explanationDe:
          'SizedBox setzt feste width und/oder height für sein Kind. '
          'null width lässt das Kind in der Breite schrumpfen (shrink-wrap). '
          'Oft als Abstandshalter: SizedBox(height: 16) ohne Kind.',
      useCaseDe:
          'Feste Thumbnails, Abstände zwischen Widgets, Größe erzwingen.',
      faq: const [
        ModuleFaq(
          question: 'SizedBox vs. Container?',
          answer:
              'SizedBox ist schlank: nur Größe, kein padding/dekor. '
              'Container kann zusätzlich Farbe, margin und decoration.',
        ),
        ModuleFaq(
          question: 'Was passiert bei null width?',
          answer:
              'Das Kind bestimmt die Breite selbst (shrink-wrap). '
              'Nützlich in Rows, wenn nur die Höhe fix sein soll.',
        ),
        ModuleFaq(
          question: 'SizedBox als Abstand?',
          answer:
              'SizedBox(height: 8) oder width: 8 ohne Kind erzeugt '
              'einen unsichtbaren Zwischenraum – leichter als Padding.',
        ),
      ],
      controller: _c,
      bindings: [
        PropertyBinding<bool>(
          codeName: 'useNullWidth',
          labelDe: 'Breite null (shrink)',
          helpDe: 'true = width: null, Kind schrumpft horizontal.',
          useCaseDe: 'In Row/Column nur Höhe fixieren, Breite vom Inhalt.',
          type: PropertyControlType.switcher,
          getValue: () => _c.useNullWidth,
          setValue: (v) => _c.update(() => _c.useNullWidth = v),
        ),
        PropertyBinding<double>(
          codeName: 'width',
          labelDe: 'Breite',
          helpDe: 'SizedBox.width – ignoriert wenn useNullWidth aktiv.',
          useCaseDe: 'Feste Kachelbreite, Thumbnail oder Button-Breite.',
          type: PropertyControlType.slider,
          min: 20,
          max: 280,
          divisions: 52,
          getValue: () => _c.width,
          setValue: (v) => _c.update(() => _c.width = v),
        ),
        PropertyBinding<double>(
          codeName: 'height',
          labelDe: 'Höhe',
          helpDe: 'SizedBox.height in logischen Pixeln.',
          useCaseDe: 'Einheitliche Zeilenhöhe, Banner-Höhe, Abstandshalter.',
          type: PropertyControlType.slider,
          min: 20,
          max: 280,
          divisions: 52,
          getValue: () => _c.height,
          setValue: (v) => _c.update(() => _c.height = v),
        ),
      ],
      previewBuilder: (_) => Center(
        child: ColoredBox(
          color: Colors.black12,
          child: SizedBox(
            width: _c.useNullWidth ? null : _c.width,
            height: _c.height,
            child: ColoredBox(
              color: Colors.teal,
              child: Center(
                child: Text(
                  _c.useNullWidth ? 'shrink' : 'SizedBox',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
