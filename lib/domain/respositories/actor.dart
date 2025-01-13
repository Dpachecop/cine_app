import '../entities/actor.dart';

abstract class ActorsRepository {
  Future<List<Actor>> getActors(String movieID);
}
