import 'package:cine_app/domain/datasources/movies_datasources.dart';
import 'package:cine_app/domain/entities/movie.dart';
import 'package:cine_app/domain/respositories/movie_repository.dart';

class MovieRepositoryImpl extends MoviesRepository {
  final MoviesDatasources datasources;

  MovieRepositoryImpl(this.datasources);
  @override
  Future<List<Movie>> getNowPLaying({int page = 1}) {
    return datasources.getNowPLaying(page: page);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) {
    return datasources.getPopular(page: page);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) {
    return datasources.getTopRated(page: page);
  }

  @override
  Future<List<Movie>> getUpComing({int page = 1}) {
    return datasources.getUpComing(page: page);
  }

  @override
  Future<Movie> getMovieById(String movieId) {
    return datasources.getMovieById(movieId);
  }

  @override
  Future<List<Movie>> searchMovies(String query) {
    return datasources.searchMovies(query);
  }

  @override
  Future<List<Movie>> similarMovies(String movieId) {
    return datasources.similarMovies(movieId);
  }
}
