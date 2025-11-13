import 'package:get_it/get_it.dart';
import '../features/auth/data/repositories/auth_repository_impl.dart';
import '../features/auth/domain/repositories/auth_repository.dart';

final sl = GetIt.instance; // service locator

Future<void> initDependencies() async {
  // repositories
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl());

  // you can also register viewmodels, usecases, etc.
}
