import 'package:flutter/material.dart';
import 'package:ui_training_model/core/playground_shell.dart';
import 'package:ui_training_model/core/property_binding.dart';

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
}

class _ListViewPlaygroundState extends State<ListViewPlayground> {
  final _c = _Ctrl();

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
      controller: _c,
      previewHint: 'Liste scrollen',
      bindings: [
        PropertyBinding<double>(
          codeName: 'itemCount',
          labelDe: 'Anzahl',
          helpDe: 'Anzahl der Listeneinträge.',
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
          type: PropertyControlType.slider,
          min: 40,
          max: 100,
          divisions: 30,
          getValue: () => _c.itemExtent,
          setValue: (v) => _c.update(() => _c.itemExtent = v),
        ),
        PropertyBinding<bool>(
          codeName: 'reverse',
          labelDe: 'Umgekehrt',
          helpDe: 'ListView.reverse',
          type: PropertyControlType.switcher,
          getValue: () => _c.reverse,
          setValue: (v) => _c.update(() => _c.reverse = v),
        ),
        PropertyBinding<Axis>(
          codeName: 'scrollDirection',
          labelDe: 'Richtung',
          helpDe: 'ListView.scrollDirection',
          type: PropertyControlType.enumeration,
          enumValues: Axis.values,
          enumLabels: const ['horizontal', 'vertical'],
          getValue: () => _c.scrollDirection,
          setValue: (v) => _c.update(() => _c.scrollDirection = v),
        ),
      ],
      previewBuilder: (_) => ListView.builder(
        reverse: _c.reverse,
        scrollDirection: _c.scrollDirection,
        itemExtent: _c.itemExtent,
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
