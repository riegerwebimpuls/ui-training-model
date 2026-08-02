import 'package:flutter/material.dart';
import 'package:ui_training_model/core/playground_shell.dart';
import 'package:ui_training_model/core/property_binding.dart';

class ListTilePlayground extends StatefulWidget {
  const ListTilePlayground({super.key});

  @override
  State<ListTilePlayground> createState() => _ListTilePlaygroundState();
}

class _Ctrl extends PlaygroundController {
  bool dense = false;
  bool selected = false;
  bool enabled = true;
  bool showLeading = true;
  bool showTrailing = true;
}

class _ListTilePlaygroundState extends State<ListTilePlayground> {
  final _c = _Ctrl();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PlaygroundShell(
      title: 'ListTile',
      description: 'Zeilen-Layout für Listen mit Leading/Trailing.',
      controller: _c,
      bindings: [
        PropertyBinding<bool>(
          codeName: 'dense',
          labelDe: 'Kompakt',
          helpDe: 'ListTile.dense – geringere Höhe.',
          type: PropertyControlType.switcher,
          getValue: () => _c.dense,
          setValue: (v) => _c.update(() => _c.dense = v),
        ),
        PropertyBinding<bool>(
          codeName: 'selected',
          labelDe: 'Ausgewählt',
          helpDe: 'ListTile.selected',
          type: PropertyControlType.switcher,
          getValue: () => _c.selected,
          setValue: (v) => _c.update(() => _c.selected = v),
        ),
        PropertyBinding<bool>(
          codeName: 'enabled',
          labelDe: 'Aktiviert',
          helpDe: 'ListTile.enabled',
          type: PropertyControlType.switcher,
          getValue: () => _c.enabled,
          setValue: (v) => _c.update(() => _c.enabled = v),
        ),
        PropertyBinding<bool>(
          codeName: 'leading',
          labelDe: 'Leading',
          helpDe: 'Icon links anzeigen.',
          type: PropertyControlType.switcher,
          getValue: () => _c.showLeading,
          setValue: (v) => _c.update(() => _c.showLeading = v),
        ),
        PropertyBinding<bool>(
          codeName: 'trailing',
          labelDe: 'Trailing',
          helpDe: 'Icon rechts anzeigen.',
          type: PropertyControlType.switcher,
          getValue: () => _c.showTrailing,
          setValue: (v) => _c.update(() => _c.showTrailing = v),
        ),
      ],
      previewBuilder: (_) => Center(
        child: Card(
          margin: const EdgeInsets.all(16),
          child: ListTile(
            dense: _c.dense,
            selected: _c.selected,
            enabled: _c.enabled,
            leading: _c.showLeading ? const Icon(Icons.person) : null,
            title: const Text('Titel'),
            subtitle: const Text('Untertitel / sekundärer Text'),
            trailing: _c.showTrailing ? const Icon(Icons.chevron_right) : null,
            onTap: _c.enabled ? () {} : null,
          ),
        ),
      ),
    );
  }
}
