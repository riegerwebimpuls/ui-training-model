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
  cupertino('Cupertino');

  const WidgetCategory(this.labelDe);
  final String labelDe;
}

/// FAQ-Eintrag für den Offline-Chatbot eines Moduls.
class ModuleFaq {
  const ModuleFaq({required this.question, required this.answer});

  final String question;
  final String answer;
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
    this.explanationDe,
    this.useCaseDe,
    this.faq = const [],
    this.planned = false,
  });

  final String id;
  final String title;
  final String description;
  final WidgetCategory category;
  final List<String> tags;
  final WidgetBuilder builder;

  /// Visuelle Erklärung des Widgets (deutsch).
  final String? explanationDe;

  /// Typischer Einsatzzweck (deutsch).
  final String? useCaseDe;

  /// Häufige Fragen für den Offline-Chat.
  final List<ModuleFaq> faq;

  /// Nur dokumentiert, noch nicht implementiert.
  final bool planned;
}
