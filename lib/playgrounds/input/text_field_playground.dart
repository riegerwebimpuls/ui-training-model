import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ui_training_model/catalog/widget_module.dart';
import 'package:ui_training_model/core/playground_shell.dart';
import 'package:ui_training_model/core/property_binding.dart';

enum PlaygroundKeyboardType { text, email, number }

class TextFieldPlayground extends StatefulWidget {
  const TextFieldPlayground({super.key});

  @override
  State<TextFieldPlayground> createState() => _TextFieldPlaygroundState();
}

class _Ctrl extends PlaygroundController {
  String labelText = 'E-Mail';
  String hintText = 'name@example.com';
  String helperText = 'Wir senden keinen Spam.';
  String errorText = '';
  bool obscureText = false;
  bool enabled = true;
  bool prefixIcon = false;
  bool filled = false;
  int maxLines = 1;
  PlaygroundKeyboardType keyboardType = PlaygroundKeyboardType.email;
}

class _TextFieldPlaygroundState extends State<TextFieldPlayground> {
  final _c = _Ctrl();

  static const _faq = [
    ModuleFaq(
      question: 'Was macht InputDecoration.filled?',
      answer:
          'filled: true füllt den Eingabebereich mit fillColor – typisch für kompakte Formulare und Suchfelder in M3.',
    ),
    ModuleFaq(
      question: 'Wie zeige ich einen Validierungsfehler?',
      answer:
          'Setze errorText in InputDecoration. Das Feld erhält rote Umrandung und den Fehlertext darunter – oft aus Form-Validierung.',
    ),
  ];

  TextInputType _keyboardType(PlaygroundKeyboardType type) => switch (type) {
        PlaygroundKeyboardType.text => TextInputType.text,
        PlaygroundKeyboardType.email => TextInputType.emailAddress,
        PlaygroundKeyboardType.number => TextInputType.number,
      };

