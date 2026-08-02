import 'package:flutter/material.dart';
import 'package:ui_training_model/core/controls/controls.dart';
import 'package:ui_training_model/core/property_binding.dart';

/// Generische Shell: Controls | Live-Preview (Desktop split, Mobile stacked).
class PlaygroundShell extends StatelessWidget {
  const PlaygroundShell({
    super.key,
    required this.title,
    required this.description,
    required this.controller,
    required this.bindings,
    required this.previewBuilder,
    this.previewHint,
  });

  final String title;
  final String description;
  final PlaygroundController controller;
  final List<PropertyBinding<dynamic>> bindings;
  final Widget Function(BuildContext context) previewBuilder;
  final String? previewHint;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        final wide = MediaQuery.sizeOf(context).width >= 900;
        final controls = _ControlsPanel(bindings: bindings);
        final preview = _PreviewPanel(
          hint: previewHint,
          child: previewBuilder(context),
        );

        return Scaffold(
          appBar: AppBar(
            title: Text(title),
            actions: [
              IconButton(
                tooltip: 'Info',
                onPressed: () {
                  showDialog<void>(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: Text(title),
                      content: Text(description),
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
          body: wide
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(width: 360, child: controls),
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
  const _ControlsPanel({required this.bindings});

  final List<PropertyBinding<dynamic>> bindings;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).colorScheme.surface,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        children: [
          Text(
            'Eigenschaften',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 4),
          Text(
            'Deutsche Labels + echte Flutter-Property-Namen',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
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

  final Widget child;
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
                    margin: const EdgeInsets.all(16),
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
                    child: child,
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
