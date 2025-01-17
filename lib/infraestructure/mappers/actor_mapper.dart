import 'package:cine_app/domain/entities/actor.dart';
import 'package:cine_app/infraestructure/models/movieDb/actor_response.dart';

class ActorMapper {
  static Actor actorToEntitie(Cast cast) => Actor(
        id: cast.id,
        name: cast.name,
        profilePath: cast.profilePath != null
            ? 'https://image.tmdb.org/t/p/w500/${cast.profilePath}.jpg'
            : '',
        character: cast.character,
      );
}
