import 'package:flutter/material.dart';
import 'package:ui_training_model/core/playground_shell.dart';
import 'package:ui_training_model/core/property_binding.dart';

class BottomSheetPlayground extends StatefulWidget {
  const BottomSheetPlayground({super.key});

  @override
  State<BottomSheetPlayground> createState() => _BottomSheetPlaygroundState();
}

class _Ctrl extends PlaygroundController {
  bool isScrollControlled = false;
  bool enableDrag = true;
  bool showDragHandle = true;
  double borderRadius = 16;
}

class _BottomSheetPlaygroundState extends State<BottomSheetPlayground> {
  final _c = _Ctrl();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PlaygroundShell(
      title: 'Modal Bottom Sheet',
      description: 'showModalBottomSheet mit Drag-Handle und Radius.',
      controller: _c,
      bindings: [
        PropertyBinding<bool>(
          codeName: 'isScrollControlled',
          labelDe: 'Scroll-kontrolliert',
          helpDe: 'Erlaubt höhere Sheets (isScrollControlled).',
          type: PropertyControlType.switcher,
          getValue: () => _c.isScrollControlled,
          setValue: (v) => _c.update(() => _c.isScrollControlled = v),
        ),
        PropertyBinding<bool>(
          codeName: 'enableDrag',
          labelDe: 'Ziehen erlauben',
          helpDe: 'enableDrag – Sheet per Geste schließen.',
          type: PropertyControlType.switcher,
          getValue: () => _c.enableDrag,
          setValue: (v) => _c.update(() => _c.enableDrag = v),
        ),
        PropertyBinding<bool>(
          codeName: 'showDragHandle',
          labelDe: 'Drag-Handle',
          helpDe: 'showDragHandle oben am Sheet.',
          type: PropertyControlType.switcher,
          getValue: () => _c.showDragHandle,
          setValue: (v) => _c.update(() => _c.showDragHandle = v),
        ),
        PropertyBinding<double>(
          codeName: 'shape.borderRadius',
          labelDe: 'Eckenradius',
          helpDe: 'Obere Ecken des Sheets.',
          type: PropertyControlType.slider,
          min: 0,
          max: 32,
          divisions: 32,
          getValue: () => _c.borderRadius,
          setValue: (v) => _c.update(() => _c.borderRadius = v),
        ),
      ],
      previewBuilder: (ctx) => Center(
        child: FilledButton(
          onPressed: () {
            showModalBottomSheet<void>(
              context: ctx,
              isScrollControlled: _c.isScrollControlled,
              enableDrag: _c.enableDrag,
              showDragHandle: _c.showDragHandle,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(_c.borderRadius),
                ),
              ),
              builder: (sheetCtx) => SizedBox(
                height: _c.isScrollControlled ? 360 : 220,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Bottom Sheet',
                        style: Theme.of(sheetCtx).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Inhalt einer modalen Bottom Sheet. '
                        'Ziehen zum Schließen, wenn enableDrag aktiv ist.',
                      ),
                      const Spacer(),
                      FilledButton(
                        onPressed: () => Navigator.pop(sheetCtx),
                        child: const Text('Schließen'),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          child: const Text('Sheet öffnen'),
        ),
      ),
    );
  }
}
