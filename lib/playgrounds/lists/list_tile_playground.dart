import 'package:flutter/material.dart';
import 'package:ui_training_model/catalog/widget_module.dart';
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
  bool isThreeLine = false;
  double contentPadding = 16;
}

class _ListTilePlaygroundState extends State<ListTilePlayground> {
  final _c = _Ctrl();

  static const _faq = [
    ModuleFaq(
      question: 'Wann isThreeLine verwenden?',
      answer:
          'isThreeLine: true reserviert Platz für drei Textzeilen (title + zwei subtitle-Zeilen). Ohne genug Text bleibt der Bereich leer.',
    ),
    ModuleFaq(
      question: 'Was macht contentPadding?',
      answer:
          'contentPadding steuert den Innenabstand der Kachel. Nützlich für Ausrichtung mit anderen Widgets oder kompaktere Listen.',
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
      title: 'ListTile',
      description: 'Zeilen-Layout für Listen mit Leading/Trailing.',
      moduleId: 'list-tile',
      explanationDe:
          'ListTile strukturiert eine Zeile mit leading, title, subtitle und trailing. dense, selected und contentPadding steuern Größe und Zustand.',
      useCaseDe:
          'Einstellungen, Kontaktlisten, Navigationseinträge und jede tappbare Zeile in einer Liste.',
      faq: _faq,
      previewHint: 'Tippen zeigt Snackbar (wenn aktiviert)',
      controller: _c,
      bindings: [
        PropertyBinding<bool>(
          codeName: 'dense',
          labelDe: 'Kompakt',
          helpDe: 'ListTile.dense – geringere Zeilenhöhe.',
          useCaseDe: 'Lange Listen mit vielen Einträgen platzsparend darstellen.',
          type: PropertyControlType.switcher,
          getValue: () => _c.dense,
          setValue: (v) => _c.update(() => _c.dense = v),
        ),
        PropertyBinding<bool>(
          codeName: 'selected',
          labelDe: 'Ausgewählt',
          helpDe: 'ListTile.selected hebt die Zeile hervor.',
          useCaseDe: 'Aktiver Menüpunkt oder markierter Listeneintrag.',
          type: PropertyControlType.switcher,
          getValue: () => _c.selected,
          setValue: (v) => _c.update(() => _c.selected = v),
        ),
        PropertyBinding<bool>(
          codeName: 'enabled',
          labelDe: 'Aktiviert',
          helpDe: 'ListTile.enabled – false deaktiviert onTap.',
          useCaseDe: 'Einträge ausblenden/sperren bei fehlender Berechtigung.',
          type: PropertyControlType.switcher,
          getValue: () => _c.enabled,
          setValue: (v) => _c.update(() => _c.enabled = v),
        ),
        PropertyBinding<bool>(
          codeName: 'isThreeLine',
          labelDe: 'Drei Zeilen',
          helpDe: 'ListTile.isThreeLine für erweiterten Subtitle.',
          useCaseDe: 'Zusätzliche Beschreibung oder Metadaten unter dem Titel.',
          type: PropertyControlType.switcher,
          getValue: () => _c.isThreeLine,
          setValue: (v) => _c.update(() => _c.isThreeLine = v),
        ),
        PropertyBinding<double>(
          codeName: 'contentPadding',
          labelDe: 'Innenabstand',
          helpDe: 'ListTile.contentPadding horizontal und vertikal.',
          useCaseDe: 'Ausrichtung mit Cards oder angepasstes Listen-Spacing.',
          type: PropertyControlType.slider,
          min: 0,
          max: 32,
          divisions: 32,
          getValue: () => _c.contentPadding,
          setValue: (v) => _c.update(() => _c.contentPadding = v),
        ),
        PropertyBinding<bool>(
          codeName: 'leading',
          labelDe: 'Leading',
          helpDe: 'Icon oder Avatar links anzeigen.',
          useCaseDe: 'Personen-Avatar, Kategorie-Icon oder Status-Badge.',
          type: PropertyControlType.switcher,
          getValue: () => _c.showLeading,
          setValue: (v) => _c.update(() => _c.showLeading = v),
        ),
        PropertyBinding<bool>(
          codeName: 'trailing',
          labelDe: 'Trailing',
          helpDe: 'Icon oder Widget rechts anzeigen.',
          useCaseDe: 'Chevron für Navigation, Switch oder Kontext-Menü.',
          type: PropertyControlType.switcher,
          getValue: () => _c.showTrailing,
          setValue: (v) => _c.update(() => _c.showTrailing = v),
        ),
      ],
      previewBuilder: (previewContext) => Center(
        child: Card(
          margin: const EdgeInsets.all(16),
          child: ListTile(
            dense: _c.dense,
            selected: _c.selected,
            enabled: _c.enabled,
            isThreeLine: _c.isThreeLine,
            contentPadding: EdgeInsets.symmetric(
              horizontal: _c.contentPadding,
              vertical: _c.contentPadding / 2,
            ),
            leading: _c.showLeading ? const Icon(Icons.person) : null,
            title: const Text('Titel'),
            subtitle: Text(
              _c.isThreeLine
                  ? 'Untertitel Zeile eins\nUntertitel Zeile zwei'
                  : 'Untertitel / sekundärer Text',
            ),
            trailing:
                _c.showTrailing ? const Icon(Icons.chevron_right) : null,
            onTap: _c.enabled
                ? () {
                    ScaffoldMessenger.of(previewContext).showSnackBar(
                      const SnackBar(
                        content: Text('ListTile angetippt'),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  }
                : null,
          ),
        ),
      ),
    );
  }
}
