import 'package:cine_app/infraestructure/datasources/isar_datasurce.dart';
import 'package:cine_app/infraestructure/repository/local_storage_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localStorageRepositoryProvider = Provider(
  (ref) => LocalStorageImpl(IsarDatasurce()),
);
