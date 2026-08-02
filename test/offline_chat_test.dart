import 'package:flutter_test/flutter_test.dart';
import 'package:ui_training_model/catalog/widget_module.dart';
import 'package:ui_training_model/chat/offline_chat_engine.dart';
import 'package:ui_training_model/core/property_binding.dart';

void main() {
  late PlaygroundChatContext ctx;
  const engine = OfflineChatEngine();

  setUp(() {
    var radius = 12.0;
    ctx = PlaygroundChatContext(
      moduleId: 'container',
      widgetName: 'Container',
      explanationDe: 'Box mit Farbe und Padding.',
      useCaseDe: 'Karten, farbige Flächen, einfache Layout-Rahmen.',
      faq: const [
        ModuleFaq(
          question: 'Was ist Padding?',
          answer: 'Innenabstand um das Kind.',
        ),
      ],
      bindings: [
        PropertyBinding<double>(
          codeName: 'borderRadius',
          labelDe: 'Eckenradius',
          helpDe: 'Rundet die Ecken der Box.',
          useCaseDe: 'Karten und Chips weich erscheinen lassen.',
          type: PropertyControlType.slider,
          getValue: () => radius,
          setValue: (v) => radius = v,
        ),
      ],
    );
  });

  test('overview intent', () {
    final r = engine.reply('Was ist das Widget?', ctx);
    expect(r, contains('Container'));
    expect(r, contains('Box mit Farbe'));
  });

  test('property keyword match', () {
    final r = engine.reply('Was macht borderRadius?', ctx);
    expect(r, contains('borderRadius'));
    expect(r, contains('Rundet die Ecken'));
    expect(r, contains('Einsatz:'));
  });

  test('property list', () {
    final r = engine.reply('Welche Eigenschaften gibt es?', ctx);
    expect(r, contains('borderRadius'));
  });
}
