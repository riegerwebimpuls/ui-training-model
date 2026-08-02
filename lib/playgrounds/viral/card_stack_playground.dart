import 'package:flutter/material.dart';
import 'package:ui_training_model/catalog/widget_module.dart';
import 'package:ui_training_model/core/playground_shell.dart';
import 'package:ui_training_model/core/property_binding.dart';
import 'package:ui_training_model/widgets/card_stack_demo.dart';

class CardStackPlayground extends StatefulWidget {
  const CardStackPlayground({super.key});

  @override
  State<CardStackPlayground> createState() => _CardStackPlaygroundState();
}

class _CardStackController extends PlaygroundController {
  double borderRadius = 16;
  double positionFactor = 1.5;
  double scaleFactor = 0.92;
  bool reverseOrder = false;
  bool opacityOnDrag = false;
  CardDismissOrientation dismissOrientation = CardDismissOrientation.up;
  CardSwipeOrientation swipeOrientation = CardSwipeOrientation.vertical;
}

class _CardStackPlaygroundState extends State<CardStackPlayground> {
  final _c = _CardStackController();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PlaygroundShell(
      title: 'Card-Stack Swiper',
      description:
          'Gestapeltes Karten-Carousel mit Swipe zum Wegwischen. '
          'Steuert Radius, Versatz, Skalierung und Swipe-Richtung.',
      moduleId: 'card-stack',
      explanationDe:
          'Mehrere Karten liegen übereinander; die vorderste lässt sich per Geste '
          'wegwischen. Hintere Karten sind versetzt und leicht verkleinert – '
          'das Muster kennt man von Dating-Apps und Entdecken-Feeds.',
      useCaseDe:
          'Tinder-ähnliche Swipe-Karten, Produkt-Stapel oder kuratierte '
          'Entscheidungs-UI mit klarer Frontkarte.',
      faq: const [
        ModuleFaq(
          question: 'Was bedeutet scaleFactor?',
          answer:
              'Jede Karte hinter der Front wird um (1 − scaleFactor) pro Schicht '
              'kleiner skaliert. Maximal 1,0 bedeutet: keine Verkleinerung.',
        ),
        ModuleFaq(
          question: 'Wann reverseOrder nutzen?',
          answer:
              'reverseOrder kehrt die visuelle Stapelreihenfolge um – nützlich, '
              'wenn die „oberste“ Karte logisch hinten in der Liste steht.',
        ),
      ],
      controller: _c,
      previewHint: 'Vordere Karte wischen zum Rotieren',
      bindings: [
        PropertyBinding<double>(
          codeName: 'borderRadius',
          labelDe: 'Radius Karte',
          helpDe: 'Eckenradius jeder Karte in logischen Pixeln.',
          useCaseDe:
              '16–24 px für moderne, abgerundete Karten; 0 für harte Kanten.',
          type: PropertyControlType.number,
          getValue: () => _c.borderRadius,
          setValue: (v) => _c.update(() => _c.borderRadius = v),
        ),
        PropertyBinding<double>(
          codeName: 'positionFactor',
          labelDe: 'Positionsfaktor',
          helpDe: 'Vertikaler Versatz der hinteren Karten relativ zur Front.',
          useCaseDe:
              'Höhere Werte = stärkerer Stapel-Effekt; ~1,5 ist ein guter Start.',
          type: PropertyControlType.number,
          getValue: () => _c.positionFactor,
          setValue: (v) => _c.update(() => _c.positionFactor = v),
        ),
        PropertyBinding<double>(
          codeName: 'scaleFactor',
          labelDe: 'Skalierungsfaktor',
          helpDe:
              'Multiplikator pro Schicht: hintere Karten werden kleiner '
              '(max. 1,0 = keine Verkleinerung).',
          useCaseDe:
              'Typisch ~0,92: leichte Verkleinerung pro Ebene für Tiefeneffekt.',
          type: PropertyControlType.slider,
          min: 0.7,
          max: 1.0,
          divisions: 30,
          getValue: () => _c.scaleFactor,
          setValue: (v) => _c.update(() => _c.scaleFactor = v),
        ),
        PropertyBinding<bool>(
          codeName: 'reverseOrder',
          labelDe: 'Reihenfolge umkehren',
          helpDe: 'Kehrt die visuelle Stapelreihenfolge um.',
          useCaseDe:
              'Wenn die zuletzt hinzugefügte Karte unten statt oben liegen soll.',
          type: PropertyControlType.switcher,
          getValue: () => _c.reverseOrder,
          setValue: (v) => _c.update(() => _c.reverseOrder = v),
        ),
        PropertyBinding<bool>(
          codeName: 'opacityOnDrag',
          labelDe: 'Deckkraft beim Ziehen',
          helpDe: 'Senkt die Opacity der Frontkarte während des Drags.',
          useCaseDe:
              'Visuelles Feedback beim Wegwischen – die Karte „verblasst“ leicht.',
          type: PropertyControlType.switcher,
          getValue: () => _c.opacityOnDrag,
          setValue: (v) => _c.update(() => _c.opacityOnDrag = v),
        ),
        PropertyBinding<CardDismissOrientation>(
          codeName: 'dismissOrientation',
          labelDe: 'Dismiss-Richtung',
          helpDe: 'Richtung, in die gewischt werden muss zum Entfernen.',
          useCaseDe:
              'up für Tinder-Swipe nach oben; horizontal für Links/Rechts-Entscheidungen.',
          type: PropertyControlType.enumeration,
          enumValues: CardDismissOrientation.values,
          enumLabels: const ['up', 'down', 'left', 'right'],
          getValue: () => _c.dismissOrientation,
          setValue: (v) => _c.update(() => _c.dismissOrientation = v),
        ),
        PropertyBinding<CardSwipeOrientation>(
          codeName: 'swipeOrientation',
          labelDe: 'Swipe-Ausrichtung',
          helpDe: 'Erlaubte Drag-Achse: vertikal, horizontal oder frei.',
          useCaseDe:
              'vertical für klassische Stack-Swipes; free für diagonale Gesten.',
          type: PropertyControlType.enumeration,
          enumValues: CardSwipeOrientation.values,
          enumLabels: const ['vertical', 'horizontal', 'free'],
          getValue: () => _c.swipeOrientation,
          setValue: (v) => _c.update(() => _c.swipeOrientation = v),
        ),
      ],
      previewBuilder: (_) => ColoredBox(
        color: const Color(0xFF2A2A2A),
        child: CardStackDemo(
          borderRadius: _c.borderRadius,
          positionFactor: _c.positionFactor,
          scaleFactor: _c.scaleFactor,
          reverseOrder: _c.reverseOrder,
          opacityOnDrag: _c.opacityOnDrag,
          dismissOrientation: _c.dismissOrientation,
          swipeOrientation: _c.swipeOrientation,
        ),
      ),
    );
  }
}
