import 'package:flutter/material.dart';
import 'package:ui_training_model/catalog/widget_module.dart';
import 'package:ui_training_model/core/playground_shell.dart';
import 'package:ui_training_model/core/property_binding.dart';

class ContainerPlayground extends StatefulWidget {
  const ContainerPlayground({super.key});

  @override
  State<ContainerPlayground> createState() => _ContainerPlaygroundState();
}

class _Ctrl extends PlaygroundController {
  double width = 160;
  double height = 120;
  double borderRadius = 12;
  double padding = 16;
  double margin = 8;
  Color color = Colors.teal;
  double elevation = 4;
}

Color _contrastOn(Color background) =>
    background.computeLuminance() > 0.5 ? Colors.black87 : Colors.white;

class _ContainerPlaygroundState extends State<ContainerPlayground> {
  final _c = _Ctrl();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PlaygroundShell(
      moduleId: 'container',
      title: 'Container / DecoratedBox',
      description: 'Größe, Farbe, Padding und BorderRadius eines Containers.',
      explanationDe:
          'Container kombiniert Größenbeschränkung, Innenabstand (padding), '
          'Außenabstand (margin) und Dekoration. Hier als Material mit elevation '
          'und abgerundeten Ecken dargestellt.',
      useCaseDe:
          'Karten, Chips, farbige Bereiche und Boxen mit Schatten und abgerundeten Ecken.',
      faq: const [
        ModuleFaq(
          question: 'Container vs. DecoratedBox?',
          answer:
              'Container ist eine Komfort-API: Er bündelt padding, margin, '
              'constraints und decoration. DecoratedBox rendert nur die Dekoration '
              'um ein Kind – ohne padding/margin.',
        ),
        ModuleFaq(
          question: 'Warum Material statt nur BoxDecoration?',
          answer:
              'Material liefert elevation (Schatten) und Theme-Integration. '
              'Alternativ: Container(decoration: BoxDecoration(...)) ohne Schatten.',
        ),
        ModuleFaq(
          question: 'Wie setze ich margin?',
          answer:
              'margin gehört zum Container (EdgeInsets), padding liegt innen. '
              'Margin schiebt die Box vom Nachbarn weg, padding vom Rand zum Inhalt.',
        ),
      ],
      controller: _c,
      bindings: [
        PropertyBinding<double>(
          codeName: 'width',
          labelDe: 'Breite',
          helpDe: 'Feste Breite des Containers in logischen Pixeln.',
          useCaseDe: 'Feste Kartenbreite, Thumbnails oder gleich große Kacheln.',
          type: PropertyControlType.slider,
          min: 40,
          max: 280,
          divisions: 48,
          getValue: () => _c.width,
          setValue: (v) => _c.update(() => _c.width = v),
        ),
        PropertyBinding<double>(
          codeName: 'height',
          labelDe: 'Höhe',
          helpDe: 'Feste Höhe des Containers in logischen Pixeln.',
          useCaseDe: 'Einheitliche Zeilenhöhe, Banner oder quadratische Avatare.',
          type: PropertyControlType.slider,
          min: 40,
          max: 280,
          divisions: 48,
          getValue: () => _c.height,
          setValue: (v) => _c.update(() => _c.height = v),
        ),
        PropertyBinding<double>(
          codeName: 'borderRadius',
          labelDe: 'Eckenradius',
          helpDe: 'BorderRadius.circular(...) der abgerundeten Ecken.',
          useCaseDe: 'Abgerundete Karten, Buttons oder Chips im Material-Look.',
          type: PropertyControlType.slider,
          min: 0,
          max: 64,
          divisions: 64,
          getValue: () => _c.borderRadius,
          setValue: (v) => _c.update(() => _c.borderRadius = v),
        ),
        PropertyBinding<double>(
          codeName: 'padding',
          labelDe: 'Innenabstand',
          helpDe: 'padding um das Kind – Abstand zwischen Rand und Inhalt.',
          useCaseDe: 'Lesbarer Abstand zwischen Rahmen und Text/Icon im Inneren.',
          type: PropertyControlType.slider,
          min: 0,
          max: 48,
          divisions: 48,
          getValue: () => _c.padding,
          setValue: (v) => _c.update(() => _c.padding = v),
        ),
        PropertyBinding<double>(
          codeName: 'margin',
          labelDe: 'Außenabstand',
          helpDe: 'margin um den Container – Abstand zu Nachbar-Widgets.',
          useCaseDe: 'Abstand zwischen Karten in einer Liste oder zum Bildschirmrand.',
          type: PropertyControlType.slider,
          min: 0,
          max: 48,
          divisions: 48,
          getValue: () => _c.margin,
          setValue: (v) => _c.update(() => _c.margin = v),
        ),
        PropertyBinding<double>(
          codeName: 'elevation',
          labelDe: 'Elevation',
          helpDe: 'Schattentiefe des Material-Widgets (0 = flach).',
          useCaseDe: 'Schwebende Karten, FABs oder erhöhte Oberflächen.',
          type: PropertyControlType.slider,
          min: 0,
          max: 24,
          divisions: 24,
          getValue: () => _c.elevation,
          setValue: (v) => _c.update(() => _c.elevation = v),
        ),
        PropertyBinding<Color>(
          codeName: 'color',
          labelDe: 'Farbe',
          helpDe: 'Hintergrundfarbe (Material.color / BoxDecoration.color).',
          useCaseDe: 'Markenfarbe, Status-Hintergrund oder farbige Kategorien.',
          type: PropertyControlType.color,
          getValue: () => _c.color,
          setValue: (v) => _c.update(() => _c.color = v),
        ),
      ],
      previewBuilder: (_) => Center(
        child: Container(
          margin: EdgeInsets.all(_c.margin),
          child: Material(
            elevation: _c.elevation,
            borderRadius: BorderRadius.circular(_c.borderRadius),
            color: _c.color,
            child: Container(
              width: _c.width,
              height: _c.height,
              padding: EdgeInsets.all(_c.padding),
              alignment: Alignment.center,
              child: Text(
                'Kind',
                style: TextStyle(color: _contrastOn(_c.color)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
