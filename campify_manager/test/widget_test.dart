import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:campify_manager/main.dart';

void main() {
  testWidgets('CampifyManagerApp renders', (WidgetTester tester) async {
    // Build our app with ProviderScope and trigger a frame.
    await tester.pumpWidget(
      const ProviderScope(
        child: CampifyManagerApp(),
      ),
    );

    // Verify that the app renders (login screen should appear initially)
    await tester.pumpAndSettle();

    // Basic smoke test - app should render without errors
    expect(find.byType(CampifyManagerApp), findsOneWidget);
  });
}
