import '../entities/actor.dart';

abstract class ActorsDatasource {
  Future<List<Actor>> getActors(String movieID);
}
