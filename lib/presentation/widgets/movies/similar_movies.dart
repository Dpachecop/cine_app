import 'package:cine_app/domain/entities/movie.dart';
import 'package:cine_app/presentation/widgets/movies/horizontal_movie_slideview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/providers.dart';

final similarMoviesProvider = FutureProvider.family((ref, String movieId) {
  final movieRepository = ref.watch(movieRepositoryProvider);
  return movieRepository.similarMovies(movieId);
});

class SimilarMovies extends ConsumerWidget {
  final String movieId;

  const SimilarMovies({super.key, required this.movieId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final similarMoviesFuture = ref.watch(similarMoviesProvider(movieId));

    return similarMoviesFuture.when(
      data: (movies) => _Recomendations(movies: movies),
      error: (_, __) =>
          const Center(child: Text('No se pudo cargar películas similares')),
      loading: () =>
          const Center(child: CircularProgressIndicator(strokeWidth: 2)),
    );
  }
}

class _Recomendations extends StatelessWidget {
  final List<Movie> movies;

  const _Recomendations({required this.movies});

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) return const SizedBox();

    return Container(
      margin: const EdgeInsetsDirectional.only(bottom: 50),
      child: HorizontalMovieSlideview(label: 'Recomendaciones', movies: movies),
    );
  }
}
