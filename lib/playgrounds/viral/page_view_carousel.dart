import 'package:flutter/material.dart';
import 'package:ui_training_model/catalog/widget_module.dart';
import 'package:ui_training_model/core/playground_shell.dart';
import 'package:ui_training_model/core/property_binding.dart';

class PageViewCarouselPlayground extends StatefulWidget {
  const PageViewCarouselPlayground({super.key});

  @override
  State<PageViewCarouselPlayground> createState() =>
      _PageViewCarouselPlaygroundState();
}

class _Ctrl extends PlaygroundController {
  double viewportFraction = 0.85;
  bool pageSnapping = true;
  bool padEnds = true;
  Axis scrollDirection = Axis.horizontal;
  bool reverse = false;
}

class _PageViewCarouselPlaygroundState extends State<PageViewCarouselPlayground> {
  final _c = _Ctrl();
  late PageController _pageController;
  int _page = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: _c.viewportFraction);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _c.dispose();
    super.dispose();
  }

  void _rebuildController() {
    final old = _pageController.page ?? 0;
    _pageController.dispose();
    _pageController = PageController(
      viewportFraction: _c.viewportFraction,
      initialPage: old.round(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = [
      Colors.teal,
      Colors.orange,
      Colors.indigo,
      Colors.pink,
      Colors.blueGrey,
    ];
    return PlaygroundShell(
      title: 'PageView Carousel',
      description: 'Horizontales/vertikales PageView mit viewportFraction.',
      moduleId: 'page-view',
      explanationDe:
          'PageView zeigt eine Seite nach der anderen und reagiert auf Wischgesten. '
          'Mit viewportFraction sieht man einen Ausschnitt der Nachbarseite – '
          'typisch für Karussells und Onboarding.',
      useCaseDe:
          'Karussells, Bildergalerien, Onboarding-Slides und TikTok-ähnliche '
          'Vollbild-Feeds mit horizontalem oder vertikalem Blättern.',
      faq: const [
        ModuleFaq(
          question: 'Warum muss der PageController neu erstellt werden?',
          answer:
              'viewportFraction wird beim PageController gesetzt. Ändert sich der '
              'Wert, braucht Flutter einen neuen Controller mit der neuen Fraction.',
        ),
        ModuleFaq(
          question: 'Was bewirkt padEnds?',
          answer:
              'padEnds fügt am Anfang und Ende des PageView Innenabstand ein, '
              'damit die erste und letzte Seite zentriert wirken können.',
        ),
      ],
      controller: _c,
      previewHint: 'Seiten wischen',
      bindings: [
        PropertyBinding<double>(
          codeName: 'viewportFraction',
          labelDe: 'Viewport-Anteil',
          helpDe: 'PageController.viewportFraction – sichtbarer Nachbaranteil.',
          useCaseDe:
              'Karussell-Effekt: 0,85 zeigt ~15 % der Nachbarseite (App-Store-Stil).',
          type: PropertyControlType.slider,
          min: 0.5,
          max: 1.0,
          divisions: 10,
          getValue: () => _c.viewportFraction,
          setValue: (v) => _c.update(() {
            _c.viewportFraction = v;
            _rebuildController();
          }),
        ),
        PropertyBinding<bool>(
          codeName: 'pageSnapping',
          labelDe: 'Page Snapping',
          helpDe: 'PageView.pageSnapping – Einrasten auf ganzen Seiten.',
          useCaseDe:
              'Snapping aktiv lassen für klares Blättern; aus für freies Scrollen.',
          type: PropertyControlType.switcher,
          getValue: () => _c.pageSnapping,
          setValue: (v) => _c.update(() => _c.pageSnapping = v),
        ),
        PropertyBinding<bool>(
          codeName: 'padEnds',
          labelDe: 'Pad Ends',
          helpDe: 'PageView.padEnds – Abstand vor erster und nach letzter Seite.',
          useCaseDe:
              'Bei viewportFraction < 1 oft true, damit die aktive Seite mittig sitzt.',
          type: PropertyControlType.switcher,
          getValue: () => _c.padEnds,
          setValue: (v) => _c.update(() => _c.padEnds = v),
        ),
        PropertyBinding<bool>(
          codeName: 'reverse',
          labelDe: 'Umgekehrt',
          helpDe: 'PageView.reverse – Scrollrichtung invertieren.',
          useCaseDe:
              'Für RTL-Layouts oder wenn die logische Reihenfolge umgekehrt sein soll.',
          type: PropertyControlType.switcher,
          getValue: () => _c.reverse,
          setValue: (v) => _c.update(() => _c.reverse = v),
        ),
        PropertyBinding<Axis>(
          codeName: 'scrollDirection',
          labelDe: 'Richtung',
          helpDe: 'PageView.scrollDirection – horizontal oder vertikal.',
          useCaseDe:
              'Horizontal für Galerien; vertikal für Stories/Reels-Feeds.',
          type: PropertyControlType.enumeration,
          enumValues: Axis.values,
          enumLabels: const ['horizontal', 'vertical'],
          getValue: () => _c.scrollDirection,
          setValue: (v) => _c.update(() => _c.scrollDirection = v),
        ),
      ],
      previewBuilder: (_) => Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              pageSnapping: _c.pageSnapping,
              padEnds: _c.padEnds,
              reverse: _c.reverse,
              scrollDirection: _c.scrollDirection,
              itemCount: colors.length,
              onPageChanged: (i) => setState(() => _page = i),
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(12),
                child: Material(
                  color: colors[index],
                  borderRadius: BorderRadius.circular(16),
                  child: Center(
                    child: Text(
                      'Seite $index',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text('Seite $_page / ${colors.length - 1}'),
          ),
        ],
      ),
    );
  }
}
