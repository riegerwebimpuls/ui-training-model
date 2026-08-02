import 'package:flutter/material.dart';
import 'package:ui_training_model/catalog/widget_module.dart';
import 'package:ui_training_model/core/playground_shell.dart';
import 'package:ui_training_model/core/property_binding.dart';

class DataTablePlayground extends StatefulWidget {
  const DataTablePlayground({super.key});

  @override
  State<DataTablePlayground> createState() => _DataTablePlaygroundState();
}

class _RowData {
  const _RowData({required this.name, required this.role, required this.score});

  final String name;
  final String role;
  final int score;
}

class _Ctrl extends PlaygroundController {
  int sortColumnIndex = 0;
  bool sortAscending = true;
  double headingRowHeight = 56;
  double dataRowMinHeight = 48;
  double columnSpacing = 56;
  bool showCheckboxColumn = true;
  bool border = true;

  final Set<int> selectedRows = {0};
}

class _DataTablePlaygroundState extends State<DataTablePlayground> {
  final _c = _Ctrl();

  static const _rows = [
    _RowData(name: 'Anna', role: 'Designer', score: 92),
    _RowData(name: 'Ben', role: 'Entwickler', score: 88),
    _RowData(name: 'Clara', role: 'PM', score: 95),
    _RowData(name: 'David', role: 'QA', score: 81),
    _RowData(name: 'Eva', role: 'DevOps', score: 90),
  ];

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  List<_RowData> _sortedRows() {
    final list = List<_RowData>.from(_rows);
    final col = _c.sortColumnIndex;
    list.sort((a, b) {
      int cmp;
      switch (col) {
        case 0:
          cmp = a.name.compareTo(b.name);
        case 1:
          cmp = a.role.compareTo(b.role);
        default:
          cmp = a.score.compareTo(b.score);
      }
      return _c.sortAscending ? cmp : -cmp;
    });
    return list;
  }

