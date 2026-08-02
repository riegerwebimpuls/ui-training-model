import 'package:flutter/material.dart';

/// Typ eines steuerbaren Properties im Playground.
enum PropertyControlType { slider, number, switcher, enumeration, color, text }

/// Metadaten + Live-Zugriff auf ein Widget-Property.
class PropertyBinding<T> {
  const PropertyBinding({
    required this.codeName,
    required this.labelDe,
    required this.helpDe,
    required this.useCaseDe,
    required this.type,
    required this.getValue,
    required this.setValue,
    this.min,
    this.max,
    this.divisions,
    this.enumLabels,
    this.enumValues,
  });

  /// Echter Flutter-API-Name, z. B. `borderRadius`.
  final String codeName;

  /// Deutsche Kurzbezeichnung für die UI.
  final String labelDe;

  /// Kurze visuelle Erklärung auf Deutsch.
  final String helpDe;

  /// Typischer / empfohlener Einsatzzweck.
  final String useCaseDe;

  final PropertyControlType type;
  final T Function() getValue;
  final void Function(T value) setValue;

  final double? min;
  final double? max;
  final int? divisions;

  /// Anzeige-Labels für Enums (gleicher Index wie [enumValues]).
  final List<String>? enumLabels;
  final List<T>? enumValues;
}

/// Basis-Controller: [notifyListeners] nach jeder Property-Änderung.
abstract class PlaygroundController extends ChangeNotifier {
  void update(VoidCallback mutate) {
    mutate();
    notifyListeners();
  }
}
