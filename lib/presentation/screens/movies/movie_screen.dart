import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:cine_app/domain/entities/movie.dart';
import 'package:cine_app/presentation/providers/providers.dart';
import 'package:cine_app/presentation/providers/storage/local_storage_provider.dart';

import 'package:cine_app/presentation/widgets/movies/similar_movies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../config/Helpers/human_formats.dart';
import '../../providers/storage/favorite_movies_provider.dart';

class MovieScreen extends ConsumerStatefulWidget {
  final String movieId;

  const MovieScreen({super.key, required this.movieId});

  @override
  MovieScreenState createState() => MovieScreenState();
}

class MovieScreenState extends ConsumerState<MovieScreen> {
  @override
  void initState() {
    super.initState();

    ref.read(movieInfoProvider.notifier).loadMovie(widget.movieId);
    ref.read(actorsByMovieProvider.notifier).loadActors(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    final movies =
        ref.watch(movieRepositoryProvider).similarMovies(widget.movieId);
    final Movie? movie = ref.watch(movieInfoProvider)[widget.movieId];

    if (movie == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            strokeWidth: sqrt1_2,
          ),
        ),
      );
    }

    return Scaffold(
        body:
            CustomScrollView(physics: const ClampingScrollPhysics(), slivers: [
      _CustomSliverAppBar(movie: movie),
      SliverList(
          delegate: SliverChildBuilderDelegate(
              (context, index) => _MovieDetails(
                    movie: movie,
                  ),
              childCount: 1))
    ]));
  }
}

class _MovieDetails extends StatelessWidget {
  final Movie movie;

  const _MovieDetails({
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    final textstyle = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    final textStyles = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Imagen
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  movie.posterPath,
                  width: size.width * 0.3,
                ),
              ),

              const SizedBox(width: 10),

              // Descripción
              SizedBox(
                width: (size.width - 40) * 0.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(movie.title, style: textStyles.titleLarge),
                    Text(movie.overview),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          LegibleStars(movie: movie),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            HumanFormats.Humanformats(movie.voteAverage),
                            style: textstyle.bodyMedium
                                ?.copyWith(color: Colors.amber),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Wrap(
            children: [
              ...movie.genreIds.map((String gender) => Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: Chip(
                      label: Text(gender.toLowerCase()),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ))
            ],
          ),
        ),
        _ActorsByMovie(movieId: movie.id.toString()),
        SimilarMovies(movieId: movie.id.toString())
      ],
    );
  }
}

class _ActorsByMovie extends ConsumerWidget {
  final String movieId;

  const _ActorsByMovie({required this.movieId});

  @override
  Widget build(BuildContext context, ref) {
    final actorsByMovie = ref.watch(actorsByMovieProvider);

    if (actorsByMovie[movieId] == null) {
      return const CircularProgressIndicator(strokeWidth: 2);
    }
    final actors = actorsByMovie[movieId]!;

    return SizedBox(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: actors.length,
        itemBuilder: (context, index) {
          final actor = actors[index];

          return Container(
            padding: const EdgeInsets.all(8.0),
            width: 135,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Actor Photo
                FadeInRight(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      actor.profilePath,
                      height: 180,
                      width: 135,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // Nombre
                const SizedBox(
                  height: 5,
                ),

                Text(actor.name, maxLines: 2),
                Text(
                  actor.character ?? '',
                  maxLines: 2,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

final isFavoriteProvider = FutureProvider.family.autoDispose(
  (ref, int id) {
    final localstorageRepository = ref.watch(localStorageRepositoryProvider);

    return localstorageRepository.isFavorite(id);
  },
);

class _CustomSliverAppBar extends ConsumerWidget {
  final Movie movie;

  const _CustomSliverAppBar({required this.movie});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;

    final isFutureProvider = ref.watch(isFavoriteProvider(movie.id));

    return SliverAppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          context.pop();
        },
      ),
      actions: [
        IconButton(
          onPressed: () async {
            await ref
                .read(favoriteMoviesProvider.notifier)
                .toggleFavorite(movie);

            ref.invalidate(isFavoriteProvider(movie.id));
          },
          icon: isFutureProvider.when(
            data: (isFavorite) {
              return isFavorite
                  ? const Icon(
                      Icons.favorite,
                      color: Colors.red,
                    )
                  : const Icon(Icons.favorite_border);
            },
            loading: () => const CircularProgressIndicator(),
            error: (error, _) => const Icon(Icons.error),
          ),
          color: Colors.white,
          iconSize: 30,
        )
      ],
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.7,
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        // title: Text(
        //   movie.title,
        //   style: const TextStyle(fontSize: 20),
        //   textAlign: TextAlign.start,
        // ),
        background: Stack(
          children: [
            SizedBox.expand(
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) return const SizedBox();
                  return FadeIn(child: child);
                },
              ),
            ),
            const _CustomGradient(
              beginAlingment: Alignment.topCenter,
              endAlingment: Alignment.bottomCenter,
              stops: [0.7, 1.0],
              colors: [Colors.transparent, Colors.black87],
            ),
            const _CustomGradient(
              beginAlingment: Alignment.topLeft,
              endAlingment: Alignment.centerRight,
              stops: [0.0, 0.2],
              colors: [
                Colors.black38,
                Colors.transparent,
              ],
            ),
            const _CustomGradient(
              beginAlingment: Alignment.topRight,
              endAlingment: Alignment.centerLeft,
              stops: [0.0, 0.2],
              colors: [
                Colors.black54,
                Colors.transparent,
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class LegibleStars extends StatelessWidget {
  final Movie movie;

  const LegibleStars({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    int cant = 0;
    for (var i = 1; i <= 10; i++) {
      if (movie.voteAverage >= i) {
        cant += 1;
      }
    }
    return Wrap(children: [
      Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(cant, (index) {
            return const Icon(
              Icons.star,
              color: Colors.amber,
              size: 20,
            );
          })),
    ]);
  }
}

class _CustomGradient extends StatelessWidget {
  final AlignmentGeometry? beginAlingment;
  final AlignmentGeometry? endAlingment;
  final List<double> stops; // 0.0 - 1.0
  final List<Color> colors;

  const _CustomGradient({
    this.beginAlingment,
    this.endAlingment,
    required this.stops,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: beginAlingment ?? Alignment.centerLeft,
                  end: endAlingment ?? Alignment.centerRight,
                  stops: stops,
                  colors: colors))),
    );
  }
}
