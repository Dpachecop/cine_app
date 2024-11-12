import 'package:cine_app/infraestructure/datasources/moviedb_datasource.dart';
import 'package:cine_app/infraestructure/repository/movie_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//es inmutable, solo lectura
final movieRepositoryProvider = Provider(
  (ref) => MovieRepositoryImpl(MoviedbDatasource()),
);
