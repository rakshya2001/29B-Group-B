import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire/normaluser/dashboard.dart';
import 'package:hire/normaluser/home.dart';
import 'package:hire/normaluser/login.dart';
import 'package:khalti/khalti.dart';
import 'package:khalti_flutter/khalti_flutter.dart';


import 'package:provider/provider.dart';

import 'controllers/google_signin.dart';
import 'controllers/login_controller.dart';
import 'normaluser/splash.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => GoogleSignInController(),
      child: KhaltiScope(
          publicKey: "test_public_key_cdeb2e8c6a9a43c68a8c4b9a40ee8e96",
          builder: (context, navigatorKey) {
            return GetMaterialApp(
               navigatorKey: navigatorKey,
            supportedLocales: const [
              Locale('en', 'US'),
              Locale('ne', 'NP'),
            ],
            localizationsDelegates: const [
              KhaltiLocalizations.delegate,
            ],
              title: 'Flutter Demo',
              theme: ThemeData(
              
                primarySwatch: Colors.green,
              ),
              home: Splash(),
            );
          }));
}
