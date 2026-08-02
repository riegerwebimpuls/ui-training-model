import 'package:flutter/material.dart';
import 'package:ui_training_model/catalog/widget_module.dart';
import 'package:ui_training_model/core/playground_shell.dart';
import 'package:ui_training_model/core/property_binding.dart';

class PaddingPlayground extends StatefulWidget {
  const PaddingPlayground({super.key});

  @override
  State<PaddingPlayground> createState() => _PaddingPlaygroundState();
}

class _Ctrl extends PlaygroundController {
  double padding = 16;
  double margin = 12;
}

class _PaddingPlaygroundState extends State<PaddingPlayground> {
  final _c = _Ctrl();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PlaygroundShell(
      moduleId: 'padding-margin',
      title: 'Padding / Margin',
      description: 'Unterschied zwischen Padding (innen) und Margin (außen).',
      explanationDe:
          'Padding vergrößert den Innenbereich zwischen Rand und Inhalt. '
          'Margin schiebt die gesamte Box von Nachbarn weg. Beide nutzen '
          'EdgeInsets – hier symmetrisch mit EdgeInsets.all(...). '
          'Asymmetrisch geht mit EdgeInsets.fromLTRB(left, top, right, bottom).',
      useCaseDe:
          'Abstände in Formularen, Listen und Karten – padding innen, margin außen.',
      faq: const [
        ModuleFaq(
          question: 'Padding oder Margin – wann was?',
          answer:
              'Padding: Abstand zwischen Rahmen und Inhalt (Text, Icon). '
              'Margin: Abstand zwischen dieser Box und anderen Widgets drumherum.',
        ),
        ModuleFaq(
          question: 'Kann ich unterschiedliche Seiten setzen?',
          answer:
              'Ja: EdgeInsets.only(left: 8, top: 4) oder fromLTRB(16, 8, 16, 8). '
              'Hier sind alle vier Seiten gleich – das reicht für den typischen Fall.',
        ),
        ModuleFaq(
          question: 'Padding vs. SizedBox?',
          answer:
              'Padding umschließt ein Kind und gibt ihm Luft. SizedBox erzwingt '
              'eine feste Größe – oft als Platzhalter oder Abstandshalter.',
        ),
      ],
      controller: _c,
      bindings: [
        PropertyBinding<double>(
          codeName: 'padding',
          labelDe: 'Padding',
          helpDe: 'Innenabstand zwischen Rand der inneren Box und Inhalt.',
          useCaseDe: 'Textabstand in Buttons, Karten-Innenabstand, Formularfelder.',
          type: PropertyControlType.slider,
          min: 0,
          max: 48,
          divisions: 48,
          getValue: () => _c.padding,
          setValue: (v) => _c.update(() => _c.padding = v),
        ),
        PropertyBinding<double>(
          codeName: 'margin',
          labelDe: 'Margin',
          helpDe: 'Außenabstand um die innere Box (über Container.margin).',
          useCaseDe: 'Abstand zwischen Listeneinträgen oder Karten im Grid.',
          type: PropertyControlType.slider,
          min: 0,
          max: 48,
          divisions: 48,
          getValue: () => _c.margin,
          setValue: (v) => _c.update(() => _c.margin = v),
        ),
      ],
      previewBuilder: (_) => Center(
        child: ColoredBox(
          color: Colors.teal.shade100,
          child: Container(
            margin: EdgeInsets.all(_c.margin),
            padding: EdgeInsets.all(_c.padding),
            color: Colors.teal,
            child: const Text(
              'Inhalt',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
