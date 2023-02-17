import 'package:mockito_delivery_app/src/utils/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'counter_page.dart';

void main() {
  testWidgets("Counter page Test's", (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: const CounterPage(),
      theme: ThemeData(
        textTheme: MyFontStyles.textTheme,
      ),
    ));
    expect(find.text("0"), findsOneWidget);

    /// TODO .byType usa solo el primer widget
    ///  que enuentre del tipo designado
    // final button2 = find.byType(TextButton);
    final button = find.byKey(const Key('add'));
    await tester.tap(button);

    /// TODO .pump permite simular que la funcion
    ///  del SetState ya fue renderizada y viaja
    ///  a la siguiente iteracion del test
    await tester.pump();
    expect(find.text("1"), findsOneWidget);
    await tester.tap(button);
    await tester.tap(button);
    await tester.tap(button);
    await tester.pump();
    expect(find.text("4"), findsOneWidget);
  });
}