  List<TextInputFormatter>? _inputFormatters(PlaygroundKeyboardType type) =>
      type == PlaygroundKeyboardType.number
          ? [FilteringTextInputFormatter.digitsOnly]
          : null;

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PlaygroundShell(
      title: 'TextField / InputDecoration',
      description: 'Eingabefeld mit Label, Hint, Helper, Fehler und Keyboard.',
      moduleId: 'text-field',
      explanationDe:
          'TextField kombiniert Eingabelogik mit InputDecoration für Label, Hinweise, Icons und Fehlerzustände. keyboardType steuert die Tastatur.',
      useCaseDe:
          'Formulare, Login, Suche und jede Benutzereingabe in der App.',
      faq: _faq,
      controller: _c,
      bindings: [
        PropertyBinding<String>(
          codeName: 'labelText',
          labelDe: 'Label',
          helpDe: 'InputDecoration.labelText – schwebendes Feldlabel.',
          useCaseDe: 'Feldbezeichnung: „E-Mail“, „Passwort“, „Name“.',
          type: PropertyControlType.text,
          getValue: () => _c.labelText,
          setValue: (v) => _c.update(() => _c.labelText = v),
        ),
        PropertyBinding<String>(
          codeName: 'hintText',
          labelDe: 'Hinweis',
          helpDe: 'InputDecoration.hintText im leeren Feld.',
          useCaseDe: 'Beispielwert oder Format-Hinweis vor der Eingabe.',
          type: PropertyControlType.text,
          getValue: () => _c.hintText,
          setValue: (v) => _c.update(() => _c.hintText = v),
        ),
        PropertyBinding<String>(
          codeName: 'helperText',
          labelDe: 'Hilfetext',
          helpDe: 'InputDecoration.helperText unter dem Feld.',
          useCaseDe: 'Kontext oder Regeln: Zeichenlimit, Datenschutz-Hinweis.',
          type: PropertyControlType.text,
          getValue: () => _c.helperText,
          setValue: (v) => _c.update(() => _c.helperText = v),
        ),
        PropertyBinding<String>(
          codeName: 'errorText',
          labelDe: 'Fehlertext',
          helpDe: 'InputDecoration.errorText – leer = kein Fehler.',
          useCaseDe: 'Validierung: „Ungültige E-Mail“, „Pflichtfeld“.',
          type: PropertyControlType.text,
          getValue: () => _c.errorText,
          setValue: (v) => _c.update(() => _c.errorText = v),
        ),
        PropertyBinding<bool>(
          codeName: 'prefixIcon',
          labelDe: 'Prefix-Icon',
          helpDe: 'InputDecoration.prefixIcon links im Feld.',
          useCaseDe: 'Suche (Lupe), E-Mail (Brief) oder Kategorie-Icon.',
          type: PropertyControlType.switcher,
          getValue: () => _c.prefixIcon,
          setValue: (v) => _c.update(() => _c.prefixIcon = v),
        ),
        PropertyBinding<bool>(
          codeName: 'filled',
          labelDe: 'Gefüllt',
          helpDe: 'InputDecoration.filled mit Hintergrundfarbe.',
          useCaseDe: 'Kompakte Formulare und Suchleisten im Material-3-Stil.',
          type: PropertyControlType.switcher,
          getValue: () => _c.filled,
          setValue: (v) => _c.update(() => _c.filled = v),
        ),
        PropertyBinding<PlaygroundKeyboardType>(
          codeName: 'keyboardType',
          labelDe: 'Tastatur',
          helpDe: 'TextField.keyboardType für die Systemtastatur.',
          useCaseDe: 'email für Adressen, number für PIN/Menge, text für Freitext.',
          type: PropertyControlType.enumeration,
          enumValues: PlaygroundKeyboardType.values,
          enumLabels: const ['text', 'email', 'number'],
          getValue: () => _c.keyboardType,
          setValue: (v) => _c.update(() => _c.keyboardType = v),
        ),
        PropertyBinding<bool>(
          codeName: 'obscureText',
          labelDe: 'Passwortmodus',
          helpDe: 'TextField.obscureText maskiert die Eingabe.',
          useCaseDe: 'Passwörter und sensible PIN-Eingaben.',
          type: PropertyControlType.switcher,
          getValue: () => _c.obscureText,
          setValue: (v) => _c.update(() => _c.obscureText = v),
        ),
        PropertyBinding<bool>(
          codeName: 'enabled',
          labelDe: 'Aktiviert',
          helpDe: 'TextField.enabled – false macht das Feld read-only.',
          useCaseDe: 'Felder sperren während Submit oder bei fehlender Berechtigung.',
          type: PropertyControlType.switcher,
          getValue: () => _c.enabled,
          setValue: (v) => _c.update(() => _c.enabled = v),
        ),
        PropertyBinding<double>(
          codeName: 'maxLines',
          labelDe: 'Max. Zeilen',
          helpDe: 'TextField.maxLines (bei obscure immer 1).',
          useCaseDe: 'Mehrzeilige Notizen und Kommentarfelder.',
          type: PropertyControlType.slider,
          min: 1,
          max: 5,
          divisions: 4,
          getValue: () => _c.maxLines.toDouble(),
          setValue: (v) => _c.update(() => _c.maxLines = v.round()),
        ),
      ],
      previewBuilder: (previewContext) => Padding(
        padding: const EdgeInsets.all(24),
        child: TextField(
          enabled: _c.enabled,
          obscureText: _c.obscureText,
          maxLines: _c.obscureText ? 1 : _c.maxLines,
          keyboardType: _keyboardType(_c.keyboardType),
          inputFormatters: _inputFormatters(_c.keyboardType),
          decoration: InputDecoration(
            labelText: _c.labelText,
            hintText: _c.hintText,
            helperText: _c.helperText,
            errorText: _c.errorText.isEmpty ? null : _c.errorText,
            filled: _c.filled,
            prefixIcon: _c.prefixIcon ? const Icon(Icons.search) : null,
            border: const OutlineInputBorder(),
          ),
        ),
      ),
    );
  }
}
