import 'package:get_it/get_it.dart';

import 'bloc/bloc.dart';
import 'service/service.dart';

GetIt locator = GetIt.instance;

Future<void> setLocator() async {
  locator.registerLazySingleton(() => ConnectionService());
  locator.registerLazySingleton(() => FirebaseService());
  
  locator.registerFactory(() => HomeBloc());
  locator.registerFactory(() => QuestionBloc());

  await locator.get<ConnectionService>().init();
  await locator.get<FirebaseService>().init();
  
}
