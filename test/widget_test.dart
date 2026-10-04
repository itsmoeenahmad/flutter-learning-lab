import 'package:flutter_test/flutter_test.dart';
import 'package:flutterlearning/main.dart';

void main() {
  testWidgets('shows the learning hub', (tester) async {
    await tester.pumpWidget(const FlutterLearningApp());

    expect(find.text('Flutter Learning Lab'), findsOneWidget);
    expect(find.text('Week 04'), findsOneWidget);
    expect(find.text('Week 07'), findsOneWidget);
  });
}
