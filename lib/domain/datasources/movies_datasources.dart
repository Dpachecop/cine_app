import 'package:cine_app/domain/entities/movie.dart';

abstract class MoviesDatasources {
  Future<List<Movie>> getNowPLaying({int page = 1});
  Future<List<Movie>> getPopular({int page = 1});
  Future<List<Movie>> getUpComing({int page = 1});
  Future<List<Movie>> getTopRated({int page = 1});
  Future<Movie> getMovieById(String movieId);
  Future<List<Movie>> searchMovies(String query);
}
