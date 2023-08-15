import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:store_app_clean_architecture/core/bloc/theme/theme_event.dart';
import 'package:store_app_clean_architecture/core/bloc/theme/theme_state.dart';
import 'package:store_app_clean_architecture/core/bloc/theme/theme_status.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  var themeBox = Hive.box('themeInfo');
  ThemeBloc()
      : super(
          ThemeState(
            theme: ThemeLightStatus(),
          ),
        ) {
    on<ThemeInitEvent>((event, emit) {
      if (event.brightness == Brightness.dark) {
        themeBox.put('theme', 'dark');
      } else {
        themeBox.put('theme', 'light');
      }
      var themeInfo = themeBox.get('theme');
      if (themeInfo == 'dark') {
        emit(
          state.changeTheme(
            newTheme: ThemeDarkStatus(),
          ),
        );
      } else {
        emit(
          state.changeTheme(
            newTheme: ThemeLightStatus(),
          ),
        );
      }
    });
    on<ThemeChangeEvent>((event, emit) {
      var themeInfo = themeBox.get('theme');
      if (themeInfo == 'dark') {
        themeBox.put('theme', 'light');
        emit(
          state.changeTheme(
            newTheme: ThemeLightStatus(),
          ),
        );
      } else {
        themeBox.put('theme', 'dark');
        emit(
          state.changeTheme(
            newTheme: ThemeDarkStatus(),
          ),
        );
      }
    });
  }
}
