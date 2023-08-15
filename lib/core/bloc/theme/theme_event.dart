import 'package:flutter/material.dart';

class ThemeEvent {}

class ThemeInitEvent extends ThemeEvent {
  final Brightness brightness;
  ThemeInitEvent({required this.brightness});
}

class ThemeChangeEvent extends ThemeEvent {}
