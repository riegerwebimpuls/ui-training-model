import 'package:flutter/material.dart';
import 'package:ui_training_model/catalog/widget_module.dart';
import 'package:ui_training_model/chat/offline_chat_engine.dart';
import 'package:ui_training_model/chat/widget_chat_panel.dart';
import 'package:ui_training_model/core/controls/controls.dart';
import 'package:ui_training_model/core/property_binding.dart';

/// Generische Shell: Controls | Live-Preview (Desktop split, Mobile stacked).
///
/// Die Preview läuft in einem eigenen [Navigator] + [ScaffoldMessenger],
/// damit Dialoge, Sheets und SnackBars im Phone-Frame bleiben und
/// Gesten (Scroll/Swipe/Tap) greifen.
class PlaygroundShell extends StatelessWidget {
  const PlaygroundShell({
    super.key,
    required this.title,
    required this.description,
    required this.controller,
    required this.bindings,
    required this.previewBuilder,
    this.moduleId,
    this.explanationDe,
    this.useCaseDe,
    this.faq = const [],
    this.previewHint,
  });

  final String title;
  final String description;
  final PlaygroundController controller;
  final List<PropertyBinding<dynamic>> bindings;
  final Widget Function(BuildContext context) previewBuilder;
  final String? moduleId;
  final String? explanationDe;
  final String? useCaseDe;
  final List<ModuleFaq> faq;
  final String? previewHint;

  PlaygroundChatContext get _chatContext => PlaygroundChatContext(
        moduleId: moduleId ?? title,
        widgetName: title,
        explanationDe: explanationDe ?? description,
        useCaseDe: useCaseDe ?? description,
        bindings: bindings,
        faq: faq,
      );

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        final wide = MediaQuery.sizeOf(context).width >= 900;
        final controls = _ControlsPanel(
          bindings: bindings,
          explanationDe: explanationDe ?? description,
          useCaseDe: useCaseDe,
        );
        final preview = _PreviewPanel(
          hint: previewHint,
          child: previewBuilder,
        );

        return Scaffold(
          appBar: AppBar(
            title: Text(title),
            actions: [
              IconButton(
                tooltip: 'Info',
                onPressed: () {
                  final explanation = explanationDe ?? description;
                  showDialog<void>(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: Text(title),
                      content: SingleChildScrollView(
                        child: SelectionArea(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(child: Text(explanation)),
                                  CopyTextIconButton(
                                    text: explanation,
                                    tooltip: 'Erklärung kopieren',
                                    feedback: 'Erklärung kopiert',
                                  ),
                                ],
                              ),
                              if (useCaseDe != null) ...[
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Einsatz',
                                        style:
                                            Theme.of(ctx).textTheme.titleSmall,
                                      ),
                                    ),
                                    CopyTextIconButton(
                                      text: useCaseDe!,
                                      tooltip: 'Einsatz kopieren',
                                      feedback: 'Einsatz kopiert',
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(useCaseDe!),
                              ],
                            ],
                          ),
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(ctx),
                          child: const Text('Schließen'),
                        ),
                      ],
                    ),
                  );
                },
                icon: const Icon(Icons.info_outline),
              ),
            ],
          ),
          floatingActionButton: WidgetChatFab(chatContext: _chatContext),
          body: wide
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(width: 380, child: controls),
                    const VerticalDivider(width: 1),
                    Expanded(child: preview),
                  ],
                )
              : Column(
                  children: [
                    Expanded(flex: 5, child: controls),
                    const Divider(height: 1),
                    Expanded(flex: 6, child: preview),
                  ],
                ),
        );
      },
    );
  }
}

class _ControlsPanel extends StatelessWidget {
  const _ControlsPanel({
    required this.bindings,
    required this.explanationDe,
    this.useCaseDe,
  });

  final List<PropertyBinding<dynamic>> bindings;
  final String explanationDe;
  final String? useCaseDe;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return ColoredBox(
      color: Theme.of(context).colorScheme.surface,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 88),
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Über dieses Widget',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              CopyTextIconButton(
                text: [
                  explanationDe,
                  if (useCaseDe != null) 'Einsatz: $useCaseDe',
                ].join('\n\n'),
                tooltip: 'Modul-Info kopieren',
                feedback: 'Modul-Info kopiert',
              ),
            ],
          ),
          const SizedBox(height: 6),
          SelectionArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  explanationDe,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                ),
                if (useCaseDe != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    'Einsatz: $useCaseDe',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: scheme.primary,
                          fontStyle: FontStyle.italic,
                        ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Eigenschaften',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 4),
          Text(
            'Deutsche Erklärung + Einsatz + echter Flutter-codeName '
            '(markieren oder per Kopier-Icon)',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
          ),
          const SizedBox(height: 12),
          for (final b in bindings) buildControlFor(b),
        ],
      ),
    );
  }
}

class _PreviewPanel extends StatelessWidget {
  const _PreviewPanel({required this.child, this.hint});

  final Widget Function(BuildContext context) child;
  final String? hint;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return ColoredBox(
      color: scheme.surfaceContainerLowest,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Row(
              children: [
                Text(
                  'Live-Vorschau',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                if (hint != null) ...[
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      hint!,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: scheme.onSurfaceVariant,
                          ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420, maxHeight: 720),
                child: AspectRatio(
                  aspectRatio: 9 / 16,
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    decoration: BoxDecoration(
                      color: scheme.surface,
                      borderRadius: BorderRadius.circular(28),
                      border: Border.all(color: scheme.outlineVariant),
                      boxShadow: [
                        BoxShadow(
                          color: scheme.shadow.withValues(alpha: 0.12),
                          blurRadius: 24,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: ScaffoldMessenger(
                      child: Navigator(
                        onGenerateRoute: (settings) {
                          return MaterialPageRoute<void>(
                            settings: settings,
                            builder: (navContext) => child(navContext),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
