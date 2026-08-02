import 'package:flutter/material.dart';
import 'package:ui_training_model/catalog/widget_module.dart';
import 'package:ui_training_model/core/playground_shell.dart';
import 'package:ui_training_model/core/property_binding.dart';

class TabBarPlayground extends StatefulWidget {
  const TabBarPlayground({super.key});

  @override
  State<TabBarPlayground> createState() => _TabBarPlaygroundState();
}

class _Ctrl extends PlaygroundController {
  bool isScrollable = false;
  TabAlignment tabAlignment = TabAlignment.fill;
  double indicatorWeight = 2;
  Color indicatorColor = Colors.teal;
}

class _TabBarPlaygroundState extends State<TabBarPlayground>
    with SingleTickerProviderStateMixin {
  final _c = _Ctrl();
  late final TabController _tabs;

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabs.dispose();
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PlaygroundShell(
      title: 'TabBar + TabBarView',
      description: 'Tabs mit zugehörigem Page-Inhalt.',
      moduleId: 'tab-bar',
      explanationDe:
          'TabBar und TabBarView verbinden Registerkarten mit swipebarem Inhalt. '
          'tabAlignment, isScrollable und indicatorColor steuern Layout und Look.',
      useCaseDe:
          'Kategorien, Einstellungs-Bereiche oder Detail-Ansichten mit Unter-Tabs.',
      faq: const [
        ModuleFaq(
          question: 'Wann isScrollable?',
          answer:
              'Bei vielen oder langen Tab-Labels: horizontal scrollbare Leiste '
              'statt gleichmäßiger Verteilung.',
        ),
        ModuleFaq(
          question: 'tabAlignment vs. isScrollable?',
          answer:
              'isScrollable erlaubt Scrollen; tabAlignment steuert die '
              'Ausrichtung (fill, start, center) unabhängig davon.',
        ),
      ],
      controller: _c,
      previewHint: 'Tabs tippen oder wischen',
      bindings: [
        PropertyBinding<bool>(
          codeName: 'isScrollable',
          labelDe: 'Scrollbar',
          helpDe: 'TabBar.isScrollable – horizontales Scrollen der Tabs.',
          useCaseDe:
              'Bei >3 Tabs oder langen Labels aktivieren.',
          type: PropertyControlType.switcher,
          getValue: () => _c.isScrollable,
          setValue: (v) => _c.update(() => _c.isScrollable = v),
        ),
        PropertyBinding<TabAlignment>(
          codeName: 'tabAlignment',
          labelDe: 'Tab-Ausrichtung',
          helpDe: 'TabBar.tabAlignment – fill, start, center, …',
          useCaseDe:
              'fill für volle Breite; start/center bei scrollbaren Tab-Leisten.',
          type: PropertyControlType.enumeration,
          enumValues: TabAlignment.values,
          enumLabels: const ['start', 'startOffset', 'fill', 'center'],
          getValue: () => _c.tabAlignment,
          setValue: (v) => _c.update(() => _c.tabAlignment = v),
        ),
        PropertyBinding<double>(
          codeName: 'indicatorWeight',
          labelDe: 'Indicator-Dicke',
          helpDe: 'TabBar.indicatorWeight – Dicke der Unterstreichung.',
          useCaseDe:
              '2 px Standard; dicker für stärkere Markierung des aktiven Tabs.',
          type: PropertyControlType.slider,
          min: 1,
          max: 6,
          divisions: 5,
          getValue: () => _c.indicatorWeight,
          setValue: (v) => _c.update(() => _c.indicatorWeight = v),
        ),
        PropertyBinding<Color>(
          codeName: 'indicatorColor',
          labelDe: 'Indicator-Farbe',
          helpDe: 'TabBar.indicatorColor – Farbe der aktiven Markierung.',
          useCaseDe:
              'Primärfarbe oder Akzent für konsistentes Tab-Branding.',
          type: PropertyControlType.color,
          getValue: () => _c.indicatorColor,
          setValue: (v) => _c.update(() => _c.indicatorColor = v),
        ),
      ],
      previewBuilder: (_) => Column(
        children: [
          TabBar(
            controller: _tabs,
            isScrollable: _c.isScrollable,
            tabAlignment: _c.tabAlignment,
            indicatorWeight: _c.indicatorWeight,
            indicatorColor: _c.indicatorColor,
            tabs: const [
              Tab(text: 'Eins'),
              Tab(text: 'Zwei'),
              Tab(text: 'Drei'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabs,
              children: const [
                Center(child: Text('Seite 1 – wischen →')),
                Center(child: Text('Seite 2')),
                Center(child: Text('Seite 3')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
