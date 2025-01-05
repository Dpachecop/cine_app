import 'package:cine_app/domain/entities/movie.dart';

abstract class MoviesRepository {
  Future<List<Movie>> getNowPLaying({int page = 1});
  Future<List<Movie>> getPopular({int page = 1});
  Future<List<Movie>> getUpComing({int page = 1});
  Future<List<Movie>> getTopRated({int page = 1});
  Future<Movie> getMovieById(String movieId);
}
