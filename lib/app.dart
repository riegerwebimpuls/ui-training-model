import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ui_training_model/catalog/catalog_page.dart';
import 'package:ui_training_model/catalog/registry.dart';
import 'package:ui_training_model/theme/app_theme.dart';
import 'package:ui_training_model/theme/theme_provider.dart';

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const CatalogPage(),
      routes: [
        GoRoute(
          path: 'playground/:id',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            final module = WidgetRegistry.byId(id);
            if (module == null || module.planned) {
              return Scaffold(
                appBar: AppBar(title: const Text('Nicht gefunden')),
                body: Center(child: Text('Unbekanntes Modul: $id')),
              );
            }
            return module.builder(context);
          },
        ),
      ],
    ),
  ],
);

class UiTrainingApp extends ConsumerWidget {
  const UiTrainingApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    return MaterialApp.router(
      title: 'UI Training Lab',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: themeMode,
      routerConfig: _router,
    );
  }
}
