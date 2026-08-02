import 'package:ui_training_model/catalog/widget_module.dart';
import 'package:ui_training_model/core/property_binding.dart';

/// Kontext für den Playground-Chat (ohne Secrets / Netzwerk).
class PlaygroundChatContext {
  const PlaygroundChatContext({
    required this.moduleId,
    required this.widgetName,
    required this.explanationDe,
    required this.useCaseDe,
    required this.bindings,
    this.faq = const [],
  });

  final String moduleId;
  final String widgetName;
  final String explanationDe;
  final String useCaseDe;
  final List<PropertyBinding<dynamic>> bindings;
  final List<ModuleFaq> faq;
}

class ChatMessage {
  const ChatMessage({required this.fromUser, required this.text});

  final bool fromUser;
  final String text;
}

/// On-Device Knowledge-Chat: FAQ + Keyword-/Intent-Matching über Property-Docs.
class OfflineChatEngine {
  const OfflineChatEngine();

  String reply(String rawQuestion, PlaygroundChatContext ctx) {
    final q = rawQuestion.trim();
    if (q.isEmpty) {
      return 'Stelle eine Frage zu ${ctx.widgetName} oder einer Property '
          '(z. B. „Was macht borderRadius?“).';
    }

    final lower = _normalize(q);

    if (_matchesAny(lower, const [
      'hilfe',
      'help',
      'was kannst',
      'wie funktioniert chat',
    ])) {
      return _helpText(ctx);
    }

    if (_matchesAny(lower, const [
      'überblick',
      'wozu dient',
      'erklär das widget',
      'erklaer das widget',
      'beschreibung',
      'was ist das widget',
      'was ist dieses widget',
    ]) ||
        (lower.startsWith('was ist ') &&
            !_looksLikePropertyQuestion(lower, ctx))) {
      return _widgetOverview(ctx);
    }

    if (_matchesAny(lower, const [
      'einsatz',
      'verwenden',
      'wann',
      'use case',
      'usecase',
      'empfohlen',
    ])) {
      return 'Typischer Einsatz von ${ctx.widgetName}:\n${ctx.useCaseDe}';
    }

    if (_matchesAny(lower, const [
      'liste',
      'properties',
      'eigenschaften',
      'welche parameter',
      'welche props',
    ])) {
      final lines = ctx.bindings
          .map((b) => '• `${b.codeName}` — ${b.labelDe}')
          .join('\n');
      return 'Steuerbare Properties in diesem Playground:\n$lines';
    }

    PropertyBinding<dynamic>? best;
    var bestScore = 0.0;
    for (final b in ctx.bindings) {
      final score = _propertyScore(lower, b);
      if (score > bestScore) {
        bestScore = score;
        best = b;
      }
    }

    if (best != null && bestScore >= 0.35) {
      return _propertyAnswer(best);
    }

    for (final faq in ctx.faq) {
      final fq = _normalize(faq.question);
      if (_tokenOverlap(fq, lower) >= 0.5 ||
          (fq.length >= 6 && lower.contains(fq))) {
        return faq.answer;
      }
    }

    final suggestions = ctx.bindings.take(5).map((b) => b.codeName).join(', ');
    return 'Dazu habe ich in den Docs von „${ctx.widgetName}“ keinen Treffer. '
        'Frage z. B. nach: $suggestions — oder „Überblick“ / „Eigenschaften“.';
  }

  bool _looksLikePropertyQuestion(String q, PlaygroundChatContext ctx) {
    for (final b in ctx.bindings) {
      final code = _normalize(b.codeName);
      if (code.isNotEmpty && q.contains(code)) return true;
      final label = _normalize(b.labelDe);
      if (label.length >= 4 && q.contains(label)) return true;
    }
    return false;
  }

  String _helpText(PlaygroundChatContext ctx) {
    return 'Ich beantworte Fragen zu **${ctx.widgetName}** offline aus den '
        'Playground-Docs (Modul-ID: `${ctx.moduleId}`). '
        'Beispiele: „Was ist das Widget?“, „Einsatz“, „Was macht '
        '${ctx.bindings.isNotEmpty ? ctx.bindings.first.codeName : '…'}?“ '
        'oder „Welche Properties gibt es?“';
  }

  String _widgetOverview(PlaygroundChatContext ctx) {
    final buf = StringBuffer()
      ..writeln('${ctx.widgetName} (`${ctx.moduleId}`)')
      ..writeln()
      ..writeln(ctx.explanationDe)
      ..writeln()
      ..writeln('Einsatz: ${ctx.useCaseDe}');
    if (ctx.faq.isNotEmpty) {
      buf
        ..writeln()
        ..writeln('Tipp: Frage „${ctx.faq.first.question}“.');
    }
    return buf.toString();
  }

  String _propertyAnswer(PropertyBinding<dynamic> b) {
    return '`${b.codeName}` — ${b.labelDe}\n'
        '${b.helpDe}\n'
        'Einsatz: ${b.useCaseDe}';
  }

  double _propertyScore(String query, PropertyBinding<dynamic> b) {
    final code = _normalize(b.codeName);
    final label = _normalize(b.labelDe);
    final help = _normalize(b.helpDe);
    final use = _normalize(b.useCaseDe);

    var score = 0.0;
    if (query.contains(code) || code.contains(query)) score += 1.0;
    for (final token in code.split(RegExp(r'[^a-z0-9äöüß]+'))) {
      if (token.length >= 3 && query.contains(token)) score += 0.55;
    }
    score += _tokenOverlap(query, label) * 0.7;
    score += _tokenOverlap(query, help) * 0.35;
    score += _tokenOverlap(query, use) * 0.25;
    return score;
  }

  double _tokenOverlap(String a, String b) {
    final ta = a.split(RegExp(r'\s+')).where((t) => t.length > 2).toSet();
    final tb = b.split(RegExp(r'\s+')).where((t) => t.length > 2).toSet();
    if (ta.isEmpty || tb.isEmpty) return 0;
    final inter = ta.intersection(tb).length;
    return inter / ta.length;
  }

  bool _matchesAny(String q, List<String> needles) {
    for (final n in needles) {
      if (q.contains(n)) return true;
    }
    return false;
  }

  String _normalize(String s) => s
      .toLowerCase()
      .replaceAll('ß', 'ss')
      .replaceAll(RegExp(r'[^\w\säöü]+', unicode: true), ' ')
      .replaceAll(RegExp(r'\s+'), ' ')
      .trim();
}
