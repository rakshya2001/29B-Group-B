import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hire/normaluser/professsional.dart';

void main() {
  testWidgets("Avaliable Professional ", (WidgetTester tester) async {
    await tester.pumpWidget(professional());
    expect(find.byType(Scaffold), findsNWidgets(2));
  });
}
