import 'package:cine_app/config/constants/themoviedbkey.dart';
import 'package:cine_app/presentation/providers/movies/movies_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'Home_screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('TEXTO GENERICO'),
        ),
        body: _HomeView());
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView({
    super.key,
  });

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
    return ListView.builder(
      itemCount: nowPLayingMovies.length,
      itemBuilder: (BuildContext context, int index) {
        final movie = nowPLayingMovies[index];
        return ListTile(
          title: Text(movie.title),
        );
      },
    );
  }
}
