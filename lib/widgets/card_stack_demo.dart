import 'dart:math' as math;

import 'package:flutter/material.dart';

enum CardDismissOrientation { up, down, left, right }

enum CardSwipeOrientation { vertical, horizontal, free }

/// Interaktiver Card-Stack (Screenshot-Vorbild) — live wischbar.
class CardStackDemo extends StatefulWidget {
  const CardStackDemo({
    super.key,
    required this.borderRadius,
    required this.positionFactor,
    required this.scaleFactor,
    required this.reverseOrder,
    required this.opacityOnDrag,
    required this.dismissOrientation,
    required this.swipeOrientation,
  });

  final double borderRadius;
  final double positionFactor;
  final double scaleFactor;
  final bool reverseOrder;
  final bool opacityOnDrag;
  final CardDismissOrientation dismissOrientation;
  final CardSwipeOrientation swipeOrientation;

  @override
  State<CardStackDemo> createState() => _CardStackDemoState();
}

class _CardStackDemoState extends State<CardStackDemo>
    with SingleTickerProviderStateMixin {
  static const _colors = <Color>[
    Color(0xFFE53935),
    Color(0xFF43A047),
    Color(0xFFFFFFFF),
    Color(0xFF9E9E9E),
    Color(0xFFFDD835),
  ];

  late List<int> _order;
  Offset _drag = Offset.zero;
  late AnimationController _snap;

  /// Index in [_order] der visuell vordersten Karte.
  int get _frontOrderIndex =>
      widget.reverseOrder ? 0 : _order.length - 1;

  @override
  void initState() {
    super.initState();
    _order = List.generate(_colors.length, (i) => i);
    _snap = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 220),
    )..addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _snap.dispose();
    super.dispose();
  }

  void _onDragUpdate(DragUpdateDetails d) {
    setState(() {
      switch (widget.swipeOrientation) {
        case CardSwipeOrientation.vertical:
          _drag += Offset(0, d.delta.dy);
        case CardSwipeOrientation.horizontal:
          _drag += Offset(d.delta.dx, 0);
        case CardSwipeOrientation.free:
          _drag += d.delta;
      }
    });
  }

  void _onDragEnd(DragEndDetails d) {
    const threshold = 120.0;
    final dismissed = switch (widget.dismissOrientation) {
      CardDismissOrientation.up => _drag.dy < -threshold,
      CardDismissOrientation.down => _drag.dy > threshold,
      CardDismissOrientation.left => _drag.dx < -threshold,
      CardDismissOrientation.right => _drag.dx > threshold,
    };

    if (dismissed) {
      setState(() {
        final front = _order.removeAt(_frontOrderIndex);
        if (widget.reverseOrder) {
          _order.add(front);
        } else {
          _order.insert(0, front);
        }
        _drag = Offset.zero;
      });
    } else {
      final from = _drag;
      _snap
        ..reset()
        ..forward().then((_) {
          if (mounted) setState(() => _drag = Offset.zero);
        });
      void tick() {
        if (!_snap.isAnimating) return;
        setState(() {
          _drag = Offset.lerp(
            from,
            Offset.zero,
            Curves.easeOut.transform(_snap.value),
          )!;
        });
      }

      _snap.removeListener(tick);
      _snap.addListener(tick);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Paint: hinten → vorne. Front = letzte Position im Stack.
    final paintOrder = widget.reverseOrder
        ? _order.reversed.toList()
        : List<int>.from(_order);

    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth * 0.78;
        final h = constraints.maxHeight * 0.62;
        final baseTop = (constraints.maxHeight - h) / 2 + 24;
        final baseLeft = (constraints.maxWidth - w) / 2;

        return Stack(
          clipBehavior: Clip.none,
          children: [
            for (var depth = 0; depth < paintOrder.length; depth++)
              _buildCard(
                indexLabel: paintOrder[depth],
                color: _colors[paintOrder[depth] % _colors.length],
                depth: depth,
                isFront: depth == paintOrder.length - 1,
                width: w,
                height: h,
                baseTop: baseTop,
                baseLeft: baseLeft,
              ),
          ],
        );
      },
    );
  }

  Widget _buildCard({
    required int indexLabel,
    required Color color,
    required int depth,
    required bool isFront,
    required double width,
    required double height,
    required double baseTop,
    required double baseLeft,
  }) {
    final fromFront = (_order.length - 1) - depth;
    // scaleFactor < 1 → hintere Karten kleiner; clamp verhindert „größer hinten“.
    final scale =
        math.pow(widget.scaleFactor.clamp(0.5, 1.0), fromFront).toDouble();
    final yOffset = -fromFront * 14.0 * widget.positionFactor;

    var dx = 0.0;
    var dy = yOffset;
    var opacity = 1.0;

    if (isFront) {
      dx += _drag.dx;
      dy += _drag.dy;
      if (widget.opacityOnDrag) {
        final distance = _drag.distance;
        opacity = (1.0 - distance / 280).clamp(0.35, 1.0);
      }
    }

    final card = Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(widget.borderRadius),
        border: Border.all(color: Colors.black12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.only(top: 10),
      child: Text(
        '$indexLabel',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: color.computeLuminance() > 0.55 ? Colors.black87 : Colors.white,
        ),
      ),
    );

    if (!isFront) {
      return Positioned(
        top: baseTop + dy,
        left: baseLeft + dx + (width * (1 - scale) / 2),
        child: Opacity(
          opacity: opacity,
          child: Transform.scale(
            scale: scale,
            alignment: Alignment.topCenter,
            child: card,
          ),
        ),
      );
    }

    return Positioned(
      top: baseTop + dy,
      left: baseLeft + dx + (width * (1 - scale) / 2),
      child: GestureDetector(
        onPanUpdate: _onDragUpdate,
        onPanEnd: _onDragEnd,
        child: Opacity(
          opacity: opacity,
          child: Transform.scale(
            scale: scale,
            alignment: Alignment.topCenter,
            child: card,
          ),
        ),
      ),
    );
  }
}
