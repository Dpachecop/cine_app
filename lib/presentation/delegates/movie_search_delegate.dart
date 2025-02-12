import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:cine_app/config/Helpers/human_formats.dart';
import 'package:cine_app/presentation/providers/search/search_movies_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/movie.dart';

typedef SearchMovies = Future<List<Movie>> Function(String query);

class MovieSearchDelegate extends SearchDelegate<Movie?> {
  final SearchMovies searchMovies;
  StreamController<List<Movie>> debouncedMovies = StreamController.broadcast();
  StreamController<bool> isLoadingStream = StreamController.broadcast();

  List<Movie> initialMovies;
  Timer? debouncetimer;

  final WidgetRef ref;

  MovieSearchDelegate({
    required this.searchMovies,
    required this.initialMovies,
    required this.ref,
  });

  void onQueryChanged(String query) {
    isLoadingStream.add(true);
    if (debouncetimer?.isActive ?? false) {
      debouncetimer!.cancel();
    }

    debouncetimer = Timer(
      const Duration(milliseconds: 500),
      () async {
        isLoadingStream.add(true);

        if (query.isEmpty) {
          // Si el query está vacío, actualizamos el estado para reflejarlo.
          ref.read(searchQueryProvider.notifier).update((state) => '');
          ref.read(searchedMoviesProvider.notifier).state = [];
          debouncedMovies.add([]);
          return;
        }

        final movies = await searchMovies(query);
        initialMovies = movies;
        debouncedMovies.add(movies);
        isLoadingStream.add(false);
      },
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    if (query.isNotEmpty) {
      return [
        StreamBuilder(
          stream: isLoadingStream.stream,
          initialData: false,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data ?? false) {
              return SpinPerfect(
                duration: const Duration(seconds: 5),
                child: IconButton(
                  onPressed: () {
                    query = '';
                  },
                  icon: const Icon(Icons.refresh_outlined),
                ),
              );
            }

            return FadeIn(
              child: IconButton(
                onPressed: () {
                  query = '';
                },
                icon: const Icon(Icons.clear),
              ),
            );
          },
        ),
      ];
    }
    return null;
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        // Cuando el usuario cierra el SearchDelegate, no se borra si hay query.

        close(context, null);
      },
      icon: const Icon(Icons.arrow_back_ios_new_outlined),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildResultsAndSuggestions();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    onQueryChanged(query);
    return buildResultsAndSuggestions();
  }

  Widget buildResultsAndSuggestions() {
    return StreamBuilder(
      initialData: initialMovies,
      stream: debouncedMovies.stream,
      builder: (BuildContext context, snapshot) {
        final movies = snapshot.data ?? [];
        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (BuildContext context, int index) {
            final movie = movies[index];
            return _MovieItem(
              movie: movie,
              onMovie: (context, movie) {
                close(context, movie);
              },
            );
          },
        );
      },
    );
  }
}

class _MovieItem extends StatelessWidget {
  final Movie movie;
  final Function onMovie;
  const _MovieItem({required this.movie, required this.onMovie});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyle = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () => onMovie(context, movie),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Imagen de la pelicula
            SizedBox(
              width: size.width * 0.2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  movie.posterPath,
                  loadingBuilder: (context, child, loadingProgress) =>
                      FadeIn(child: child),
                ),
              ),
            ),
            //informacion de la pelicula
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: size.width * 0.65,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie.title,
                        maxLines: 2,
                        style: textStyle.titleMedium,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      movie.overview.length >= 100
                          ? Text('${movie.overview.substring(0, 100)}...')
                          : Text(movie.overview),
                      Row(
                        children: [
                          const Icon(
                            Icons.star_half_outlined,
                            color: Colors.amber,
                          ),
                          Text(
                            HumanFormats.Humanformats(movie.voteAverage),
                            style: textStyle.bodyMedium!
                                .copyWith(color: Colors.amber),
                          )
                        ],
                      )
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
