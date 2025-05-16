part of 'theme_bloc.dart';

class ThemeState extends Equatable {
  final AppThemeMode appTheme;

  const ThemeState({required this.appTheme});
  static const initialState = ThemeState(appTheme: AppThemeMode.light);
  @override
  List<Object?> get props => [appTheme];

  ThemeState copyWith({AppThemeMode? appTheme}) {
    return ThemeState(appTheme: appTheme ?? this.appTheme);
  }
}
