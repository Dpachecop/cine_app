import 'package:cine_app/domain/datasources/local_storage_datasource.dart';
import 'package:cine_app/domain/entities/movie.dart';
import 'package:cine_app/domain/respositories/local_storage_repository.dart';

class LocalStorageImpl extends LocalStorageRepository {
  final LocalStorageDatasource datasource;

  LocalStorageImpl(this.datasource);

  @override
  Future<bool> isFavorite(int id) {
    return datasource.isFavorite(id);
  }

  @override
  Future<List<Movie>> loadMovies({int page = 10, offset = 0}) {
    return datasource.loadMovies(page: page, offset: offset);
  }

  @override
  Future<void> toggleFavorite(Movie movie) {
    return datasource.toggleFavorite(movie);
  }
}
