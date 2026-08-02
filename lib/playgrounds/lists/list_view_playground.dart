import 'package:flutter/material.dart';
import 'package:ui_training_model/catalog/widget_module.dart';
import 'package:ui_training_model/core/playground_shell.dart';
import 'package:ui_training_model/core/property_binding.dart';

enum PlaygroundScrollPhysics { clamping, bouncing }

class ListViewPlayground extends StatefulWidget {
  const ListViewPlayground({super.key});

  @override
  State<ListViewPlayground> createState() => _ListViewPlaygroundState();
}

class _Ctrl extends PlaygroundController {
  double itemExtent = 56;
  bool reverse = false;
  Axis scrollDirection = Axis.vertical;
  int itemCount = 20;
  double padding = 0;
  PlaygroundScrollPhysics physics = PlaygroundScrollPhysics.clamping;
}

class _ListViewPlaygroundState extends State<ListViewPlayground> {
  final _c = _Ctrl();

  static const _faq = [
    ModuleFaq(
      question: 'Clamping vs. Bouncing ScrollPhysics?',
      answer:
          'ClampingScrollPhysics stoppt am Rand (Android-Stil). BouncingScrollPhysics federt über (iOS-Stil). Wähle passend zur Plattform oder App-Design.',
    ),
    ModuleFaq(
      question: 'Wofür ist itemExtent?',
      answer:
          'itemExtent gibt jeder Zeile eine feste Höhe/Breite – ListView kann effizienter layouten, wenn alle Items gleich groß sind.',
    ),
  ];

  ScrollPhysics _physics(PlaygroundScrollPhysics type) => switch (type) {
        PlaygroundScrollPhysics.clamping => const ClampingScrollPhysics(),
        PlaygroundScrollPhysics.bouncing => const BouncingScrollPhysics(),
      };

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PlaygroundShell(
      title: 'ListView',
      description: 'Scrollbare Liste – Mini-Simulation mit itemExtent.',
      moduleId: 'list-view',
      explanationDe:
          'ListView.builder erzeugt scrollbare Listen mit lazy Loading. itemExtent, padding, reverse, scrollDirection und physics steuern Layout und Scroll-Verhalten.',
      useCaseDe:
          'Feeds, Chat-Verläufe, Einstellungslisten und jede lange, scrollbare Datensammlung.',
      faq: _faq,
      previewHint: 'Liste scrollen',
      controller: _c,
      bindings: [
        PropertyBinding<double>(
          codeName: 'itemCount',
          labelDe: 'Anzahl',
          helpDe: 'Anzahl der Listeneinträge.',
          useCaseDe: 'Simuliert Listenlänge – bei echten Daten aus der API-Länge.',
          type: PropertyControlType.slider,
          min: 5,
          max: 40,
          divisions: 35,
          getValue: () => _c.itemCount.toDouble(),
          setValue: (v) => _c.update(() => _c.itemCount = v.round()),
        ),
        PropertyBinding<double>(
          codeName: 'itemExtent',
          labelDe: 'Item-Höhe/-Breite',
          helpDe: 'Feste Extent pro Eintrag (ListView.itemExtent).',
          useCaseDe: 'Einheitliche Zeilenhöhe für performante, gleichmäßige Listen.',
          type: PropertyControlType.slider,
          min: 40,
          max: 100,
          divisions: 30,
          getValue: () => _c.itemExtent,
          setValue: (v) => _c.update(() => _c.itemExtent = v),
        ),
        PropertyBinding<double>(
          codeName: 'padding',
          labelDe: 'Padding',
          helpDe: 'ListView.padding um die gesamte Liste.',
          useCaseDe: 'Abstand zu Rändern, Safe Area oder schwebende Elemente.',
          type: PropertyControlType.slider,
          min: 0,
          max: 32,
          divisions: 32,
          getValue: () => _c.padding,
          setValue: (v) => _c.update(() => _c.padding = v),
        ),
        PropertyBinding<bool>(
          codeName: 'reverse',
          labelDe: 'Umgekehrt',
          helpDe: 'ListView.reverse – Start am gegenüberliegenden Ende.',
          useCaseDe: 'Chat-Verläufe, die unten beginnen und nach oben wachsen.',
          type: PropertyControlType.switcher,
          getValue: () => _c.reverse,
          setValue: (v) => _c.update(() => _c.reverse = v),
        ),
        PropertyBinding<Axis>(
          codeName: 'scrollDirection',
          labelDe: 'Richtung',
          helpDe: 'ListView.scrollDirection horizontal oder vertikal.',
          useCaseDe: 'Vertikal für Standardlisten, horizontal für Karussells.',
          type: PropertyControlType.enumeration,
          enumValues: Axis.values,
          enumLabels: const ['horizontal', 'vertical'],
          getValue: () => _c.scrollDirection,
          setValue: (v) => _c.update(() => _c.scrollDirection = v),
        ),
        PropertyBinding<PlaygroundScrollPhysics>(
          codeName: 'physics',
          labelDe: 'Scroll-Physik',
          helpDe: 'ScrollPhysics: Clamping oder Bouncing am Listenende.',
          useCaseDe: 'Plattformtypisches Scroll-Feedback oder einheitliches App-Feel.',
          type: PropertyControlType.enumeration,
          enumValues: PlaygroundScrollPhysics.values,
          enumLabels: const ['clamping', 'bouncing'],
          getValue: () => _c.physics,
          setValue: (v) => _c.update(() => _c.physics = v),
        ),
      ],
      previewBuilder: (_) => ListView.builder(
        reverse: _c.reverse,
        scrollDirection: _c.scrollDirection,
        itemExtent: _c.itemExtent,
        padding: EdgeInsets.all(_c.padding),
        physics: _physics(_c.physics),
        itemCount: _c.itemCount,
        itemBuilder: (context, index) => ListTile(
          leading: CircleAvatar(child: Text('$index')),
          title: Text('Eintrag $index'),
          subtitle: const Text('Scrollbare Mini-Sim'),
        ),
      ),
    );
  }
}
