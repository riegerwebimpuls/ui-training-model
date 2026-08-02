# UI Training Lab

Interaktives **Flutter-Web**-Trainingslab für Widget-Properties: Katalog → Playground mit Controls (deutscher Hilfetext + echter Flutter-`codeName`) → Live-Preview als Mini-Simulation.

Repo: [`riegerwebimpuls/ui-training-model`](https://github.com/riegerwebimpuls/ui-training-model)  
Workspace-Klon unter Aftonomos: `workspaces/ui-training-model` (Diagnose/Automation läuft parallel und ist getrennt von diesem Feature-Bau).

## Starten

Voraussetzung: Flutter SDK (getestet mit 3.44 / Dart 3.12).

```bash
cd workspaces/ui-training-model   # bzw. Repo-Root
flutter pub get
flutter run -d chrome
```

Analyse:

```bash
flutter analyze
```

Web-Build (optional, z. B. für GitHub Pages später):

```bash
flutter build web
# Ausgabe unter build/web — Deploy z. B. als GitHub Pages Static Site
```

## Bedienung

1. **Katalog**: Suche nach Widget-/Property-Namen, Filter über Kategorie-Chips.
2. **Playground**: Desktop = Controls links / Preview rechts; Mobile = Controls oben / Preview unten.
3. Theme-Toggle in der AppBar (Hell / Dunkel / System).
4. Card-Stack: vordere Karte wischen — steuert `borderRadius`, `positionFactor`, `scaleFactor`, `reverseOrder`, `opacityOnDrag`, `dismissOrientation`, `swipeOrientation`.

## Neues Playground in 3 Schritten

1. Datei unter `lib/playgrounds/<kategorie>/mein_playground.dart` anlegen:
   - `PlaygroundController` mit State
   - Liste von `PropertyBinding`s (codeName + labelDe + helpDe)
   - `PlaygroundShell` mit `previewBuilder`
2. In `lib/catalog/registry.dart` einen `WidgetModule`-Eintrag registrieren (`id`, `category`, `tags`, `builder`).
3. Optional: Roadmap-Slot (`planned: true`) entfernen bzw. ersetzen.

Generische Controls liegen unter `lib/core/controls/`. Die Shell ist `lib/core/playground_shell.dart`.

## Katalog (MVP)

| Kategorie | Module |
|-----------|--------|
| Layout | Container, Padding/Margin, Row/Column/Expanded, Stack/Positioned, SizedBox |
| Text & Icons | Text/TextStyle, Icon |
| Input | Buttons, TextField, Switch/Checkbox/Slider/Dropdown |
| Listen | ListTile, ListView |
| Navigation | AppBar, BottomNavigationBar, TabBar+TabBarView |
| Feedback | SnackBar, AlertDialog, CircularProgressIndicator |
| Viral | Card-Stack Swiper, PageView Carousel, Modal Bottom Sheet, Story-Ringe |
| Cupertino | CupertinoButton, CupertinoSwitch |

## Roadmap (nächste Iterationen)

Registriert als geplante Slots (noch ohne volles Binding):

- `DataTable`
- `Chip` / `FilterChip`
- `NavigationRail`
- `SliverAppBar`

Weitere Kandidaten: `GestureDetector`-Demos, `AnimatedContainer`, `Hero`, Formular-Validierung, Accessibility-Properties.

## Architektur (kurz)

```
lib/
  catalog/     # Registry + CatalogPage
  core/        # PlaygroundShell, PropertyBinding, Controls
  playgrounds/ # Modul-spezifische Previews + Bindings
  widgets/     # Wiederverwendbare Demo-Widgets (CardStack)
  theme/       # ColorScheme, DM Sans + JetBrains Mono
```

State: `flutter_riverpod` (Theme + Katalog-Filter) und `ChangeNotifier` pro Playground.  
Routing: `go_router`.
