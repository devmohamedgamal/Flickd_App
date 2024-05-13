// Packages
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

//Helepers
import '../core/utils/assets_manger.dart';
import 'dart:convert';

//Services
import '../services/http_service.dart';
import '../services/movie_service.dart';

// models
import '../models/config.dart';

class SplashPage extends StatefulWidget {
  final VoidCallback onInitializationComplete;
  const SplashPage({super.key, required this.onInitializationComplete})
      : super();

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1)).then(
      (_) => _setup(context).then(
        (_) => widget.onInitializationComplete(),
      ),
    );
  }

  Future<void> _setup(BuildContext context) async {
    final getIt = GetIt.instance;
    final configFile = await rootBundle.loadString('assets/config/main.json');
    final configData = jsonDecode(configFile);

    getIt.registerSingleton<AppConfig>(AppConfig(
      API_KEY: configData['API_KEY'],
      BASE_API_URL: configData['BASE_API_URL'],
      BASE_IMAGE_API_URL: configData['BASE_IMAGE_API_URL'],
    ));

    getIt.registerSingleton<HttpService>(
      HttpService(),
    );

    getIt.registerSingleton<MovieServics>(
      MovieServics(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Flickd",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Center(
        child: Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AssetsManger.logo),
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
