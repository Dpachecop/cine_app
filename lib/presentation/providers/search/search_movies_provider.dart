import 'package:cine_app/domain/entities/movie.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

final searchedMoviesProvider =
    StateNotifierProvider<SearchedMoviesNotifier, List<Movie>>((ref) {
  final movieRepository = ref.read(movieRepositoryProvider);
  return SearchedMoviesNotifier(
      ref: ref, searchMovies: movieRepository.searchMovies);
});

//Referencia a la funcion que llama al metodo que me devuelve movies
//mediante el query de busqueda.
typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

class SearchedMoviesNotifier extends StateNotifier<List<Movie>> {
  final SearchMoviesCallback searchMovies;
  final Ref ref;

  SearchedMoviesNotifier({required this.ref, required this.searchMovies})
      : super([]);

  Future<List<Movie>> searchedMoviesByQuery(String query) async {
    ref.read(searchQueryProvider.notifier).update(
          (state) => query,
        );

    final List<Movie> movies = await searchMovies(query);
    state = movies;
    return query != '' ? movies : [];
  }
}
