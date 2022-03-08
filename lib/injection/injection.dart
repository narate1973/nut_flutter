import 'package:get_it/get_it.dart';
import 'package:nut_flutter/core/app_secure_storage/token_local_database.dart';
import 'package:nut_flutter/features/app/bloc/app_cubit/app_cubit.dart';
import 'package:nut_flutter/features/auth/data/datasources/locals/auth_local_datasource.dart';
import 'package:nut_flutter/features/auth/data/datasources/remotes/auth_api_service.dart';
import 'package:nut_flutter/features/auth/data/datasources/remotes/auth_remote_datasource.dart';
import 'package:nut_flutter/features/auth/data/datasources/remotes/firebase_service.dart';
import 'package:nut_flutter/features/auth/data/repositories/auth_repo.dart';
import 'package:nut_flutter/features/auth/domain/repository/auth_repo.dart';
import 'package:nut_flutter/features/auth/domain/usecase/check_auth.dart';
import 'package:nut_flutter/features/auth/domain/usecase/login.dart';
import 'package:nut_flutter/features/auth/domain/usecase/sigin_out.dart';
import 'package:nut_flutter/features/auth/presentation/bloc/auth_cubit/auth_cubit.dart';
import 'package:nut_flutter/features/auth/presentation/bloc/login_cubit/login_cubit.dart';
import 'package:nut_flutter/features/home/presentation/bloc/home_navigation_cubit/home_navigation_cubit.dart';

final sl = GetIt.I;
Future<void> init() async {
  //! Feature auth
  //bloc
  sl.registerFactory(() => AppCubit());
  sl.registerFactory(() => AuthCubit(appCubit: sl(), checkAuth: sl(), signOut: sl()));
  sl.registerFactory(() => LoginCubit(appCubit: sl(), login: sl()));

  // usecase
  sl.registerLazySingleton(() => SignOut(authRepo: sl()));
  sl.registerLazySingleton(() => Login(authRepo: sl()));
  sl.registerLazySingleton(() => CheckAuth(authRepo: sl()));
  //!  Feature home
  // bloc
  sl.registerFactory(() => HomeNavigationCubit(authRepo: sl()));
  // Repo
  sl.registerLazySingleton<AuthRepo>(
    () => AuthRepoImpl(authLocalDatasource: sl(), authRemoteDatasource: sl()),
  );

  // datasources
  sl.registerLazySingleton<AuthLocalDatasource>(() => AuthLocalDatasourceImpl(tokenDatabase: sl()));
  sl.registerLazySingleton<AuthRemoteDatasource>(
    () => AuthRemoteDatasourceImpl(loginApiService: sl(), firebaseService: sl()),
  );

  // service
  sl.registerLazySingleton<LoginApiService>(() => LoginApiServiceImpl());
  sl.registerLazySingleton<FirebaseService>(() => FirebaseServiceImpl());

  // database
  sl.registerLazySingleton<TokenDatabase>(() => TokenDatabaseImpl());
}
