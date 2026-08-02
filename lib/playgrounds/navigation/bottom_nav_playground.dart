import 'package:flutter/material.dart';
import 'package:ui_training_model/core/playground_shell.dart';
import 'package:ui_training_model/core/property_binding.dart';

class BottomNavPlayground extends StatefulWidget {
  const BottomNavPlayground({super.key});

  @override
  State<BottomNavPlayground> createState() => _BottomNavPlaygroundState();
}

class _Ctrl extends PlaygroundController {
  int currentIndex = 0;
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
      controller: _c,
      bindings: [
        PropertyBinding<double>(
          codeName: 'currentIndex',
          labelDe: 'Aktiver Index',
          helpDe: 'BottomNavigationBar.currentIndex',
          type: PropertyControlType.slider,
          min: 0,
          max: 2,
          divisions: 2,
          getValue: () => _c.currentIndex.toDouble(),
          setValue: (v) => _c.update(() => _c.currentIndex = v.round()),
        ),
        PropertyBinding<bool>(
          codeName: 'showSelectedLabels / showUnselectedLabels',
          labelDe: 'Labels zeigen',
          helpDe: 'Ob Textlabels unter den Icons sichtbar sind.',
          type: PropertyControlType.switcher,
          getValue: () => _c.showLabels,
          setValue: (v) => _c.update(() => _c.showLabels = v),
        ),
        PropertyBinding<double>(
          codeName: 'elevation',
          labelDe: 'Elevation',
          helpDe: 'BottomNavigationBar.elevation',
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
            elevation: _c.elevation,
            showSelectedLabels: _c.showLabels,
            showUnselectedLabels: _c.showLabels,
            onTap: (i) => _c.update(() => _c.currentIndex = i),
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Start'),
              BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Suche'),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
            ],
          ),
        ],
      ),
    );
  }
}
