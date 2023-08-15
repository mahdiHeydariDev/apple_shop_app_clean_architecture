import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app_clean_architecture/config/theme/theme_data.dart';
import 'package:store_app_clean_architecture/config/theme/theme_manager.dart';
import 'package:store_app_clean_architecture/core/bloc/theme/theme_bloc.dart';
import 'package:store_app_clean_architecture/core/bloc/theme/theme_event.dart';
import 'package:store_app_clean_architecture/core/bloc/theme/theme_state.dart';
import 'package:store_app_clean_architecture/core/bloc/theme/theme_status.dart';
import 'package:store_app_clean_architecture/core/widgets/main_wrapper.dart';
import 'package:store_app_clean_architecture/features/store_feature/domain/entity/order_entity.dart';
import 'package:store_app_clean_architecture/service_locator.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(OrderEntityAdapter());
  await Hive.openBox<OrderEntity>('orders');
  await Hive.openBox('themeInfo');
  await initGeiIt();
  runApp(
    const MyApp(),
  );
}

ThemeManager themeManager = ThemeManager();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) {
      var bloc = serviceLocator.get<ThemeBloc>();
      bloc.add(
        ThemeInitEvent(
          brightness:
              SchedulerBinding.instance.platformDispatcher.platformBrightness,
        ),
      );
      return bloc;
    }, child: BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode:
              state.theme is ThemeDarkStatus ? ThemeMode.dark : ThemeMode.light,

          theme: MainTheme.light,
          darkTheme: MainTheme.dark,
          // darkTheme: ThemeData.dark(),
          home: const MainWrapper(),
        );
      },
    ));
  }
}
