import 'package:flutter/material.dart';
import 'package:ui_training_model/catalog/widget_module.dart';
import 'package:ui_training_model/core/playground_shell.dart';
import 'package:ui_training_model/core/property_binding.dart';

class NavigationRailPlayground extends StatefulWidget {
  const NavigationRailPlayground({super.key});

  @override
  State<NavigationRailPlayground> createState() =>
      _NavigationRailPlaygroundState();
}

class _Ctrl extends PlaygroundController {
  int selectedIndex = 0;
  bool extended = false;
  NavigationRailLabelType labelType = NavigationRailLabelType.all;
  double groupAlignment = 0;
  double minWidth = 72;
  bool useIndicator = true;
}

class _NavigationRailPlaygroundState extends State<NavigationRailPlayground> {
  final _c = _Ctrl();

  static const _destinations = [
    (icon: Icons.home_outlined, selectedIcon: Icons.home, label: 'Home'),
    (icon: Icons.search_outlined, selectedIcon: Icons.search, label: 'Suche'),
    (
      icon: Icons.settings_outlined,
      selectedIcon: Icons.settings,
      label: 'Einstellungen',
    ),
  ];

  static const _bodies = ['Startseite', 'Suche', 'Einstellungen'];

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PlaygroundShell(
      moduleId: 'navigation-rail',
      title: 'NavigationRail',
      description: 'Seitliche Navigation für breite Layouts.',
      explanationDe:
          'NavigationRail sitzt links oder rechts und zeigt Ziele als Icons '
          'mit optionalen Labels. extended=true vergrößert die Leiste für '
          'Textlabels; labelType steuert, wann Labels sichtbar sind.',
      useCaseDe:
          'Master-Detail auf Tablet/Desktop, Settings-Apps und Dashboards '
          'mit dauerhaft sichtbarer Hauptnavigation.',
      faq: const [
        ModuleFaq(
          question: 'NavigationRail vs. BottomNavigationBar?',
          answer:
              'BottomNavigationBar eignet sich für schmale Phones. '
              'NavigationRail nutzt die vertikale Seite bei breiten Viewports '
              'und kann extended Labels anzeigen.',
        ),
        ModuleFaq(
          question: 'Was macht useIndicator?',
          answer:
              'Mit useIndicator: true markiert Material 3 das aktive Ziel '
              'mit einem farbigen Indikator hinter dem Icon.',
        ),
        ModuleFaq(
          question: 'groupAlignment erklärt?',
          answer:
              'Steuert die vertikale Ausrichtung der Ziele: -1 oben, 0 Mitte, '
              '1 unten. Praktisch für unterschiedliche AppBar-Höhen.',
        ),
      ],
      controller: _c,
      previewHint: 'Ziele antippen',
      bindings: [
        PropertyBinding<double>(
          codeName: 'selectedIndex',
          labelDe: 'Aktiver Index',
          helpDe: 'NavigationRail.selectedIndex – aktuelles Ziel (0–2).',
          useCaseDe: 'Programmatisch zur Startseite springen oder Deep-Link.',
          type: PropertyControlType.slider,
          min: 0,
          max: 2,
          divisions: 2,
          getValue: () => _c.selectedIndex.toDouble(),
          setValue: (v) => _c.update(() => _c.selectedIndex = v.round()),
        ),
        PropertyBinding<bool>(
          codeName: 'extended',
          labelDe: 'Erweitert',
          helpDe: 'NavigationRail.extended – breitere Leiste mit Textlabels.',
          useCaseDe: 'Desktop-Layouts mit immer sichtbaren Beschriftungen.',
          type: PropertyControlType.switcher,
          getValue: () => _c.extended,
          setValue: (v) => _c.update(() => _c.extended = v),
        ),
        PropertyBinding<NavigationRailLabelType>(
          codeName: 'labelType',
          labelDe: 'Label-Typ',
          helpDe: 'NavigationRail.labelType – wann Labels erscheinen.',
          useCaseDe: 'Nur aktives Icon beschriften oder alle Ziele labeln.',
          type: PropertyControlType.enumeration,
          enumValues: NavigationRailLabelType.values,
          enumLabels: const ['none', 'selected', 'all'],
          getValue: () => _c.labelType,
          setValue: (v) => _c.update(() => _c.labelType = v),
        ),
        PropertyBinding<double>(
          codeName: 'groupAlignment',
          labelDe: 'Gruppen-Ausrichtung',
          helpDe: 'NavigationRail.groupAlignment: -1 oben, 0 Mitte, 1 unten.',
          useCaseDe: 'Navigation oben bei viel Leerraum unten (Chat-Apps).',
          type: PropertyControlType.slider,
          min: -1,
          max: 1,
          divisions: 2,
          getValue: () => _c.groupAlignment,
          setValue: (v) => _c.update(() => _c.groupAlignment = v),
        ),
        PropertyBinding<double>(
          codeName: 'minWidth',
          labelDe: 'Mindestbreite',
          helpDe: 'NavigationRail.minWidth – schmalste Leistenbreite.',
          useCaseDe: 'Feinjustierung zwischen Icon-only und extended Modus.',
          type: PropertyControlType.slider,
          min: 56,
          max: 120,
          divisions: 8,
          getValue: () => _c.minWidth,
          setValue: (v) => _c.update(() => _c.minWidth = v),
        ),
        PropertyBinding<bool>(
          codeName: 'useIndicator',
          labelDe: 'Indikator',
          helpDe: 'NavigationRail.useIndicator – M3-Auswahl-Markierung.',
          useCaseDe: 'Klares visuelles Feedback für das aktive Ziel.',
          type: PropertyControlType.switcher,
          getValue: () => _c.useIndicator,
          setValue: (v) => _c.update(() => _c.useIndicator = v),
        ),
      ],
      previewBuilder: (_) => Row(
        children: [
          NavigationRail(
            selectedIndex: _c.selectedIndex,
            extended: _c.extended,
            labelType: _c.labelType,
            groupAlignment: _c.groupAlignment,
            minWidth: _c.minWidth,
            useIndicator: _c.useIndicator,
            onDestinationSelected: (i) =>
                _c.update(() => _c.selectedIndex = i),
            destinations: [
              for (final d in _destinations)
                NavigationRailDestination(
                  icon: Icon(d.icon),
                  selectedIcon: Icon(d.selectedIcon),
                  label: Text(d.label),
                ),
            ],
          ),
          const VerticalDivider(width: 1),
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    _destinations[_c.selectedIndex].selectedIcon,
                    size: 48,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _bodies[_c.selectedIndex],
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
