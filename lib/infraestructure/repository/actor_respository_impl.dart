import 'package:cine_app/domain/datasources/actors_datasource.dart';
import 'package:cine_app/domain/entities/actor.dart';
import 'package:cine_app/domain/respositories/actor.dart';

class ActorRespositoryImpl extends ActorsRepository {
  final ActorsDatasource actorsDatasource;

  ActorRespositoryImpl(this.actorsDatasource);
  @override
  Future<List<Actor>> getActors(String movieID) {
    return actorsDatasource.getActors(movieID);
  }
}
