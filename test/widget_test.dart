import 'package:flutter_test/flutter_test.dart';

import 'package:fill_n_admin/main.dart';

void main() {
  testWidgets('App builds onboarding screen', (WidgetTester tester) async {
    await tester.pumpWidget(const FillNAdminApp());
    await tester.pump();
    expect(find.text('Manage Your Platform'), findsOneWidget);
  });
}
