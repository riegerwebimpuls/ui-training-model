import 'package:flutter/material.dart';
import 'package:ui_training_model/catalog/widget_module.dart';
import 'package:ui_training_model/core/playground_shell.dart';
import 'package:ui_training_model/core/property_binding.dart';

class BottomNavPlayground extends StatefulWidget {
  const BottomNavPlayground({super.key});

  @override
  State<BottomNavPlayground> createState() => _BottomNavPlaygroundState();
}

class _Ctrl extends PlaygroundController {
  int currentIndex = 0;
  BottomNavigationBarType type = BottomNavigationBarType.fixed;
  bool showLabels = true;
  double elevation = 8;
}

class _BottomNavPlaygroundState extends State<BottomNavPlayground> {
  final _c = _Ctrl();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pages = ['Start', 'Suche', 'Profil'];
    return PlaygroundShell(
      title: 'BottomNavigationBar',
      description: 'Untere Tab-Leiste mit Index und Labels.',
      moduleId: 'bottom-nav',
      explanationDe:
          'Die BottomNavigationBar wechselt zwischen Hauptbereichen der App. '
          'fixed hält alle Items gleich sichtbar; shifting hebt den aktiven Tab '
          'hervor und animiert Labels.',
      useCaseDe:
          '3–5 Haupt-Tabs: Home, Suche, Profil – Standard in Mobile Apps.',
      faq: const [
        ModuleFaq(
          question: 'fixed vs. shifting?',
          answer:
              'fixed: alle Icons/Labels gleich breit. shifting: aktiver Tab '
              'wird betont – funktioniert am besten mit ≤4 Items.',
        ),
        ModuleFaq(
          question: 'Wann Labels ausblenden?',
          answer:
              'Nur Icons sparen Platz; Labels helfen bei unklaren Symbolen '
              'oder für Barrierefreiheit.',
        ),
      ],
      controller: _c,
      previewHint: 'Tabs antippen',
      bindings: [
        PropertyBinding<double>(
          codeName: 'currentIndex',
          labelDe: 'Aktiver Index',
          helpDe: 'BottomNavigationBar.currentIndex (0-basiert).',
          useCaseDe:
              'Programmatisch Tab setzen, z. B. nach Deep Link zum Profil.',
          type: PropertyControlType.slider,
          min: 0,
          max: 2,
          divisions: 2,
          getValue: () => _c.currentIndex.toDouble(),
          setValue: (v) => _c.update(() => _c.currentIndex = v.round()),
        ),
        PropertyBinding<BottomNavigationBarType>(
          codeName: 'type',
          labelDe: 'Typ',
          helpDe: 'BottomNavigationBarType: fixed oder shifting.',
          useCaseDe:
              'fixed für gleichmäßige Tabs; shifting für klassisches Material-Look.',
          type: PropertyControlType.enumeration,
          enumValues: BottomNavigationBarType.values,
          enumLabels: const ['fixed', 'shifting'],
          getValue: () => _c.type,
          setValue: (v) => _c.update(() => _c.type = v),
        ),
        PropertyBinding<bool>(
          codeName: 'showSelectedLabels / showUnselectedLabels',
          labelDe: 'Labels zeigen',
          helpDe: 'Ob Textlabels unter den Icons sichtbar sind.',
          useCaseDe:
              'Labels für Klarheit; aus bei sehr schmalen Layouts oder vielen Tabs.',
          type: PropertyControlType.switcher,
          getValue: () => _c.showLabels,
          setValue: (v) => _c.update(() => _c.showLabels = v),
        ),
        PropertyBinding<double>(
          codeName: 'elevation',
          labelDe: 'Elevation',
          helpDe: 'BottomNavigationBar.elevation – Schatten über dem Inhalt.',
          useCaseDe:
              'Leichter Schatten trennt Nav-Leiste vom scrollenden Body.',
          type: PropertyControlType.slider,
          min: 0,
          max: 16,
          divisions: 16,
          getValue: () => _c.elevation,
          setValue: (v) => _c.update(() => _c.elevation = v),
        ),
      ],
      previewBuilder: (_) => Column(
        children: [
          Expanded(
            child: Center(
              child: Text(
                pages[_c.currentIndex],
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
          ),
          BottomNavigationBar(
            currentIndex: _c.currentIndex,
            type: _c.type,
            elevation: _c.elevation,
            showSelectedLabels: _c.showLabels,
            showUnselectedLabels: _c.showLabels,
            onTap: (i) => _c.update(() => _c.currentIndex = i),
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Start'),
              BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Suche'),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profil',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
