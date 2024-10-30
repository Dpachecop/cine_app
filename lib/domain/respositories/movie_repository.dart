import 'package:cine_app/domain/entities/movie.dart';

abstract class MoviesRepository {
  Future<List<Movie>> getNowPLaying({int page = 1});
}
