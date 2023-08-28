import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:tirolevents/02_application/tiroleventsformbloc/tiroleventsform_bloc.dart';
import 'package:tirolevents/03_domain/repositories/tirolevent_repository.dart';

import 'package:http/http.dart' as http;
import '02_application/authbloc/authbloc/auth_bloc.dart';
import '02_application/authbloc/signupformbloc/signupform_bloc.dart';
import '02_application/tiroleventsbloc/tirolevents_bloc.dart';
import '03_domain/repositories/auth_repository.dart';
import '03_domain/services/tirolevents_service.dart';
import '04_infrastructure/datasources/tirolevents_remote_datasource.dart';
import '04_infrastructure/repositories/auth_repository_impl.dart';
import '04_infrastructure/repositories/tirolevents_repository_impl.dart';

final sl = GetIt.I; // service Locator

Future<void> init() async {
  //? ################ auth ##################
  //! state management
  sl.registerFactory(() => SignupformBloc(authRepository: sl()));
  sl.registerFactory(() => AuthBloc(authRepository: sl()));

  //! repos
  sl.registerLazySingleton<AuthRepository>(
          () => AuthRepositoryImpl(firebaseAuth: sl()));

  //! extern
  final friebaseAuth = FirebaseAuth.instance;
  sl.registerLazySingleton(() => friebaseAuth);



  //? ################ tirolevent ##################
  // application layer
  sl.registerFactory(() => TirolEventsBloc(service: sl()));
  sl.registerFactory(() => TirolEventsFormBloc(tirolEventsRepository: sl()));


  // Service
  sl.registerLazySingleton(
      () => TirolEventsService(tirolEventRepository: sl()));

  // repos
  sl.registerLazySingleton<TirolEventsRepository>(
      () => TirolEventsRepositoryImpl(tirolEventsRemoteDatasource: sl(), firebaseFirestore: sl()));

  // datasources
  sl.registerLazySingleton<TirolEventsRemoteDatasource>(
      () => TirolEventsRemoteDatasourceImpl(client: sl()));

  // extern
  final firestore = FirebaseFirestore.instance;
  sl.registerLazySingleton(() => firestore);
  sl.registerLazySingleton(() => http.Client());
}
