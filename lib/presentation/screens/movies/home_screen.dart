import 'package:cine_app/presentation/providers/movies/loading_screen_provider.dart';
import 'package:cine_app/presentation/providers/providers.dart';
import 'package:cine_app/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'Home_screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeView(),
      bottomNavigationBar: CustomBotttomNavigation(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState {
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
    final popularMovies = ref.watch(popularMoviesProvider);
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
                  subLabel: '¡Aleatorio!',
                  loadNextpage: () {
                    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
                  },
                ),
                HorizontalMovieSlideview(
                  movies: topRatedMovies,
                  label: 'Mejores calificadas',
                  //TODO: implementar un metodo que te de una peli aleatoria
                  subLabel: '¡Aleatorio!',
                  loadNextpage: () {
                    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
                  },
                ),
                HorizontalMovieSlideview(
                  movies: upComingMovies,
                  label: 'Estrenos',
                  //TODO: implementar un metodo que te de una peli aleatoria
                  subLabel: '¡Aleatorio!',
                  loadNextpage: () {
                    ref.read(upComingMoviesProvider.notifier).loadNextPage();
                  },
                ),
                HorizontalMovieSlideview(
                  movies: popularMovies,
                  label: 'populares',
                  //TODO: implementar un metodo que te de una peli aleatoria
                  subLabel: '¡Aleatorio!',
                  loadNextpage: () {
                    ref.read(popularMoviesProvider.notifier).loadNextPage();
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
