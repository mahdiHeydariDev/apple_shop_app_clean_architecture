import 'package:store_app_clean_architecture/core/bloc/theme/theme_status.dart';

class ThemeState {
  ThemeStatus theme;
  ThemeState({required this.theme});
  ThemeState changeTheme({required ThemeStatus newTheme}) {
    return ThemeState(theme: newTheme);
  }
}
