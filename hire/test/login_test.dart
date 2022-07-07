import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_navigation/get_navigation.dart';

import 'package:hire/main.dart';
import 'package:hire/normaluser/home.dart';
import 'package:hire/normaluser/splash.dart';
import 'package:hire/professionals/dashboard.dart';

void main() {
  testWidgets("Login Testing", (WidgetTester tester) async {
    await tester.pumpWidget(GetMaterialApp(home:Splash()));
    expect(find.text("AnimatedSplashScreen"), findsNothing);
  });
}