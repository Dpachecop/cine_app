import 'package:cine_app/config/constants/themoviedbkey.dart';
import 'package:cine_app/domain/datasources/movies_datasources.dart';
import 'package:cine_app/domain/entities/movie.dart';
import 'package:cine_app/infraestructure/mappers/movie_mappers.dart';
import 'package:cine_app/infraestructure/models/movieDb/movie_details_moviedb.dart';
import 'package:cine_app/infraestructure/models/movieDb/moviedb_response.dart';
import 'package:dio/dio.dart';

class MoviedbDatasource extends MoviesDatasources {
  final dio = Dio(BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Enviroment.theMovieDbKey,
        'language': 'es-MX'
      }));

  List<Movie> _jsonToResponse(Map<String, dynamic> json) {
    final movieDBResponse = MovieDbResponse.fromJson(json);

    final List<Movie> movies = movieDBResponse.results
        .where((moviedb) => moviedb.posterPath != '')
        .map((moviedb) => MovieMappers.movieDBToEntitie(moviedb))
        .toList();

    return movies;
  }

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

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    final response = await dio.get(
      '/movie/popular',
      queryParameters: {'page': page},
    );

    return _jsonToResponse(response.data);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    final response = await dio.get(
      '/movie/top_rated',
      queryParameters: {'page': page},
    );

    return _jsonToResponse(response.data);
  }

  @override
  Future<List<Movie>> getUpComing({int page = 1}) async {
    final response = await dio.get(
      '/movie/upcoming',
      queryParameters: {'page': page},
    );

    return _jsonToResponse(response.data);
  }

  @override
  Future<Movie> getMovieById(String movieId) async {
    final response = await dio.get('/movie/$movieId');

    if (response.statusCode != 200)
      throw Exception(' Movie with id: $movieId doesnt exist');

    final movieDB = MovieDetails.fromJson(response.data);
    final movie = MovieMappers.movieDbDetailsToEntitie(movieDB);
    return movie;
  }
}
