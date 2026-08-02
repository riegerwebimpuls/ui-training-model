import 'package:flutter/material.dart';
import 'package:ui_training_model/catalog/widget_module.dart';
import 'package:ui_training_model/core/playground_shell.dart';
import 'package:ui_training_model/core/property_binding.dart';

enum ChipVariant { assist, filter, choice, input }

class ChipPlayground extends StatefulWidget {
  const ChipPlayground({super.key});

  @override
  State<ChipPlayground> createState() => _ChipPlaygroundState();
}

class _Ctrl extends PlaygroundController {
  ChipVariant variant = ChipVariant.filter;
  String label = 'Filter';
  bool selected = false;
  bool avatar = true;
  bool deleteIcon = true;
  double elevation = 0;
  Color? backgroundColor;
}

class _ChipPlaygroundState extends State<ChipPlayground> {
  final _c = _Ctrl();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  Widget _buildChip() {
    final avatar = _c.avatar
        ? CircleAvatar(
            radius: 12,
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            child: Icon(
              Icons.person,
              size: 14,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          )
        : null;

    switch (_c.variant) {
      case ChipVariant.assist:
        return ActionChip(
          label: Text(_c.label),
          avatar: avatar,
          elevation: _c.elevation,
          backgroundColor: _c.backgroundColor,
          onPressed: () {},
        );
      case ChipVariant.filter:
        return FilterChip(
          label: Text(_c.label),
          selected: _c.selected,
          avatar: avatar,
          elevation: _c.elevation,
          backgroundColor: _c.backgroundColor,
          onSelected: (v) => _c.update(() => _c.selected = v),
        );
      case ChipVariant.choice:
        return ChoiceChip(
          label: Text(_c.label),
          selected: _c.selected,
          avatar: avatar,
          elevation: _c.elevation,
          backgroundColor: _c.backgroundColor,
          onSelected: (v) => _c.update(() => _c.selected = v),
        );
      case ChipVariant.input:
        return InputChip(
          label: Text(_c.label),
          avatar: avatar,
          elevation: _c.elevation,
          backgroundColor: _c.backgroundColor,
          deleteIcon: _c.deleteIcon ? const Icon(Icons.close, size: 18) : null,
          onDeleted: _c.deleteIcon ? () {} : null,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return PlaygroundShell(
      moduleId: 'chip',
      title: 'Chip / FilterChip',
      description: 'Kompakte Tags für Filter, Auswahl und Eingaben.',
      explanationDe:
          'Chips sind pillenförmige Elemente für Tags, Filter und kurze Aktionen. '
          'ActionChip (Assist), FilterChip, ChoiceChip und InputChip unterscheiden '
          'sich in Interaktion: tippen, umschalten, einzeln wählen oder löschen.',
      useCaseDe:
          'Suchfilter, Kategorie-Tags, Mehrfachauswahl in Formularen und '
          'entfernbare E-Mail-Empfänger.',
      faq: const [
        ModuleFaq(
          question: 'FilterChip vs. ChoiceChip?',
          answer:
              'FilterChip erlaubt Mehrfachauswahl (mehrere Filter aktiv). '
              'ChoiceChip verhält sich wie Radio-Buttons – typisch nur eine '
              'Option in einer Gruppe ist selected.',
        ),
        ModuleFaq(
          question: 'Wofür ActionChip?',
          answer:
              'ActionChip (früher „Assist Chip“) löst eine Aktion aus – '
              'z. B. „+ Tag hinzufügen“. Er hat onPressed statt selected.',
        ),
        ModuleFaq(
          question: 'InputChip und deleteIcon?',
          answer:
              'InputChip zeigt eingegebene Werte (z. B. Kontakte). Mit onDeleted '
              'und deleteIcon kann der Nutzer den Chip entfernen.',
        ),
      ],
      controller: _c,
      previewHint: 'FilterChip/ChoiceChip antippen',
      bindings: [
        PropertyBinding<ChipVariant>(
          codeName: 'variant',
          labelDe: 'Variante',
          helpDe: 'ActionChip, FilterChip, ChoiceChip oder InputChip.',
          useCaseDe: 'Passende Chip-Klasse je nach Interaktionsmodell wählen.',
          type: PropertyControlType.enumeration,
          enumValues: ChipVariant.values,
          enumLabels: const [
            'ActionChip (Assist)',
            'FilterChip',
            'ChoiceChip',
            'InputChip',
          ],
          getValue: () => _c.variant,
          setValue: (v) => _c.update(() => _c.variant = v),
        ),
        PropertyBinding<String>(
          codeName: 'label',
          labelDe: 'Label',
          helpDe: 'Text im Chip (label-Property).',
          useCaseDe: 'Kategoriename, Filterbegriff oder Tag-Text.',
          type: PropertyControlType.text,
          getValue: () => _c.label,
          setValue: (v) => _c.update(() => _c.label = v),
        ),
        PropertyBinding<bool>(
          codeName: 'selected',
          labelDe: 'Ausgewählt',
          helpDe: 'FilterChip/ChoiceChip.selected – aktiver Zustand.',
          useCaseDe: 'Visuelles Feedback für aktive Filter oder gewählte Option.',
          type: PropertyControlType.switcher,
          getValue: () => _c.selected,
          setValue: (v) => _c.update(() => _c.selected = v),
        ),
        PropertyBinding<bool>(
          codeName: 'avatar',
          labelDe: 'Avatar',
          helpDe: 'Optionales Leading-Widget links im Chip.',
          useCaseDe: 'Person, Icon oder Mini-Bild zur Identifikation.',
          type: PropertyControlType.switcher,
          getValue: () => _c.avatar,
          setValue: (v) => _c.update(() => _c.avatar = v),
        ),
        PropertyBinding<bool>(
          codeName: 'deleteIcon',
          labelDe: 'Löschen-Icon',
          helpDe: 'InputChip.deleteIcon – nur bei InputChip sinnvoll.',
          useCaseDe: 'Entfernbare Tags in Suchfeldern oder Formularen.',
          type: PropertyControlType.switcher,
          getValue: () => _c.deleteIcon,
          setValue: (v) => _c.update(() => _c.deleteIcon = v),
        ),
        PropertyBinding<double>(
          codeName: 'elevation',
          labelDe: 'Elevation',
          helpDe: 'Material-Elevation des Chips (Schatten).',
          useCaseDe: 'Leicht erhöhte Chips auf flachen Hintergründen.',
          type: PropertyControlType.slider,
          min: 0,
          max: 8,
          divisions: 8,
          getValue: () => _c.elevation,
          setValue: (v) => _c.update(() => _c.elevation = v),
        ),
        PropertyBinding<Color>(
          codeName: 'backgroundColor',
          labelDe: 'Hintergrund',
          helpDe: 'Chip.backgroundColor – Flächenfarbe.',
          useCaseDe: 'Markenfarbe oder dezenter Kategorie-Hintergrund.',
          type: PropertyControlType.color,
          getValue: () =>
              _c.backgroundColor ?? Theme.of(context).colorScheme.surfaceContainerHighest,
          setValue: (v) => _c.update(() => _c.backgroundColor = v),
        ),
      ],
      previewBuilder: (_) => Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: [_buildChip()],
          ),
        ),
      ),
    );
  }
}
