import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_training_model/core/controls/controls.dart';
import 'package:ui_training_model/core/property_binding.dart';
import 'package:ui_training_model/widgets/card_stack_demo.dart';

void main() {
  testWidgets('enum binding via PropertyBinding<dynamic> updates value',
      (tester) async {
    var value = CardDismissOrientation.up;
    final PropertyBinding<dynamic> binding =
        PropertyBinding<CardDismissOrientation>(
      codeName: 'dismissOrientation',
      labelDe: 'Dismiss-Richtung',
      helpDe: 'help',
      useCaseDe: 'use',
      type: PropertyControlType.enumeration,
      enumValues: CardDismissOrientation.values,
      enumLabels: const ['up', 'down', 'left', 'right'],
      getValue: () => value,
      setValue: (v) => value = v,
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: buildControlFor(binding)),
      ),
    );

    await tester.tap(find.byType(DropdownButtonFormField<dynamic>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('right').last);
    await tester.pumpAndSettle();
    expect(value, CardDismissOrientation.right);
  });

  testWidgets('swipeOrientation horizontal only moves on dx', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SizedBox(
            width: 400,
            height: 700,
            child: CardStackDemo(
              borderRadius: 16,
              positionFactor: 1.5,
              scaleFactor: 0.92,
              reverseOrder: false,
              opacityOnDrag: false,
              dismissOrientation: CardDismissOrientation.left,
              swipeOrientation: CardSwipeOrientation.horizontal,
            ),
          ),
        ),
      ),
    );

    final front = find.byType(GestureDetector).last;
    final start = tester.getTopLeft(front);
    final gesture = await tester.startGesture(tester.getCenter(front));
    await gesture.moveBy(const Offset(-150, -80));
    await tester.pump();
    final mid = tester.getTopLeft(front);
    // Vertical component of the pan must be ignored.
    expect(mid.dy, moreOrLessEquals(start.dy, epsilon: 0.5));
    expect(mid.dx, lessThan(start.dx - 50));
    await gesture.up();
    await tester.pumpAndSettle();
    // Dismissed left → front card rotates; original "4" no longer sole front.
    expect(find.text('4'), findsWidgets);
  });

  testWidgets('dismiss down works with vertical swipe', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SizedBox(
            width: 400,
            height: 700,
            child: CardStackDemo(
              borderRadius: 16,
              positionFactor: 1.5,
              scaleFactor: 0.92,
              reverseOrder: false,
              opacityOnDrag: false,
              dismissOrientation: CardDismissOrientation.down,
              swipeOrientation: CardSwipeOrientation.vertical,
            ),
          ),
        ),
      ),
    );

    final front = find.byType(GestureDetector).last;
    final gesture = await tester.startGesture(tester.getCenter(front));
    await gesture.moveBy(const Offset(0, 180));
    await gesture.up();
    await tester.pumpAndSettle();
    // After dismiss, card 4 is moved to back; card 3 becomes front.
    expect(find.text('3'), findsWidgets);
  });
}
