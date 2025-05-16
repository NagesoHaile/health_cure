import 'package:equatable/equatable.dart';
import 'package:health_cure/core/common/models/app_theme_mode.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends HydratedBloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState.initialState) {
    on<ThemeEvent>((event, emit) async {
      final isCurrentlyLight = state.appTheme == AppThemeMode.light;
      emit(
        state.copyWith(
          appTheme: isCurrentlyLight ? AppThemeMode.dark : AppThemeMode.light,
        ),
      );
    });
  }
  @override
  ThemeState? fromJson(Map<String, dynamic> json) {
    try {
      return ThemeState(appTheme: AppThemeMode.values[json['appTheme'] as int]);
    } catch (_) {
      return ThemeState.initialState;
    }
  }

  @override
  Map<String, dynamic>? toJson(ThemeState state) {
    return {'appTheme': state.appTheme.index};
  }
}
