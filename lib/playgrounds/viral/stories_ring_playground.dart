import 'package:flutter/material.dart';
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
      controller: _c,
      previewHint: 'Tippen markiert als gesehen',
      bindings: [
        PropertyBinding<double>(
          codeName: 'strokeWidth',
          labelDe: 'Ringbreite',
          helpDe: 'Dicke des Progress-Rings.',
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
          helpDe: 'Größe des inneren Avatars.',
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
          helpDe: 'Gesehene Stories nutzen grauen Ring.',
          type: PropertyControlType.switcher,
          getValue: () => _c.seen,
          setValue: (v) => _c.update(() => _c.seen = v),
        ),
        PropertyBinding<Color>(
          codeName: 'accentColor',
          labelDe: 'Akzentfarbe',
          helpDe: 'Farbe des ungesehenen Rings.',
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
