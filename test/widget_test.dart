import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:servana/main.dart';

void main() {
  testWidgets('App loads without crashing', (WidgetTester tester) async {
    // 🟦 Pump the widget into the widget tree with isFirstTime = true
    await tester.pumpWidget(
      const MyApp(isFirstTime: true), // 👈 استخدم قيم منطقية بدل null
    );

    // 🟢 تحقق من وجود زر "Continue" على الشاشة (يفترض أنه في IntroScreen)
    expect(find.text('Continue'), findsOneWidget);

    // ✅ مثال افتراضي: تحقق من وجود رقم "0"
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // ⏫ اضغط على أيقونة "+"
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // 🔁 تحقق من زيادة العداد إلى 1
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
