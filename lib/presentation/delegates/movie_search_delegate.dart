import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/movie.dart';

typedef SearchMovies = Future<List<Movie>> Function(String query);

class MovieSearchDelegate extends SearchDelegate<Movie?> {
  final SearchMovies searchMovies;

  MovieSearchDelegate({required this.searchMovies});
  @override
  String get searchFieldLabel => 'Buscar peli';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      FadeIn(
        curve: Curves.bounceInOut,
        animate: query.isNotEmpty,
        child: IconButton(
            onPressed: () => query = '', icon: const Icon(Icons.clear_rounded)),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => close(context, null),
        icon: const Icon(Icons.arrow_back_ios_new_outlined));
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('buildResults');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: searchMovies(query),
      builder: (BuildContext context, snapshot) {
        final movies = snapshot.data ?? [];

        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (BuildContext context, int index) {
            final movie = movies[index];
            return ListTile(
              title: Text(movie.title),
            );
          },
        );
      },
    );
  }
}
