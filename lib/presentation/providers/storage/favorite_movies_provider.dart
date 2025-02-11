import 'package:cine_app/domain/entities/movie.dart';
import 'package:cine_app/domain/respositories/local_storage_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'local_storage_provider.dart';

final favoriteMoviesProvider =
    StateNotifierProvider<StorageMoviesNotifier, Map<int, Movie>>((ref) {
  final localStorageRepository = ref.watch(localStorageRepositoryProvider);
  return StorageMoviesNotifier(localStorageRepository);
});

class StorageMoviesNotifier extends StateNotifier<Map<int, Movie>> {
  int page = 0;

  final LocalStorageRepository localStorageRepository;

  StorageMoviesNotifier(this.localStorageRepository) : super({});

  Future<void> loadMovies() async {
    final movies = await localStorageRepository.loadMovies(offset: page * 10);
    page++;
    final Map<int, Movie> tempMovies = {};
    for (final movie in movies) {
      tempMovies[movie.id] = movie;
    }

    state = {...state, ...tempMovies};
  }
}
