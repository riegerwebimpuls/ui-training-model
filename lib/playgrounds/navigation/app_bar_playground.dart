import 'package:flutter/material.dart';
import 'package:ui_training_model/catalog/widget_module.dart';
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
  double toolbarHeight = kToolbarHeight;
  double scrolledUnderElevation = 3;
  bool showActions = true;
  Color? backgroundColor;
  int searchTaps = 0;
  int menuTaps = 0;
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
      moduleId: 'app-bar',
      explanationDe:
          'Die AppBar sitzt oben in der Scaffold und zeigt Titel, Actions und '
          'optional einen Zurück-Pfeil. Beim Scrollen kann sich die Elevation '
          'unter dem Inhalt ändern (scrolledUnderElevation).',
      useCaseDe:
          'Screen-Titel, Suche, Menü und Navigation in fast jeder Material-App.',
      faq: const [
        ModuleFaq(
          question: 'Was ist scrolledUnderElevation?',
          answer:
              'Wenn Inhalt unter die AppBar scrollt, hebt sich die Leiste '
              'materialtypisch an – scrolledUnderElevation steuert den Schatten.',
        ),
        ModuleFaq(
          question: 'Wann centerTitle?',
          answer:
              'iOS-Stil: Titel zentriert. Android: oft links. '
              'centerTitle: true für einheitliches Zentrieren.',
        ),
      ],
      controller: _c,
      previewHint: 'Liste scrollen für Elevation',
      bindings: [
        PropertyBinding<String>(
          codeName: 'title',
          labelDe: 'Titel',
          helpDe: 'AppBar.title – sichtbarer Screen-Titel.',
          useCaseDe:
              'Kurz und eindeutig: „Einstellungen“, „Profil“, „Nachrichten“.',
          type: PropertyControlType.text,
          getValue: () => _c.title,
          setValue: (v) => _c.update(() => _c.title = v),
        ),
        PropertyBinding<bool>(
          codeName: 'centerTitle',
          labelDe: 'Titel zentrieren',
          helpDe: 'AppBar.centerTitle.',
          useCaseDe:
              'true für iOS-Look oder markenspezifisches zentriertes Layout.',
          type: PropertyControlType.switcher,
          getValue: () => _c.centerTitle,
          setValue: (v) => _c.update(() => _c.centerTitle = v),
        ),
        PropertyBinding<double>(
          codeName: 'elevation',
          labelDe: 'Elevation',
          helpDe: 'AppBar.elevation im Ruhezustand.',
          useCaseDe:
              '0 für flache AppBar; höher für sichtbaren Schatten ohne Scroll.',
          type: PropertyControlType.slider,
          min: 0,
          max: 12,
          divisions: 12,
          getValue: () => _c.elevation,
          setValue: (v) => _c.update(() => _c.elevation = v),
        ),
        PropertyBinding<double>(
          codeName: 'toolbarHeight',
          labelDe: 'Toolbar-Höhe',
          helpDe: 'AppBar.toolbarHeight in logischen Pixeln.',
          useCaseDe:
              'Standard kToolbarHeight (~56); höher für große Titel oder Branding.',
          type: PropertyControlType.slider,
          min: 48,
          max: 96,
          divisions: 24,
          getValue: () => _c.toolbarHeight,
          setValue: (v) => _c.update(() => _c.toolbarHeight = v),
        ),
        PropertyBinding<double>(
          codeName: 'scrolledUnderElevation',
          labelDe: 'Elevation beim Scrollen',
          helpDe: 'AppBar.scrolledUnderElevation wenn Inhalt darunter scrollt.',
          useCaseDe:
              'Material 3: Schatten erscheint, sobald die Liste unter die AppBar läuft.',
          type: PropertyControlType.slider,
          min: 0,
          max: 12,
          divisions: 12,
          getValue: () => _c.scrolledUnderElevation,
          setValue: (v) => _c.update(() => _c.scrolledUnderElevation = v),
        ),
        PropertyBinding<bool>(
          codeName: 'actions',
          labelDe: 'Actions zeigen',
          helpDe: 'Ob klickbare Aktions-Icons rechts erscheinen.',
          useCaseDe:
              'Suche, Teilen, Mehr-Menü – typische rechte AppBar-Actions.',
          type: PropertyControlType.switcher,
          getValue: () => _c.showActions,
          setValue: (v) => _c.update(() => _c.showActions = v),
        ),
        PropertyBinding<Color>(
          codeName: 'backgroundColor',
          labelDe: 'Hintergrund',
          helpDe: 'AppBar.backgroundColor.',
          useCaseDe:
              'Markenfarbe oder surfaceTint für abweichende AppBar.',
          type: PropertyControlType.color,
          getValue: () =>
              _c.backgroundColor ?? Theme.of(context).colorScheme.surface,
          setValue: (v) => _c.update(() => _c.backgroundColor = v),
        ),
      ],
      previewBuilder: (_) => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(_c.title),
          centerTitle: _c.centerTitle,
          elevation: _c.elevation,
          scrolledUnderElevation: _c.scrolledUnderElevation,
          toolbarHeight: _c.toolbarHeight,
          backgroundColor: _c.backgroundColor,
          actions: _c.showActions
              ? [
                  IconButton(
                    tooltip: 'Suche',
                    onPressed: () => _c.update(() => _c.searchTaps++),
                    icon: const Icon(Icons.search),
                  ),
                  IconButton(
                    tooltip: 'Mehr',
                    onPressed: () => _c.update(() => _c.menuTaps++),
                    icon: const Icon(Icons.more_vert),
                  ),
                ]
              : null,
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: 24,
          itemBuilder: (context, i) => Card(
            child: ListTile(
              title: Text('Eintrag ${i + 1}'),
              subtitle: Text(
                i == 0 && _c.showActions
                    ? 'Actions: Suche ${_c.searchTaps}×, Menü ${_c.menuTaps}×'
                    : 'Nach oben scrollen → Elevation unter AppBar',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
