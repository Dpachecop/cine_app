import 'package:cine_app/domain/entities/actor.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'actors_repository_provider.dart';

final actorsByMovieProvider =
    StateNotifierProvider<ActorsByMovieNotifier, Map<String, List<Actor>>>(
        (ref) {
  final actorsRepository = ref.watch(actorRepositoryProvider);
  return ActorsByMovieNotifier(getActors: actorsRepository.getActors);
});

typedef GetActorsCallback = Future<List<Actor>> Function(String movieId);

class ActorsByMovieNotifier extends StateNotifier<Map<String, List<Actor>>> {
  final GetActorsCallback getActors;

  ActorsByMovieNotifier({
    required this.getActors,
  }) : super({});

  Future<void> loadActors(String movieId) async {
    if (state[movieId] != null) return;

    final List<Actor> actor = await getActors(movieId);
    state = {...state, movieId: actor};
  }
}
