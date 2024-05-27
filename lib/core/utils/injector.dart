import 'package:get_it/get_it.dart';
import '../providers/auth_provider.dart';
import '../providers/radio_provider.dart';

final injector = GetIt.instance;

Future<void> initializeDependencies() async {
  injector.registerLazySingleton(() => AuthProvider());
  injector.registerFactory(() => RadioProvider());
}
