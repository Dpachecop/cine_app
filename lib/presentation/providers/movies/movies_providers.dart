import 'package:cine_app/domain/entities/movie.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final nowPlayingMoviesProvider = StateNotifierProvider(
  (ref) {
    return MoviesNotifier();
  },
);

class MoviesNotifier extends StateNotifier<List<Movie>> {
  MoviesNotifier() : super([]);
}
