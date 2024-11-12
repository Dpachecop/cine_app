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
}
