import 'package:flutter/material.dart';
import 'package:ui_training_model/catalog/widget_module.dart';
import 'package:ui_training_model/core/playground_shell.dart';
import 'package:ui_training_model/core/property_binding.dart';

class FeedbackPlayground extends StatefulWidget {
  const FeedbackPlayground({super.key});

  @override
  State<FeedbackPlayground> createState() => _FeedbackPlaygroundState();
}

class _Ctrl extends PlaygroundController {
  String snackMessage = 'Gespeichert';
  String dialogTitle = 'Bestätigen';
  String dialogContent = 'Möchtest du fortfahren?';
  SnackBarBehavior snackBehavior = SnackBarBehavior.fixed;
  bool showCloseIcon = false;
  double progress = 0.6;
  bool indeterminate = false;
}

class _FeedbackPlaygroundState extends State<FeedbackPlayground> {
  final _c = _Ctrl();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  Duration get _snackDuration =>
      _c.showCloseIcon ? const Duration(seconds: 10) : const Duration(seconds: 3);

  @override
  Widget build(BuildContext context) {
    return PlaygroundShell(
      title: 'SnackBar / Dialog / Progress',
      description: 'Feedback-Widgets: SnackBar, AlertDialog, ProgressIndicator.',
      moduleId: 'feedback',
      explanationDe:
          'SnackBars melden kurze Aktionen am unteren Rand, Dialoge blockieren '
          'für Entscheidungen, ProgressIndicator zeigt Fortschritt oder Warten.',
      useCaseDe:
          'Speichern-Bestätigung, Fehler-Hinweise, Bestätigungsdialoge und '
          'Ladezustände bei Uploads oder Synchronisation.',
      faq: const [
        ModuleFaq(
          question: 'Floating vs. fixed SnackBar?',
          answer:
              'fixed sitzt am unteren Rand der Scaffold; floating schwebt mit '
              'Abstand – oft bei Bottom Navigation oder FAB.',
        ),
        ModuleFaq(
          question: 'Wozu showCloseIcon?',
          answer:
              'Ein Schließen-Icon erlaubt längere SnackBars ohne Auto-Dismiss – '
              'sinnvoll bei wichtigen Hinweisen, die der Nutzer aktiv schließt.',
        ),
      ],
      controller: _c,
      previewHint: 'SnackBar & Dialog im Phone-Frame',
      bindings: [
        PropertyBinding<String>(
          codeName: 'SnackBar.content',
          labelDe: 'SnackBar-Text',
          helpDe: 'Inhalt der SnackBar (content).',
          useCaseDe:
              'Kurze Bestätigung: „Gespeichert“, „In Zwischenablage kopiert“.',
          type: PropertyControlType.text,
          getValue: () => _c.snackMessage,
          setValue: (v) => _c.update(() => _c.snackMessage = v),
        ),
        PropertyBinding<SnackBarBehavior>(
          codeName: 'SnackBar.behavior',
          labelDe: 'SnackBar-Verhalten',
          helpDe: 'fixed am Rand oder floating mit Abstand.',
          useCaseDe:
              'floating bei Bottom Nav; fixed bei einfacher Vollbild-Scaffold.',
          type: PropertyControlType.enumeration,
          enumValues: SnackBarBehavior.values,
          enumLabels: const ['fixed', 'floating'],
          getValue: () => _c.snackBehavior,
          setValue: (v) => _c.update(() => _c.snackBehavior = v),
        ),
        PropertyBinding<bool>(
          codeName: 'SnackBar.showCloseIcon',
          labelDe: 'Schließen-Icon',
          helpDe:
              'X-Icon zum manuellen Schließen; verlängert die Anzeige-Dauer.',
          useCaseDe:
              'Bei wichtigen Meldungen, die nicht sofort verschwinden sollen.',
          type: PropertyControlType.switcher,
          getValue: () => _c.showCloseIcon,
          setValue: (v) => _c.update(() => _c.showCloseIcon = v),
        ),
        PropertyBinding<String>(
          codeName: 'AlertDialog.title',
          labelDe: 'Dialog-Titel',
          helpDe: 'AlertDialog.title – Überschrift des Dialogs.',
          useCaseDe:
              'Kurz und handlungsorientiert: „Löschen?“, „Abmelden?“.',
          type: PropertyControlType.text,
          getValue: () => _c.dialogTitle,
          setValue: (v) => _c.update(() => _c.dialogTitle = v),
        ),
        PropertyBinding<String>(
          codeName: 'AlertDialog.content',
          labelDe: 'Dialog-Inhalt',
          helpDe: 'AlertDialog.content – erklärender Text.',
          useCaseDe:
              'Konsequenz der Aktion beschreiben, bevor der Nutzer bestätigt.',
          type: PropertyControlType.text,
          getValue: () => _c.dialogContent,
          setValue: (v) => _c.update(() => _c.dialogContent = v),
        ),
        PropertyBinding<bool>(
          codeName: 'CircularProgressIndicator (indeterminate)',
          labelDe: 'Unbestimmt',
          helpDe: 'Ohne value = unbestimmter Fortschritt (Spinner).',
          useCaseDe:
              'Wenn die Dauer unbekannt ist – z. B. Netzwerk-Anfrage läuft.',
          type: PropertyControlType.switcher,
          getValue: () => _c.indeterminate,
          setValue: (v) => _c.update(() => _c.indeterminate = v),
        ),
        PropertyBinding<double>(
          codeName: 'value',
          labelDe: 'Fortschritt',
          helpDe: 'CircularProgressIndicator.value (0–1).',
          useCaseDe:
              'Bei bekanntem Fortschritt: Upload 60 %, Sync-Schritte.',
          type: PropertyControlType.slider,
          min: 0,
          max: 1,
          divisions: 20,
          getValue: () => _c.progress,
          setValue: (v) => _c.update(() => _c.progress = v),
        ),
      ],
      previewBuilder: (_) => Scaffold(
        body: Builder(
          builder: (innerCtx) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  value: _c.indeterminate ? null : _c.progress,
                ),
                const SizedBox(height: 24),
                FilledButton(
                  onPressed: () {
                    ScaffoldMessenger.of(innerCtx).showSnackBar(
                      SnackBar(
                        content: Text(_c.snackMessage),
                        behavior: _c.snackBehavior,
                        showCloseIcon: _c.showCloseIcon,
                        duration: _snackDuration,
                      ),
                    );
                  },
                  child: const Text('SnackBar zeigen'),
                ),
                const SizedBox(height: 12),
                OutlinedButton(
                  onPressed: () {
                    showDialog<void>(
                      context: innerCtx,
                      builder: (dCtx) => AlertDialog(
                        title: Text(_c.dialogTitle),
                        content: Text(_c.dialogContent),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(dCtx),
                            child: const Text('Abbrechen'),
                          ),
                          FilledButton(
                            onPressed: () => Navigator.pop(dCtx),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  },
                  child: const Text('Dialog zeigen'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
