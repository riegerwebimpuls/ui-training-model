import 'package:flutter/material.dart';
import 'package:ui_training_model/core/playground_shell.dart';
import 'package:ui_training_model/core/property_binding.dart';

class AppBarPlayground extends StatefulWidget {
  const AppBarPlayground({super.key});

  @override
  State<AppBarPlayground> createState() => _AppBarPlaygroundState();
}

class _Ctrl extends PlaygroundController {
  String title = 'AppBar';
  bool centerTitle = false;
  double elevation = 0;
  bool showActions = true;
  Color? backgroundColor;
}

class _AppBarPlaygroundState extends State<AppBarPlayground> {
  final _c = _Ctrl();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PlaygroundShell(
      title: 'AppBar',
      description: 'Obere Navigationsleiste mit Titel und Actions.',
      controller: _c,
      bindings: [
        PropertyBinding<String>(
          codeName: 'title',
          labelDe: 'Titel',
          helpDe: 'AppBar.title',
          type: PropertyControlType.text,
          getValue: () => _c.title,
          setValue: (v) => _c.update(() => _c.title = v),
        ),
        PropertyBinding<bool>(
          codeName: 'centerTitle',
          labelDe: 'Titel zentrieren',
          helpDe: 'AppBar.centerTitle',
          type: PropertyControlType.switcher,
          getValue: () => _c.centerTitle,
          setValue: (v) => _c.update(() => _c.centerTitle = v),
        ),
        PropertyBinding<double>(
          codeName: 'elevation',
          labelDe: 'Elevation',
          helpDe: 'AppBar.elevation',
          type: PropertyControlType.slider,
          min: 0,
          max: 12,
          divisions: 12,
          getValue: () => _c.elevation,
          setValue: (v) => _c.update(() => _c.elevation = v),
        ),
        PropertyBinding<bool>(
          codeName: 'actions',
          labelDe: 'Actions zeigen',
          helpDe: 'Ob Aktions-Icons rechts erscheinen.',
          type: PropertyControlType.switcher,
          getValue: () => _c.showActions,
          setValue: (v) => _c.update(() => _c.showActions = v),
        ),
        PropertyBinding<Color>(
          codeName: 'backgroundColor',
          labelDe: 'Hintergrund',
          helpDe: 'AppBar.backgroundColor',
          type: PropertyControlType.color,
          getValue: () =>
              _c.backgroundColor ?? Theme.of(context).colorScheme.surface,
          setValue: (v) => _c.update(() => _c.backgroundColor = v),
        ),
      ],
      previewBuilder: (_) => Column(
        children: [
          AppBar(
            automaticallyImplyLeading: false,
            title: Text(_c.title),
            centerTitle: _c.centerTitle,
            elevation: _c.elevation,
            backgroundColor: _c.backgroundColor,
            actions: _c.showActions
                ? const [
                    Icon(Icons.search),
                    SizedBox(width: 8),
                    Icon(Icons.more_vert),
                    SizedBox(width: 8),
                  ]
                : null,
          ),
          const Expanded(
            child: Center(child: Text('Seiteninhalt')),
          ),
        ],
      ),
    );
  }
}
