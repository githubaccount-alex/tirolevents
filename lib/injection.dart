import 'package:get_it/get_it.dart';
import 'package:tirolevents/02_application/tirolevents/tirolevents_bloc.dart';
import 'package:tirolevents/03_domain/repositories/tirolevent_repository.dart';
import 'package:tirolevents/03_domain/usecases/tirolevents_usecases.dart';
import 'package:http/http.dart' as http;
import '04_infrastructure/datasources/tirolevents_remote_datasource.dart';
import '04_infrastructure/repositories/tirolevents_repository_impl.dart';

final sl = GetIt.I; // service Locator

Future<void> init() async {
  // application layer
  sl.registerFactory(() => TirolEventsBloc(usecases: sl()));

  // Usecases
  sl.registerLazySingleton(
      () => TirolEventsUsecases(tirolEventRepository: sl()));

  // repos
  sl.registerLazySingleton<TirolEventsRepository>(
      () => TirolEventsRepositoryImpl(tirolEventsRemoteDatasource: sl()));

  // datasources
  sl.registerLazySingleton<TirolEventsRemoteDatasource>(
      () => TirolEventsRemoteDatasourceImpl(client: sl()));

  // extern
  sl.registerLazySingleton(() => http.Client());
}
