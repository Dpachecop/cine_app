import 'package:cine_app/domain/entities/movie.dart';

abstract class LocalStorageRepository {
  Future<void> toggleFavorite(Movie movie);
  Future<bool> isFavorite(int id);
  Future<List<Movie>> loadMovies({int page = 10, offset = 0});
}
