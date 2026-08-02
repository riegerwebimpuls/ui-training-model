import 'package:flutter/material.dart';
import 'package:ui_training_model/catalog/widget_module.dart';
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
  bool isDismissible = true;
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

  Widget _sheetContent(BuildContext sheetCtx) {
    return SizedBox(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlaygroundShell(
      title: 'Modal Bottom Sheet',
      description: 'showModalBottomSheet mit Drag-Handle und Radius.',
      moduleId: 'bottom-sheet',
      explanationDe:
          'Bottom Sheets schieben sich von unten ins Bild und überlagern den '
          'Hintergrund modal. Drag-Handle, Radius und isDismissible steuern '
          'Look und Schließverhalten.',
      useCaseDe:
          'Filter, Teilen-Menüs, Kurzformulare und Aktionen, die den '
          'Hauptinhalt nicht vollständig verlassen.',
      faq: const [
        ModuleFaq(
          question: 'Wann isScrollControlled setzen?',
          answer:
              'Bei isScrollControlled: true kann das Sheet fast die volle '
              'Höhe nutzen – z. B. für lange Listen oder komplexe Formulare.',
        ),
        ModuleFaq(
          question: 'Was passiert bei isDismissible: false?',
          answer:
              'Tippen auf den abgedunkelten Bereich schließt das Sheet nicht. '
              'Der Nutzer muss explizit schließen (Button oder Drag).',
        ),
      ],
      controller: _c,
      previewHint: 'Button tippt Sheet im Phone-Frame',
      bindings: [
        PropertyBinding<bool>(
          codeName: 'isScrollControlled',
          labelDe: 'Scroll-kontrolliert',
          helpDe: 'Erlaubt höhere Sheets (isScrollControlled).',
          useCaseDe:
              'Für hohe Inhalte aktivieren; sonst reicht die Standard-Höhe.',
          type: PropertyControlType.switcher,
          getValue: () => _c.isScrollControlled,
          setValue: (v) => _c.update(() => _c.isScrollControlled = v),
        ),
        PropertyBinding<bool>(
          codeName: 'enableDrag',
          labelDe: 'Ziehen erlauben',
          helpDe: 'enableDrag – Sheet per Geste nach unten schließen.',
          useCaseDe:
              'Standardmäßig an – Nutzer erwarten Wisch-zu-Schließen bei Sheets.',
          type: PropertyControlType.switcher,
          getValue: () => _c.enableDrag,
          setValue: (v) => _c.update(() => _c.enableDrag = v),
        ),
        PropertyBinding<bool>(
          codeName: 'isDismissible',
          labelDe: 'Schließbar (Barrier)',
          helpDe: 'Tipp auf den Hintergrund schließt das Sheet.',
          useCaseDe:
              'false bei Pflicht-Aktionen; true für optionale Menüs und Filter.',
          type: PropertyControlType.switcher,
          getValue: () => _c.isDismissible,
          setValue: (v) => _c.update(() => _c.isDismissible = v),
        ),
        PropertyBinding<bool>(
          codeName: 'showDragHandle',
          labelDe: 'Drag-Handle',
          helpDe: 'showDragHandle – Griffleiste oben am Sheet.',
          useCaseDe:
              'Visueller Hinweis auf Zieh-Geste; Standard in Material 3.',
          type: PropertyControlType.switcher,
          getValue: () => _c.showDragHandle,
          setValue: (v) => _c.update(() => _c.showDragHandle = v),
        ),
        PropertyBinding<double>(
          codeName: 'shape.borderRadius',
          labelDe: 'Eckenradius',
          helpDe: 'Obere Ecken des Sheets (shape).',
          useCaseDe:
              '16–28 px für abgerundete Sheet-Kanten; 0 für kantigen Look.',
          type: PropertyControlType.slider,
          min: 0,
          max: 32,
          divisions: 32,
          getValue: () => _c.borderRadius,
          setValue: (v) => _c.update(() => _c.borderRadius = v),
        ),
      ],
      previewBuilder: (ctx) => Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Center(
                child: FilledButton(
                  onPressed: () {
                    showModalBottomSheet<void>(
                      context: ctx,
                      isScrollControlled: _c.isScrollControlled,
                      enableDrag: _c.enableDrag,
                      isDismissible: _c.isDismissible,
                      showDragHandle: _c.showDragHandle,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(_c.borderRadius),
                        ),
                      ),
                      builder: _sheetContent,
                    );
                  },
                  child: const Text('Sheet öffnen'),
                ),
              ),
            ),
            _LiveSheetStrip(
              borderRadius: _c.borderRadius,
              showDragHandle: _c.showDragHandle,
            ),
          ],
        ),
      ),
    );
  }
}

/// Statische Vorschau von Radius und Handle – ohne Modal.
class _LiveSheetStrip extends StatelessWidget {
  const _LiveSheetStrip({
    required this.borderRadius,
    required this.showDragHandle,
  });

  final double borderRadius;
  final bool showDragHandle;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Material(
      elevation: 8,
      color: scheme.surfaceContainerHigh,
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(borderRadius),
      ),
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        height: 72,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (showDragHandle)
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  color: scheme.onSurfaceVariant.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            Text(
              'Live-Vorschau: Radius ${borderRadius.toStringAsFixed(0)}',
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ],
        ),
      ),
    );
  }
}
