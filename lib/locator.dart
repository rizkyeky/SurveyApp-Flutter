import 'package:get_it/get_it.dart';

import 'bloc/bloc.dart';
import 'service/service.dart';

GetIt locator = GetIt.instance;

Future<void> setLocator() async {
  locator.registerLazySingleton(() => ConnectionService());
  locator.registerFactory(() => HomeBloc());

  await locator.get<ConnectionService>().init();
}
