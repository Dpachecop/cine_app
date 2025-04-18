import 'package:cine_app/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/providers.dart';

class HomeView extends ConsumerStatefulWidget {
  static const name = 'Home_screen';
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState {
  @override
  void initState() {
    super.initState();

    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(upComingMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final initialLoading = ref.watch(loadingScreenProvider);

    if (initialLoading) return const FullLoaderScreen();

    final nowPLayingMovies = ref.watch(nowPlayingMoviesProvider);
    final upComingMovies = ref.watch(upComingMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);
    final slideMovies = ref.watch(MovieSlideViewProvider);

    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          floating: true,
          title: CustomAppbar(),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
          return SingleChildScrollView(
            child: Column(
              children: [
                MoviesSlideView(movies: slideMovies),
                HorizontalMovieSlideview(
                  movies: nowPLayingMovies,
                  label: 'En cines',
                  //TODO: implementar un metodo que te de una peli aleatoria
                  subLabel: '¡Lo mejor!',
                  loadNextpage: () {
                    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
                  },
                ),
                HorizontalMovieSlideview(
                  movies: topRatedMovies,
                  label: 'Mejores calificadas',
                  //TODO: implementar un metodo que te de una peli aleatoria
                  subLabel: '¡Para disfrutar!',
                  loadNextpage: () {
                    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
                  },
                ),
                HorizontalMovieSlideview(
                  movies: upComingMovies,
                  label: 'Estrenos',
                  //TODO: implementar un metodo que te de una peli aleatoria
                  subLabel: '¡Pronto!',
                  loadNextpage: () {
                    ref.read(upComingMoviesProvider.notifier).loadNextPage();
                  },
                ),
              ],
            ),
          );
        }, childCount: 1))
      ],
    );
  }
}
