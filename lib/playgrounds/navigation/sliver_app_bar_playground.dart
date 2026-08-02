import 'package:flutter/material.dart';
import 'package:ui_training_model/catalog/widget_module.dart';
import 'package:ui_training_model/core/playground_shell.dart';
import 'package:ui_training_model/core/property_binding.dart';

class SliverAppBarPlayground extends StatefulWidget {
  const SliverAppBarPlayground({super.key});

  @override
  State<SliverAppBarPlayground> createState() => _SliverAppBarPlaygroundState();
}

class _Ctrl extends PlaygroundController {
  bool pinned = true;
  bool floating = false;
  bool snap = false;
  double expandedHeight = 180;
  double elevation = 0;
  String title = 'Titel';
  bool forceElevated = false;
}

class _SliverAppBarPlaygroundState extends State<SliverAppBarPlayground> {
  final _c = _Ctrl();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return PlaygroundShell(
      moduleId: 'sliver-app-bar',
      title: 'SliverAppBar',
      description: 'Kollabierende AppBar in CustomScrollView.',
      explanationDe:
          'SliverAppBar lebt in einer CustomScrollView und kollabiert beim '
          'Scrollen. pinned hält die kompakte Leiste sichtbar, floating '
          'blendet sie beim Zurückscrollen ein, snap schnappt sie bei floating '
          'sofort auf. flexibleSpace zeigt den großen Header (FlexibleSpaceBar).',
      useCaseDe:
          'Profilseiten, Artikel-Header mit Hero-Bild, Shop-Detail und '
          'jede scrollbare Seite mit prominentem Titelbereich.',
      faq: const [
        ModuleFaq(
          question: 'pinned vs. floating?',
          answer:
              'pinned: true – die AppBar bleibt nach dem Kollabieren oben kleben. '
              'floating: true – sie erscheint wieder, sobald du nach oben scrollst, '
              'auch wenn du noch nicht ganz oben bist.',
        ),
        ModuleFaq(
          question: 'Wann snap aktivieren?',
          answer:
              'snap wirkt nur mit floating: true. Die AppBar springt dann '
              'zwischen voll expandiert und kollabiert – kein Zwischenzustand.',
        ),
        ModuleFaq(
          question: 'forceElevated?',
          answer:
              'Setzt Elevation auch im expandierten Zustand erzwungen – '
              'nützlich, wenn der Inhalt darunter durchscheinen würde.',
        ),
      ],
      controller: _c,
      previewHint: 'Liste scrollen',
      bindings: [
        PropertyBinding<bool>(
          codeName: 'pinned',
          labelDe: 'Pinned',
          helpDe: 'SliverAppBar.pinned – kompakte Leiste bleibt sichtbar.',
          useCaseDe: 'Titel und Actions nach dem Scrollen weiter erreichbar.',
          type: PropertyControlType.switcher,
          getValue: () => _c.pinned,
          setValue: (v) => _c.update(() => _c.pinned = v),
        ),
        PropertyBinding<bool>(
          codeName: 'floating',
          labelDe: 'Floating',
          helpDe: 'SliverAppBar.floating – Leiste beim Hochscrollen einblenden.',
          useCaseDe: 'Schneller Zugriff auf Navigation ohne ganz nach oben zu scrollen.',
          type: PropertyControlType.switcher,
          getValue: () => _c.floating,
          setValue: (v) => _c.update(() {
            _c.floating = v;
            if (!v) _c.snap = false;
          }),
        ),
        PropertyBinding<bool>(
          codeName: 'snap',
          labelDe: 'Snap',
          helpDe: 'SliverAppBar.snap – nur mit floating sinnvoll.',
          useCaseDe: 'AppBar springt sofort zwischen expandiert/kollabiert.',
          type: PropertyControlType.switcher,
          getValue: () => _c.snap,
          setValue: (v) => _c.update(() {
            _c.snap = v;
            if (v) _c.floating = true;
          }),
        ),
        PropertyBinding<double>(
          codeName: 'expandedHeight',
          labelDe: 'Expandierte Höhe',
          helpDe: 'SliverAppBar.expandedHeight – Höhe im ausgeklappten Zustand.',
          useCaseDe: 'Großer Hero-Bereich oder Profil-Header.',
          type: PropertyControlType.slider,
          min: 100,
          max: 280,
          divisions: 9,
          getValue: () => _c.expandedHeight,
          setValue: (v) => _c.update(() => _c.expandedHeight = v),
        ),
        PropertyBinding<double>(
          codeName: 'elevation',
          labelDe: 'Elevation',
          helpDe: 'SliverAppBar.elevation – Schatten der kompakten Leiste.',
          useCaseDe: 'Trennung zwischen AppBar und scrollendem Inhalt.',
          type: PropertyControlType.slider,
          min: 0,
          max: 12,
          divisions: 12,
          getValue: () => _c.elevation,
          setValue: (v) => _c.update(() => _c.elevation = v),
        ),
        PropertyBinding<String>(
          codeName: 'title',
          labelDe: 'Titel',
          helpDe: 'Text in FlexibleSpaceBar.title und kollabierter AppBar.',
          useCaseDe: 'Seiten- oder Artikelname im Header.',
          type: PropertyControlType.text,
          getValue: () => _c.title,
          setValue: (v) => _c.update(() => _c.title = v),
        ),
        PropertyBinding<bool>(
          codeName: 'forceElevated',
          labelDe: 'Elevation erzwingen',
          helpDe: 'SliverAppBar.forceElevated – Schatten auch expandiert.',
          useCaseDe: 'Lesbarkeit über durchscheinendem flexibleSpace.',
          type: PropertyControlType.switcher,
          getValue: () => _c.forceElevated,
          setValue: (v) => _c.update(() => _c.forceElevated = v),
        ),
      ],
      previewBuilder: (_) => CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: _c.pinned,
            floating: _c.floating,
            snap: _c.snap,
            expandedHeight: _c.expandedHeight,
            elevation: _c.elevation,
            forceElevated: _c.forceElevated,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(_c.title),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      scheme.primaryContainer,
                      scheme.secondaryContainer,
                    ],
                  ),
                ),
                child: const Center(
                  child: Icon(Icons.landscape, size: 64, color: Colors.white54),
                ),
              ),
            ),
            actions: const [
              IconButton(onPressed: null, icon: Icon(Icons.search)),
              IconButton(onPressed: null, icon: Icon(Icons.more_vert)),
            ],
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => ListTile(
                leading: CircleAvatar(child: Text('$index')),
                title: Text('Listeneintrag $index'),
                subtitle: const Text('Scrollen zum Kollabieren der AppBar'),
              ),
              childCount: 24,
            ),
          ),
        ],
      ),
    );
  }
}
