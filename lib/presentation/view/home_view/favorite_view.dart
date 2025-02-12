import 'package:cine_app/presentation/providers/storage/favorite_movies_provider.dart';
import 'package:cine_app/presentation/widgets/shared/movie_masonry_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entities/movie.dart';
import '../../delegates/movie_search_delegate.dart';
import '../../providers/providers.dart';

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

    if (movies.isEmpty) {
      final color = Theme.of(context).colorScheme;
      final textStyle = Theme.of(context).textTheme;
      return Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.heart_broken_rounded, size: 100, color: color.primary),
          Text("Lo siento, aun no tienes peliculas favoritas :(",
              style: TextStyle(
                color: color.primary,
                fontSize: 15,
              )),
          FilledButton.tonalIcon(
            onPressed: () {
              final searchedMovies = ref.read(searchedMoviesProvider);
              final searchQuery = ref.read(searchQueryProvider);

              showSearch<Movie?>(
                query: searchQuery,
                context: context,
                delegate: MovieSearchDelegate(
                  initialMovies: searchedMovies,
                  searchMovies: (query) {
                    return ref
                        .read(searchedMoviesProvider.notifier)
                        .searchedMoviesByQuery(query);
                  },
                  ref: ref, // Pasamos el ref
                ),
              ).then((movie) {
                // Si se selecciona una película, realizamos la navegación.
                if (movie != null && context.mounted) {
                  context.push('/movie/${movie.id}');
                }
              });
            },
            label: const Text('Busca una peli'),
            icon: const Icon(Icons.search),
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(color.primary),
            ),
          )
        ],
      ));
    }
    return Scaffold(
      body: MovieMasonryView(
        movies: movies,
        loadNextPage: loadNextPage,
      ),
    );
  }
}
