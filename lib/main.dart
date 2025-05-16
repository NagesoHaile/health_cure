import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:health_cure/app.dart';
import 'package:health_cure/core/database/local_storage.dart';
import 'package:health_cure/core/utils/bloc_observer.dart';
import 'package:health_cure/firebase_options.dart';
import 'package:health_cure/service_locator.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await LocalStorage.instance.init();
  await setupServiceLocator();
  Bloc.observer = AppBlocObserver();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: HydratedStorageDirectory(
      (await getTemporaryDirectory()).path,
    ),
  );
  runApp(const App());
}
