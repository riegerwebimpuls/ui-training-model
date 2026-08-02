import 'package:flutter/material.dart';
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
      controller: _c,
      bindings: [
        PropertyBinding<bool>(
          codeName: 'isScrollable',
          labelDe: 'Scrollbar',
          helpDe: 'TabBar.isScrollable',
          type: PropertyControlType.switcher,
          getValue: () => _c.isScrollable,
          setValue: (v) => _c.update(() {
            _c.isScrollable = v;
            _c.tabAlignment =
                v ? TabAlignment.start : TabAlignment.fill;
          }),
        ),
        PropertyBinding<double>(
          codeName: 'indicatorWeight',
          labelDe: 'Indicator-Dicke',
          helpDe: 'TabBar.indicatorWeight',
          type: PropertyControlType.slider,
          min: 1,
          max: 6,
          divisions: 5,
          getValue: () => _c.indicatorWeight,
          setValue: (v) => _c.update(() => _c.indicatorWeight = v),
        ),
      ],
      previewBuilder: (_) => Column(
        children: [
          TabBar(
            controller: _tabs,
            isScrollable: _c.isScrollable,
            tabAlignment: _c.tabAlignment,
            indicatorWeight: _c.indicatorWeight,
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
                Center(child: Text('Seite 1')),
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
