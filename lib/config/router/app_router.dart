import 'package:cine_app/presentation/screens/movies/home_screen.dart';
import 'package:cine_app/presentation/screens/movies/movie_screen.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(initialLocation: '/home/0', routes: [
  GoRoute(
    path: '/home/:id',
    name: HomeScreen.name,
    builder: (context, state) {
      final pageindex = int.parse(state.pathParameters['id'] ?? '0');

      return HomeScreen(
        pageIndex: pageindex,
      );
    },
    routes: [
      GoRoute(
        path: 'movie/:id',
        builder: (context, state) {
          final String movieId = state.pathParameters['id'] ?? 'no-id';
          return MovieScreen(
            movieId: movieId,
          );
        },
      ),
    ],
  ),
]);
