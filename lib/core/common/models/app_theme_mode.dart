enum AppThemeMode {
  light,
  dark,
  system;

  String toJson() {
    switch (this) {
      case AppThemeMode.light:
        return 'LIGHT';
      case AppThemeMode.dark:
        return 'DARK';
      case AppThemeMode.system:
        return 'SYSTEM';
    }
  }

  static AppThemeMode fromJson(String? appTheme) {
    switch (appTheme) {
      case 'LIGHT':
        return AppThemeMode.light;
      case 'DARK':
        return AppThemeMode.dark;
      case 'SYSTEM':
      default:
        return AppThemeMode.system;
    }
  }
}
