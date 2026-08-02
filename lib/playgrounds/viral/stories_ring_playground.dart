import 'package:flutter/material.dart';
import 'package:ui_training_model/catalog/widget_module.dart';
import 'package:ui_training_model/core/playground_shell.dart';
import 'package:ui_training_model/core/property_binding.dart';

class StoriesRingPlayground extends StatefulWidget {
  const StoriesRingPlayground({super.key});

  @override
  State<StoriesRingPlayground> createState() => _StoriesRingPlaygroundState();
}

class _Ctrl extends PlaygroundController {
  double ringWidth = 3;
  double progress = 0.65;
  double avatarRadius = 36;
  bool seen = false;
  Color accent = Colors.pink;
}

class _StoriesRingPlaygroundState extends State<StoriesRingPlayground> {
  final _c = _Ctrl();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PlaygroundShell(
      title: 'Story-Ringe',
      description: 'Avatar mit Progress-Ring (Instagram-/Stories-Muster).',
      moduleId: 'stories-ring',
      explanationDe:
          'Ein Ring um den Avatar signalisiert ungesehene Stories. '
          'Fortschritt und Farbe zeigen, wie viel bereits angesehen wurde; '
          'nach dem Tippen wechselt der Ring in den „gesehen“-Zustand.',
      useCaseDe:
          'Stories-Leiste in Social Apps, Highlight-Avatare und '
          'Fortschritts-Anzeige um Profilbilder.',
      faq: const [
        ModuleFaq(
          question: 'Warum grau bei „gesehen“?',
          answer:
              'Ungesehene Stories nutzen eine bunte Akzentfarbe; gesehene '
              'wechseln zu Grau – das Muster von Instagram und WhatsApp Status.',
        ),
        ModuleFaq(
          question: 'Was bedeutet progress?',
          answer:
              'progress (0–1) füllt den Ring anteilig – z. B. 3 von 5 '
              'Story-Segmenten bereits angesehen.',
        ),
      ],
      controller: _c,
      previewHint: 'Tippen markiert als gesehen',
      bindings: [
        PropertyBinding<double>(
          codeName: 'strokeWidth',
          labelDe: 'Ringbreite',
          helpDe: 'Dicke des Progress-Rings (strokeWidth).',
          useCaseDe:
              '2–4 px für dezente Ringe; dicker für stärkere Hervorhebung.',
          type: PropertyControlType.slider,
          min: 1,
          max: 8,
          divisions: 14,
          getValue: () => _c.ringWidth,
          setValue: (v) => _c.update(() => _c.ringWidth = v),
        ),
        PropertyBinding<double>(
          codeName: 'progress',
          labelDe: 'Fortschritt',
          helpDe: 'Anteil des Rings (0–1), z. B. gelesene Segmente.',
          useCaseDe:
              'Teilweise angesehene Story-Ketten: Ring füllt sich schrittweise.',
          type: PropertyControlType.slider,
          min: 0,
          max: 1,
          divisions: 20,
          getValue: () => _c.progress,
          setValue: (v) => _c.update(() => _c.progress = v),
        ),
        PropertyBinding<double>(
          codeName: 'radius',
          labelDe: 'Avatar-Radius',
          helpDe: 'Größe des inneren Avatars (CircleAvatar.radius).',
          useCaseDe:
              '32–40 px in Story-Leisten; größer auf Profilseiten.',
          type: PropertyControlType.slider,
          min: 20,
          max: 64,
          divisions: 22,
          getValue: () => _c.avatarRadius,
          setValue: (v) => _c.update(() => _c.avatarRadius = v),
        ),
        PropertyBinding<bool>(
          codeName: 'seen',
          labelDe: 'Gesehen',
          helpDe: 'Gesehene Stories nutzen grauen Ring statt Akzentfarbe.',
          useCaseDe:
              'Nach vollständig angesehener Story-Kette auf true setzen.',
          type: PropertyControlType.switcher,
          getValue: () => _c.seen,
          setValue: (v) => _c.update(() => _c.seen = v),
        ),
        PropertyBinding<Color>(
          codeName: 'accentColor',
          labelDe: 'Akzentfarbe',
          helpDe: 'Farbe des ungesehenen Rings.',
          useCaseDe:
              'Markenfarbe oder Verlauf-Farbe für ungesehene Highlights.',
          type: PropertyControlType.color,
          getValue: () => _c.accent,
          setValue: (v) => _c.update(() => _c.accent = v),
        ),
      ],
      previewBuilder: (_) {
        final ringColor = _c.seen ? Colors.grey : _c.accent;
        return Center(
          child: GestureDetector(
            onTap: () => _c.update(() => _c.seen = !_c.seen),
            child: SizedBox(
              width: (_c.avatarRadius + _c.ringWidth + 8) * 2,
              height: (_c.avatarRadius + _c.ringWidth + 8) * 2,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: (_c.avatarRadius + _c.ringWidth + 4) * 2,
                    height: (_c.avatarRadius + _c.ringWidth + 4) * 2,
                    child: CircularProgressIndicator(
                      value: _c.seen ? 1 : _c.progress,
                      strokeWidth: _c.ringWidth,
                      color: ringColor,
                      backgroundColor: ringColor.withValues(alpha: 0.2),
                    ),
                  ),
                  CircleAvatar(
                    radius: _c.avatarRadius,
                    backgroundColor: Colors.teal.shade200,
                    child: Icon(Icons.person, size: _c.avatarRadius),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
