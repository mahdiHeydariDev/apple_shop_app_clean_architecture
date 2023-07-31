import 'package:flutter/material.dart';
import 'package:store_app_clean_architecture/config/theme/theme_data.dart';
import 'package:store_app_clean_architecture/core/widgets/main_wrapper.dart';
import 'package:store_app_clean_architecture/service_locator.dart';

void main() async {
  await initGeiIt();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: mainTheme,
      home: const MainWrapper(),
    );
  }
}
