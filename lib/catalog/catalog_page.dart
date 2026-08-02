import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ui_training_model/catalog/registry.dart';
import 'package:ui_training_model/catalog/widget_module.dart';
import 'package:ui_training_model/theme/theme_provider.dart';

final catalogQueryProvider = StateProvider<String>((ref) => '');
final catalogCategoryProvider =
    StateProvider<WidgetCategory?>((ref) => null);

class CatalogPage extends ConsumerWidget {
  const CatalogPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = ref.watch(catalogQueryProvider);
    final category = ref.watch(catalogCategoryProvider);
    final themeMode = ref.watch(themeModeProvider);
    final modules = WidgetRegistry.search(query: query, category: category);
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('UI Training Lab'),
        actions: [
          IconButton(
            tooltip: 'Theme umschalten',
            onPressed: () {
              final next = switch (themeMode) {
                ThemeMode.light => ThemeMode.dark,
                ThemeMode.dark => ThemeMode.system,
                ThemeMode.system => ThemeMode.light,
              };
              ref.read(themeModeProvider.notifier).state = next;
            },
            icon: Icon(switch (themeMode) {
              ThemeMode.light => Icons.light_mode,
              ThemeMode.dark => Icons.dark_mode,
              ThemeMode.system => Icons.brightness_auto,
            }),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: Text(
              'Interaktive Flutter-Widget-Playgrounds — '
              'Property-Name sichtbar, Live-Preview steuerbar.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: TextField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Suche nach Widget oder Property…',
              ),
              onChanged: (v) =>
                  ref.read(catalogQueryProvider.notifier).state = v,
            ),
          ),
          SizedBox(
            height: 48,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: FilterChip(
                    label: const Text('Alle'),
                    selected: category == null,
                    onSelected: (_) =>
                        ref.read(catalogCategoryProvider.notifier).state =
                            null,
                  ),
                ),
                for (final cat in WidgetCategory.values)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: FilterChip(
                      label: Text(cat.labelDe),
                      selected: category == cat,
                      onSelected: (_) => ref
                          .read(catalogCategoryProvider.notifier)
                          .state = cat,
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: modules.isEmpty
                ? const Center(child: Text('Keine Module gefunden.'))
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                    itemCount: modules.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final m = modules[index];
                      return _ModuleTile(module: m);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _ModuleTile extends StatelessWidget {
  const _ModuleTile({required this.module});

  final WidgetModule module;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Material(
      color: scheme.surfaceContainerHighest.withValues(alpha: 0.4),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: module.planned
            ? null
            : () => context.push('/playground/${module.id}'),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: module.planned
                      ? scheme.surfaceContainerHighest
                      : scheme.primaryContainer,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  module.planned ? Icons.schedule : Icons.widgets_outlined,
                  color: module.planned
                      ? scheme.onSurfaceVariant
                      : scheme.onPrimaryContainer,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            module.title,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ),
                        if (module.planned)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: scheme.secondaryContainer,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              'Roadmap',
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      module.description,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: scheme.onSurfaceVariant,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      module.category.labelDe,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: scheme.tertiary,
                          ),
                    ),
                  ],
                ),
              ),
              if (!module.planned)
                Icon(Icons.chevron_right, color: scheme.onSurfaceVariant),
            ],
          ),
        ),
      ),
    );
  }
}
