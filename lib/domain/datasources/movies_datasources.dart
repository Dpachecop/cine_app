import 'package:cine_app/domain/entities/movie.dart';

abstract class MoviesDatasources {
  Future<List<Movie>> getNowPLaying({int page = 1});
}
