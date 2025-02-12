import 'package:cine_app/presentation/providers/storage/favorite_movies_provider.dart';
import 'package:cine_app/presentation/widgets/shared/movie_masonry_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoriteView extends ConsumerStatefulWidget {
  static const name = 'Favorite_screen';
  const FavoriteView({super.key});

  @override
  FavoriteViewState createState() => FavoriteViewState();
}

class FavoriteViewState extends ConsumerState<FavoriteView> {
  bool islastpage = false;
  bool isloading = false;

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    loadNextPage();
  }

  void loadNextPage() async {
    if (islastpage || isloading) return;
    isloading = true;

    final movies = await ref.read(favoriteMoviesProvider.notifier).loadMovies();
    isloading = false;

    if (movies.isEmpty) {
      islastpage = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final movies = ref.watch(favoriteMoviesProvider).values.toList();

    return Scaffold(
      body: MovieMasonryView(
        movies: movies,
        loadNextPage: loadNextPage,
      ),
    );
  }
}
