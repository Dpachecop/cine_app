import 'package:cine_app/domain/entities/actor.dart';
import 'package:cine_app/infraestructure/models/movieDb/actor_response.dart';

class ActorMapper {
  static Actor actorToEntitie(Cast cast) => Actor(
        id: cast.id,
        name: cast.name,
        profilePath: cast.profilePath != null
            ? 'https://image.tmdb.org/t/p/w500/${cast.profilePath}.jpg'
            : 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fes.123rf.com%2Fphoto_123291745_ilustraci%25C3%25B3n-de-avatar-de-perfil-predeterminado-en-azul-y-blanco-sin-persona.html&psig=AOvVaw0oL7eOLtBVQD_R3fhlhWof&ust=1736891726109000&source=images&cd=vfe&opi=89978449&ved=0CBQQjRxqFwoTCOjQ74TY84oDFQAAAAAdAAAAABAE',
        character: cast.character,
      );
}
