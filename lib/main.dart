import 'package:flutter/material.dart';
import 'package:store_app_clean_architecture/config/theme/theme_data.dart';
import 'package:store_app_clean_architecture/core/widgets/main_wrapper.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/entity/order_entity.dart';
import 'package:store_app_clean_architecture/service_locator.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(OrderEntityAdapter());
  await Hive.openBox<OrderEntity>('orders');
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
