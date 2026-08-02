import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui_training_model/app.dart';

void main() {
  testWidgets('Catalog loads', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: UiTrainingApp()),
    );
    await tester.pumpAndSettle();
    expect(find.text('UI Training Lab'), findsOneWidget);
    expect(find.textContaining('Container'), findsWidgets);
  });
}
