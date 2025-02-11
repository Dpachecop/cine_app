import 'package:cine_app/domain/datasources/local_storage_datasource.dart';
import 'package:cine_app/domain/entities/movie.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarDatasurce extends LocalStorageDatasource {
  late Future<Isar> db;

  IsarDatasurce() {
    db = openIsar();
  }

  Future<Isar> openIsar() async {
    final dir = await getApplicationDocumentsDirectory();

    if (Isar.instanceNames.isEmpty) {
      return await Isar.open([MovieSchema], directory: dir.path);
    }

    return Future.value(Isar.getInstance());
  }

  @override
  Future<bool> isFavorite(int id) async {
    final isar = await db;

    final isMovieFavorite =
        await isar.movies.filter().idEqualTo(id).findFirst();

    return isMovieFavorite != null;
  }

  @override
  Future<List<Movie>> loadMovies({int page = 10, offset = 0}) async {
    final isar = await db;

    return isar.movies.where().offset(offset).limit(page).findAll();
  }

  @override
  Future<void> toggleFavorite(Movie movie) async {
    final isar = await db;

    final favoriteMovie =
        await isar.movies.filter().idEqualTo(movie.id).findFirst();

    if (favoriteMovie != null) {
      isar.writeTxnSync(() => isar.movies.deleteSync(favoriteMovie.isarid!));
    } else {
      isar.writeTxnSync(() => isar.movies.putSync(movie));
    }
  }
}
