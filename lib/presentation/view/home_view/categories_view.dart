import 'package:cine_app/domain/entities/movie.dart';
import 'package:cine_app/presentation/widgets/shared/movie_masonry_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/providers.dart';

class CategoriesView extends ConsumerStatefulWidget {
  static const name = 'Categories_screen';
  const CategoriesView({super.key});

  @override
  ConsumerState<CategoriesView> createState() => CategoriesViewState();
}

class CategoriesViewState extends ConsumerState<CategoriesView> {
  @override
  Widget build(BuildContext context) {
    final movies = ref.watch(nowPlayingMoviesProvider);

    return Scaffold(
        body: MovieMasonryView(
            movies: movies,
            loadNextPage: () {
              ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
            }));
  }
}