  void _onSort(int columnIndex, bool ascending) {
    _c.update(() {
      _c.sortColumnIndex = columnIndex;
      _c.sortAscending = ascending;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PlaygroundShell(
      moduleId: 'data-table',
      title: 'DataTable',
      description: 'Tabellarische Darstellung mit Sortierung und Auswahl.',
      explanationDe:
          'DataTable zeigt Spalten mit Überschriften und Zeilen. Spaltenköpfe '
          'können sortierbar sein (onSort), optional gibt es eine Checkbox-Spalte '
          'für Mehrfachauswahl. Größen und Rahmen lassen sich fein justieren.',
      useCaseDe:
          'Admin-Tabellen, Vergleichslisten, Bestellübersichten und '
          'Einstellungs-Grids auf Desktop und Tablet.',
      faq: const [
        ModuleFaq(
          question: 'Wann DataTable statt ListView?',
          answer:
              'DataTable eignet sich für strukturierte Spalten mit Headern, '
              'Sortierung und Checkbox-Auswahl. ListView ist besser für '
              'einspaltige, unterschiedlich gestaltete Zeilen.',
        ),
        ModuleFaq(
          question: 'Wie funktioniert onSort?',
          answer:
              'Beim Tipp auf einen sortierbaren Spaltenkopf ruft Flutter onSort '
              'mit Spaltenindex und aufsteigend/absteigend auf. Du setzt '
              'sortColumnIndex und sortAscending und sortierst die Datenquelle neu.',
        ),
        ModuleFaq(
          question: 'Warum scrollt die Tabelle horizontal?',
          answer:
              'Bei schmalen Viewports oder vielen Spalten wächst DataTable über '
              'die Breite. Ein SingleChildScrollView mit scrollDirection horizontal '
              'verhindert Abschneiden.',
        ),
      ],
      controller: _c,
      previewHint: 'Spaltenköpfe tippen · Checkboxen wählen',
      bindings: [
        PropertyBinding<double>(
          codeName: 'sortColumnIndex',
          labelDe: 'Sortier-Spalte',
          helpDe: 'DataTable.sortColumnIndex – welche Spalte sortiert ist (0–2).',
          useCaseDe: 'Standard-Sortierung beim Öffnen oder nach Nutzeraktion.',
          type: PropertyControlType.slider,
          min: 0,
          max: 2,
          divisions: 2,
          getValue: () => _c.sortColumnIndex.toDouble(),
          setValue: (v) => _c.update(() => _c.sortColumnIndex = v.round()),
        ),
        PropertyBinding<bool>(
          codeName: 'sortAscending',
          labelDe: 'Aufsteigend',
          helpDe: 'DataTable.sortAscending – Sortierrichtung.',
          useCaseDe: 'Alphabetisch A→Z oder numerisch klein→groß.',
          type: PropertyControlType.switcher,
          getValue: () => _c.sortAscending,
          setValue: (v) => _c.update(() => _c.sortAscending = v),
        ),
        PropertyBinding<double>(
          codeName: 'headingRowHeight',
          labelDe: 'Kopfzeilen-Höhe',
          helpDe: 'DataTable.headingRowHeight – Höhe der Header-Zeile.',
          useCaseDe: 'Mehr Platz für zweizeilige Spaltenüberschriften.',
          type: PropertyControlType.slider,
          min: 40,
          max: 80,
          divisions: 8,
          getValue: () => _c.headingRowHeight,
          setValue: (v) => _c.update(() => _c.headingRowHeight = v),
        ),
        PropertyBinding<double>(
          codeName: 'dataRowMinHeight',
          labelDe: 'Zeilen-Mindesthöhe',
          helpDe: 'DataTable.dataRowMinHeight – minimale Zeilenhöhe.',
          useCaseDe: 'Kompakte oder großzügige Tabellenzeilen.',
          type: PropertyControlType.slider,
          min: 36,
          max: 72,
          divisions: 9,
          getValue: () => _c.dataRowMinHeight,
          setValue: (v) => _c.update(() => _c.dataRowMinHeight = v),
        ),
        PropertyBinding<double>(
          codeName: 'columnSpacing',
          labelDe: 'Spaltenabstand',
          helpDe: 'DataTable.columnSpacing – Abstand zwischen Spalten.',
          useCaseDe: 'Luftige Layouts oder dichtere Datentabellen.',
          type: PropertyControlType.slider,
          min: 8,
          max: 96,
          divisions: 11,
          getValue: () => _c.columnSpacing,
          setValue: (v) => _c.update(() => _c.columnSpacing = v),
        ),
        PropertyBinding<bool>(
          codeName: 'showCheckboxColumn',
          labelDe: 'Checkbox-Spalte',
          helpDe: 'DataTable.showCheckboxColumn – Auswahlspalte links.',
          useCaseDe: 'Mehrfachauswahl für Bulk-Aktionen (löschen, exportieren).',
          type: PropertyControlType.switcher,
          getValue: () => _c.showCheckboxColumn,
          setValue: (v) => _c.update(() => _c.showCheckboxColumn = v),
        ),
        PropertyBinding<bool>(
          codeName: 'border',
          labelDe: 'Rahmen',
          helpDe: 'DataTable.border – TableBorder.all oder null.',
          useCaseDe: 'Klare Gitterlinien in dichten Admin-Oberflächen.',
          type: PropertyControlType.switcher,
          getValue: () => _c.border,
          setValue: (v) => _c.update(() => _c.border = v),
        ),
      ],
      previewBuilder: (_) {
        final sorted = _sortedRows();
        final scheme = Theme.of(context).colorScheme;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(8),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              sortColumnIndex: _c.sortColumnIndex,
              sortAscending: _c.sortAscending,
              headingRowHeight: _c.headingRowHeight,
              dataRowMinHeight: _c.dataRowMinHeight,
              columnSpacing: _c.columnSpacing,
              showCheckboxColumn: _c.showCheckboxColumn,
              border: _c.border
                  ? TableBorder.all(color: scheme.outlineVariant)
                  : null,
              columns: [
                DataColumn(
                  label: const Text('Name'),
                  onSort: (i, asc) => _onSort(0, asc),
                ),
                DataColumn(
                  label: const Text('Rolle'),
                  onSort: (i, asc) => _onSort(1, asc),
                ),
                DataColumn(
                  label: const Text('Punkte'),
                  numeric: true,
                  onSort: (i, asc) => _onSort(2, asc),
                ),
              ],
              rows: [
                for (var i = 0; i < sorted.length; i++)
                  DataRow(
                    selected: _c.selectedRows.contains(i),
                    onSelectChanged: _c.showCheckboxColumn
                        ? (selected) {
                            _c.update(() {
                              if (selected == true) {
                                _c.selectedRows.add(i);
                              } else {
                                _c.selectedRows.remove(i);
                              }
                            });
                          }
                        : null,
                    cells: [
                      DataCell(Text(sorted[i].name)),
                      DataCell(Text(sorted[i].role)),
                      DataCell(Text('${sorted[i].score}')),
                    ],
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
