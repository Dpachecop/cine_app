//es inmutable, solo lectura
import 'package:cine_app/infraestructure/datasources/actor_moviedb_datasource.dart';
import 'package:cine_app/infraestructure/repository/actor_respository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorRepositoryProvider = Provider(
  (ref) => ActorRespositoryImpl(ActorMovieDbDatasource()),
);
