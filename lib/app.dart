import 'package:flutter/material.dart';
import 'package:health_cure/config/route/app_router.dart';
import 'package:health_cure/config/theme/app_theme.dart';
import 'package:health_cure/core/common/models/app_theme_mode.dart';
import 'package:health_cure/core/common/theme_bloc/theme_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_cure/features/authentication/authentication_bloc/authentication_bloc.dart';
import 'package:health_cure/features/authentication/services/authentication_service.dart';
import 'package:health_cure/features/home/blocs/therapy_bloc/therapy_bloc.dart';
import 'package:health_cure/features/home/blocs/treatment_bloc/treatment_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeBloc()),
        BlocProvider(create: (context) => AuthenticationBloc(AuthenticationService())),
        BlocProvider(create: (context) => TherapyBloc()),
        BlocProvider(create: (context) => TreatmentBloc()),
      ],
      child: Builder(
        builder: (context) {
          return BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              return MaterialApp.router(
                routerConfig: router,
                theme: AppTheme.lightTheme,
                themeMode:
                    state.appTheme == AppThemeMode.light
                        ? ThemeMode.light
                        : state.appTheme == AppThemeMode.dark
                        ? ThemeMode.dark
                        : ThemeMode.system,
                darkTheme: AppTheme.darkTheme,
                debugShowCheckedModeBanner: false,
                title: 'Health Cure',
              );
            },
          );
        },
      ),
    );
  }
}
