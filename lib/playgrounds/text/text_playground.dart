import 'package:flutter/material.dart';
import 'package:ui_training_model/catalog/widget_module.dart';
import 'package:ui_training_model/core/playground_shell.dart';
import 'package:ui_training_model/core/property_binding.dart';

class TextPlayground extends StatefulWidget {
  const TextPlayground({super.key});

  @override
  State<TextPlayground> createState() => _TextPlaygroundState();
}

class _Ctrl extends PlaygroundController {
  String data =
      'Langer Beispieltext zum Testen von maxLines und overflow in der Vorschau.';
  double fontSize = 24;
  FontWeight fontWeight = FontWeight.w400;
  Color color = Colors.teal;
  TextAlign textAlign = TextAlign.center;
  double letterSpacing = 0;
  int maxLines = 2;
  TextOverflow overflow = TextOverflow.ellipsis;
}

class _TextPlaygroundState extends State<TextPlayground> {
  final _c = _Ctrl();

  static const _faq = [
    ModuleFaq(
      question: 'Was ist der Unterschied zwischen Text und TextStyle?',
      answer:
          'Text ist das Widget; TextStyle beschreibt Schriftgröße, Farbe, Gewicht und Abstände. Du übergibst style: TextStyle(...).',
    ),
    ModuleFaq(
      question: 'Wann brauche ich maxLines und overflow?',
      answer:
          'Bei begrenztem Platz: maxLines schneidet vertikal ab, overflow steuert das Verhalten am Rand (ellipsis, fade, clip).',
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
      title: 'Text / TextStyle',
      description: 'Typografie-Properties von Text und TextStyle.',
      moduleId: 'text',
      explanationDe:
          'Das Text-Widget rendert Strings mit TextStyle. Hier siehst du live, wie Größe, Gewicht, Farbe, Ausrichtung, Zeichenabstand, maxLines und overflow zusammenwirken.',
      useCaseDe:
          'Überschriften, Fließtext, Beschriftungen und jedes sichtbare Label in der UI.',
      faq: _faq,
      controller: _c,
      bindings: [
        PropertyBinding<String>(
          codeName: 'data',
          labelDe: 'Text',
          helpDe: 'Angezeigter String-Inhalt.',
          useCaseDe: 'Titel, Beschreibung oder dynamischer Inhalt aus dem State.',
          type: PropertyControlType.text,
          getValue: () => _c.data,
          setValue: (v) => _c.update(() => _c.data = v),
        ),
        PropertyBinding<double>(
          codeName: 'fontSize',
          labelDe: 'Schriftgröße',
          helpDe: 'TextStyle.fontSize in logischen Pixeln.',
          useCaseDe: 'Hierarchie: größer für Headlines, kleiner für Captions.',
          type: PropertyControlType.slider,
          min: 10,
          max: 48,
          divisions: 38,
          getValue: () => _c.fontSize,
          setValue: (v) => _c.update(() => _c.fontSize = v),
        ),
        PropertyBinding<FontWeight>(
          codeName: 'fontWeight',
          labelDe: 'Schriftstärke',
          helpDe: 'TextStyle.fontWeight (w300–w800).',
          useCaseDe: 'Betont w600/w800 für Titel, w400 für Fließtext.',
          type: PropertyControlType.enumeration,
          enumValues: const [
            FontWeight.w300,
            FontWeight.w400,
            FontWeight.w600,
            FontWeight.w800,
          ],
          enumLabels: const ['w300', 'w400', 'w600', 'w800'],
          getValue: () => _c.fontWeight,
          setValue: (v) => _c.update(() => _c.fontWeight = v),
        ),
        PropertyBinding<double>(
          codeName: 'letterSpacing',
          labelDe: 'Zeichenabstand',
          helpDe: 'TextStyle.letterSpacing – Abstand zwischen Glyphen.',
          useCaseDe: 'Feintuning bei Caps, Buttons oder kompakten Labels.',
          type: PropertyControlType.slider,
          min: -2,
          max: 8,
          divisions: 20,
          getValue: () => _c.letterSpacing,
          setValue: (v) => _c.update(() => _c.letterSpacing = v),
        ),
        PropertyBinding<TextAlign>(
          codeName: 'textAlign',
          labelDe: 'Ausrichtung',
          helpDe: 'Text.textAlign innerhalb der verfügbaren Breite.',
          useCaseDe: 'center für Hero-Text, left/right für Formulare und Listen.',
          type: PropertyControlType.enumeration,
          enumValues: const [
            TextAlign.left,
            TextAlign.center,
            TextAlign.right,
            TextAlign.justify,
          ],
          enumLabels: const ['left', 'center', 'right', 'justify'],
          getValue: () => _c.textAlign,
          setValue: (v) => _c.update(() => _c.textAlign = v),
        ),
        PropertyBinding<double>(
          codeName: 'maxLines',
          labelDe: 'Max. Zeilen',
          helpDe: 'Text.maxLines begrenzt die sichtbare Zeilenzahl.',
          useCaseDe: 'Karten, Listentitel und Snippets mit fester Höhe.',
          type: PropertyControlType.slider,
          min: 1,
          max: 10,
          divisions: 9,
          getValue: () => _c.maxLines.toDouble(),
          setValue: (v) => _c.update(() => _c.maxLines = v.round()),
        ),
        PropertyBinding<TextOverflow>(
          codeName: 'overflow',
          labelDe: 'Overflow',
          helpDe: 'Text.overflow bei Platzmangel (nach maxLines).',
          useCaseDe: 'ellipsis für einzeilige Titel, fade für dezente Abschnitte.',
          type: PropertyControlType.enumeration,
          enumValues: TextOverflow.values,
          enumLabels: const ['clip', 'fade', 'ellipsis', 'visible'],
          getValue: () => _c.overflow,
          setValue: (v) => _c.update(() => _c.overflow = v),
        ),
        PropertyBinding<Color>(
          codeName: 'color',
          labelDe: 'Farbe',
          helpDe: 'TextStyle.color der Schrift.',
          useCaseDe: 'Primärtext, deaktiviert (onSurfaceVariant) oder Akzentfarbe.',
          type: PropertyControlType.color,
          getValue: () => _c.color,
          setValue: (v) => _c.update(() => _c.color = v),
        ),
      ],
      previewBuilder: (_) => Padding(
        padding: const EdgeInsets.all(24),
        child: Text(
          _c.data,
          textAlign: _c.textAlign,
          maxLines: _c.maxLines,
          overflow: _c.overflow,
          style: TextStyle(
            fontSize: _c.fontSize,
            fontWeight: _c.fontWeight,
            color: _c.color,
            letterSpacing: _c.letterSpacing,
          ),
        ),
      ),
    );
  }
}
