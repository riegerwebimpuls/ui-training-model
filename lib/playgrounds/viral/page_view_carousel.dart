import 'package:flutter/material.dart';
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
  Axis scrollDirection = Axis.horizontal;
  bool reverse = false;
}

class _PageViewCarouselPlaygroundState extends State<PageViewCarouselPlayground> {
  final _c = _Ctrl();
  late final PageController _pageController;
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
      controller: _c,
      previewHint: 'Seiten wischen',
      bindings: [
        PropertyBinding<double>(
          codeName: 'viewportFraction',
          labelDe: 'Viewport-Anteil',
          helpDe: 'PageController.viewportFraction – sichtbarer Nachbaranteil.',
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
          helpDe: 'PageView.pageSnapping',
          type: PropertyControlType.switcher,
          getValue: () => _c.pageSnapping,
          setValue: (v) => _c.update(() => _c.pageSnapping = v),
        ),
        PropertyBinding<bool>(
          codeName: 'reverse',
          labelDe: 'Umgekehrt',
          helpDe: 'PageView.reverse',
          type: PropertyControlType.switcher,
          getValue: () => _c.reverse,
          setValue: (v) => _c.update(() => _c.reverse = v),
        ),
        PropertyBinding<Axis>(
          codeName: 'scrollDirection',
          labelDe: 'Richtung',
          helpDe: 'PageView.scrollDirection',
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
