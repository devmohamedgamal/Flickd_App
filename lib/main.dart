// Pages
import 'package:flickd_app/pages/main_page.dart';
import 'package:flickd_app/pages/splash_page.dart';

// Packages
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(SplashPage(
    key: UniqueKey(),
    onInitializationComplete: () => runApp(const ProviderScope(child: MyApp())),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flickd',
      initialRoute: 'home',
      routes: {
        'home': (BuildContext context) => MainPage(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
