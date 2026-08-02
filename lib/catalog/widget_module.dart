import 'package:flutter/material.dart';

/// Kategorie eines Trainingsmoduls.
enum WidgetCategory {
  layout('Layout'),
  textIcons('Text & Icons'),
  input('Input'),
  lists('Listen'),
  navigation('Navigation'),
  feedback('Feedback'),
  viral('Viral / häufig'),
  cupertino('Cupertino'),
  roadmap('Roadmap');

  const WidgetCategory(this.labelDe);
  final String labelDe;
}

/// Eintrag in der Widget-Registry.
class WidgetModule {
  const WidgetModule({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.tags,
    required this.builder,
    this.planned = false,
  });

  final String id;
  final String title;
  final String description;
  final WidgetCategory category;
  final List<String> tags;
  final WidgetBuilder builder;

  /// Nur dokumentiert, noch nicht implementiert.
  final bool planned;
}
