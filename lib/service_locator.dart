
import 'package:get_it/get_it.dart';
import 'package:health_cure/features/authentication/services/authentication_service.dart';
import 'package:health_cure/features/authentication/authentication_bloc/authentication_bloc.dart';
final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  sl.registerLazySingleton<AuthenticationService>(() => AuthenticationService());
  sl.registerLazySingleton<AuthenticationBloc>(() => AuthenticationBloc(sl()));
}