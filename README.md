# UI Training Lab

Interaktives **Flutter-Web**-Trainingslab für Widget-Properties: Katalog → Playground mit Controls (deutscher Hilfetext + Einsatz + echter Flutter-`codeName`) → Live-Preview als interaktive Mini-Simulation → Offline-Widget-Chat.

Repo: [`riegerwebimpuls/ui-training-model`](https://github.com/riegerwebimpuls/ui-training-model)  
Workspace-Klon unter Aftonomos: `workspaces/ui-training-model`.

## Starten

Voraussetzung: Flutter SDK (getestet mit 3.44 / Dart 3.12).

```bash
cd workspaces/ui-training-model   # bzw. Repo-Root
flutter pub get
flutter run -d chrome
```

Analyse / Tests:

```bash
flutter analyze
flutter test
```

Optionaler LLM-Hinweis (Standard bleibt offline, kein Netzwerk-Call):

```bash
flutter run -d chrome \
  --dart-define=UITRAINING_LLM_ENDPOINT=https://example.invalid \
  --dart-define=UITRAINING_LLM_API_KEY=
```

Web-Build:

```bash
flutter build web
```

## Bedienung

1. **Katalog**: Suche nach Widget-/Property-Namen, Filter über Kategorie-Chips.
2. **Playground**: Desktop = Controls links / Preview rechts; Mobile = Controls oben / Preview unten.
3. Jede Property zeigt `codeName`, kurze visuelle Erklärung und empfohlenen **Einsatz**.
4. **Live-Vorschau** ist interaktiv (Scroll, Swipe, Tap, Dialoge/Sheets im Phone-Frame).
5. **Widget-Chat** (FAB): Offline-Knowledge-Bot mit FAQ + Keyword-Matching über die Docs dieses Moduls.
6. Theme-Toggle in der AppBar (Hell / Dunkel / System).

## Neues Playground in 3 Schritten

1. Datei unter `lib/playgrounds/<kategorie>/mein_playground.dart`:
   - `PlaygroundController` mit State
   - `PropertyBinding`s mit `codeName`, `labelDe`, `helpDe`, `useCaseDe`
   - `PlaygroundShell` mit `moduleId`, `explanationDe`, `useCaseDe`, `faq`, `previewBuilder`
2. In `lib/catalog/registry.dart` registrieren.
3. Optional FAQ für den Offline-Chat ergänzen.

## Katalog

| Kategorie | Module |
|-----------|--------|
| Layout | Container, Padding/Margin, Row/Column/Expanded, Stack/Positioned, SizedBox |
| Text & Icons | Text/TextStyle, Icon |
| Input | Buttons, TextField, Selection, Chip/FilterChip |
| Listen | ListTile, ListView, DataTable |
| Navigation | AppBar, BottomNavigationBar, TabBar, NavigationRail, SliverAppBar |
| Feedback | SnackBar, AlertDialog, CircularProgressIndicator |
| Viral | Card-Stack, PageView Carousel, Modal Bottom Sheet, Story-Ringe |
| Cupertino | CupertinoButton, CupertinoSwitch |

Weitere Kandidaten: `GestureDetector`, `AnimatedContainer`, `Hero`, Formular-Validierung, Accessibility.

## Architektur (kurz)

```
lib/
  catalog/     # Registry + CatalogPage
  chat/        # OfflineChatEngine + WidgetChatPanel (+ optional LLM config)
  core/        # PlaygroundShell, PropertyBinding, Controls
  playgrounds/ # Modul-spezifische Previews + Bindings
  widgets/     # Wiederverwendbare Demo-Widgets (CardStack)
  theme/       # ColorScheme, DM Sans + JetBrains Mono
```

State: `flutter_riverpod` (Theme + Katalog-Filter) und `ChangeNotifier` pro Playground.  
Routing: `go_router`. Preview: eigener `Navigator` + `ScaffoldMessenger` im Phone-Frame.
