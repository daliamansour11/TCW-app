import 'package:flutter_modular/flutter_modular.dart';
import 'package:tcw/features/auth/data/datasources/auth_local_datasource_impl.dart';
import 'package:tcw/features/auth/data/datasources/auth_remote_datasource_impl.dart';
import 'package:tcw/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:tcw/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:tcw/features/reels/data/repositories/reel_repository_imp.dart';
import 'package:tcw/features/reels/presentation/cubit/reels_cubit.dart';

final List<Bind<Object>> modularBinds = <Bind<Object>>[
  Bind.lazySingleton((i) => AuthCubit(
    AuthRepositoryImpl(
      AuthRemoteDatasourceImpl(),
      AuthLocalDatasourceImpl(),
    ),
  )),

  Bind.lazySingleton((i) => ReelsCubit(
    ReelRepositoryImpl(),
  )),

];