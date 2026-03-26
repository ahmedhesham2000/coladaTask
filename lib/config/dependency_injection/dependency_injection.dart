import 'package:coladatask/core/network/dio_helper.dart';
import 'package:coladatask/features/menu/data/datasources/menu_remote_data_source.dart';
import 'package:coladatask/features/menu/data/repositories/menu_repository_impl.dart';
import 'package:coladatask/features/menu/domain/repositories/menu_repository.dart';
import 'package:coladatask/features/menu/domain/usecases/get_catalog_usecase.dart';
import 'package:coladatask/features/menu/domain/usecases/get_venue_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance; // sl = service locator

Future<void> initDependencyInjection() async {
  try {
    await registerCoreDependencies();
    await registerDataSources();
    await registerRepositories();
    await registerUseCases();
    await registerProviders();
  } catch (e) {
    rethrow;
  }
}

Future<void> registerCoreDependencies() async {
  // Core services
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  // Network services
  sl.registerLazySingleton<NetworkService>(NetworkService.new);

  // Register network connectivity service as singleton
  // sl.registerLazySingleton<NetworkConnectivityService>(
  //   () => NetworkConnectivityService(),
  // );
}

// DATA SOURCES
Future<void> registerDataSources() async {
  sl.registerLazySingleton<MenuRemoteDataSource>(
    () => MenuRemoteDataSourceImpl(sl<NetworkService>()),
  );
}

// USECASES
Future<void> registerUseCases() async {
  /// Fetch Users Use case
  sl.registerLazySingleton<GetVenueUseCase>(
    () => GetVenueUseCase(sl<MenuRepository>()),
  );
  sl.registerLazySingleton<GetCatalogUseCase>(
    () => GetCatalogUseCase(sl<MenuRepository>()),
  );
}

// REPOSITORIES
Future<void> registerRepositories() async {
  sl.registerLazySingleton<MenuRepository>(
    () => MenuRepositoryImpl(sl<MenuRemoteDataSource>()),
  );
}

// Providers
Future<void> registerProviders() async {}
