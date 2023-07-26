import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app_clean_architecture/config/theme/theme_data.dart';
import 'package:store_app_clean_architecture/features/store_feature/presentation/bloc/home/home_bloc.dart';
import 'package:store_app_clean_architecture/features/store_feature/presentation/screens/categories_screen.dart';
import 'package:store_app_clean_architecture/features/store_feature/presentation/screens/detail_product_screen.dart';
import 'package:store_app_clean_architecture/features/store_feature/presentation/screens/home_screen.dart';
import 'package:store_app_clean_architecture/features/store_feature/presentation/screens/products_by_category_screen.dart';
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
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: BlocProvider(
          create: (context) => serviceLocator.get<HomeBloc>(),
          child: const HomeScreen(),
        ),
      ),
    );
  }
}
