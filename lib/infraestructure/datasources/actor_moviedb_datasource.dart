import 'package:cine_app/config/constants/themoviedbkey.dart';
import 'package:cine_app/domain/datasources/actors_datasource.dart';
import 'package:cine_app/domain/entities/actor.dart';

import 'package:cine_app/infraestructure/mappers/actor_mapper.dart';
import 'package:cine_app/infraestructure/models/movieDb/actor_response.dart';
import 'package:dio/dio.dart';

class ActorMovieDbDatasource extends ActorsDatasource {
  final dio = Dio(BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Enviroment.theMovieDbKey,
        'language': 'es-MX'
      }));

  @override
  Future<List<Actor>> getActors(String movieID) async {
    final response = await dio.get('/movie/$movieID/credits');

    final castResponse = CreditsResponse.fromJson(response.data);
    final List<Actor> actors = castResponse.cast
        .map(
          (e) => ActorMapper.actorToEntitie(e),
        )
        .toList();
    return actors;
  }
}
