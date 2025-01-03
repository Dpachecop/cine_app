import 'package:cine_app/config/constants/themoviedbkey.dart';
import 'package:cine_app/domain/datasources/movies_datasources.dart';
import 'package:cine_app/domain/entities/movie.dart';
import 'package:cine_app/infraestructure/mappers/movie_mappers.dart';
import 'package:cine_app/infraestructure/models/movieDb/moviedb_response.dart';
import 'package:dio/dio.dart';

class MoviedbDatasource extends MoviesDatasources {
  final dio = Dio(BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Enviroment.theMovieDbKey,
        'language': 'es-MX'
      }));

  @override
  Future<List<Movie>> getNowPLaying({int page = 1}) async {
    final response =
        await dio.get('/movie/now_playing', queryParameters: {'page': page});
    final movieDBResponse = MovieDbResponse.fromJson(response.data);

    final List<Movie> movies = movieDBResponse.results
        .where((moviedb) => moviedb.posterPath != '')
        .map((moviedb) => MovieMappers.movieDBToEntitie(moviedb))
        .toList();

    return movies;
  }
}
