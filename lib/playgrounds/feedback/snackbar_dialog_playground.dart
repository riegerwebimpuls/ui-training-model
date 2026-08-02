import 'package:flutter/material.dart';
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
  double progress = 0.6;
  bool indeterminate = false;
}

class _FeedbackPlaygroundState extends State<FeedbackPlayground> {
  final _c = _Ctrl();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PlaygroundShell(
      title: 'SnackBar / Dialog / Progress',
      description: 'Feedback-Widgets: SnackBar, AlertDialog, ProgressIndicator.',
      controller: _c,
      bindings: [
        PropertyBinding<String>(
          codeName: 'SnackBar.content',
          labelDe: 'SnackBar-Text',
          helpDe: 'Inhalt der SnackBar.',
          type: PropertyControlType.text,
          getValue: () => _c.snackMessage,
          setValue: (v) => _c.update(() => _c.snackMessage = v),
        ),
        PropertyBinding<String>(
          codeName: 'AlertDialog.title',
          labelDe: 'Dialog-Titel',
          helpDe: 'AlertDialog.title',
          type: PropertyControlType.text,
          getValue: () => _c.dialogTitle,
          setValue: (v) => _c.update(() => _c.dialogTitle = v),
        ),
        PropertyBinding<String>(
          codeName: 'AlertDialog.content',
          labelDe: 'Dialog-Inhalt',
          helpDe: 'AlertDialog.content',
          type: PropertyControlType.text,
          getValue: () => _c.dialogContent,
          setValue: (v) => _c.update(() => _c.dialogContent = v),
        ),
        PropertyBinding<bool>(
          codeName: 'CircularProgressIndicator (indeterminate)',
          labelDe: 'Unbestimmt',
          helpDe: 'Ohne value = unbestimmter Fortschritt.',
          type: PropertyControlType.switcher,
          getValue: () => _c.indeterminate,
          setValue: (v) => _c.update(() => _c.indeterminate = v),
        ),
        PropertyBinding<double>(
          codeName: 'value',
          labelDe: 'Fortschritt',
          helpDe: 'CircularProgressIndicator.value (0–1).',
          type: PropertyControlType.slider,
          min: 0,
          max: 1,
          divisions: 20,
          getValue: () => _c.progress,
          setValue: (v) => _c.update(() => _c.progress = v),
        ),
      ],
      previewBuilder: (ctx) => Scaffold(
        key: _scaffoldKey,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                value: _c.indeterminate ? null : _c.progress,
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: () {
                  ScaffoldMessenger.of(ctx).showSnackBar(
                    SnackBar(content: Text(_c.snackMessage)),
                  );
                },
                child: const Text('SnackBar zeigen'),
              ),
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: () {
                  showDialog<void>(
                    context: ctx,
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
    );
  }
}
