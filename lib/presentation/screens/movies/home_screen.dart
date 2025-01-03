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
  }

  @override
  Widget build(BuildContext context) {
    final nowPLayingMovies = ref.watch(nowPlayingMoviesProvider);
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
                  movies: nowPLayingMovies,
                  label: 'Mejores calificadas',
                  //TODO: implementar un metodo que te de una peli aleatoria
                  subLabel: '¡Aleatorio!',
                  loadNextpage: () {
                    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
                  },
                ),
                HorizontalMovieSlideview(
                  movies: nowPLayingMovies,
                  label: 'Estrenos',
                  //TODO: implementar un metodo que te de una peli aleatoria
                  subLabel: '¡Aleatorio!',
                  loadNextpage: () {
                    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
                  },
                ),
                HorizontalMovieSlideview(
                  movies: nowPLayingMovies,
                  label: 'Mejor calificadas',
                  //TODO: implementar un metodo que te de una peli aleatoria
                  subLabel: '¡Aleatorio!',
                  loadNextpage: () {
                    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
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
