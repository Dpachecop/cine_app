import 'package:cine_app/presentation/screens/movies/home_screen.dart';
import 'package:cine_app/presentation/screens/movies/movie_screen.dart';
import 'package:cine_app/presentation/view/home_view/categories_view.dart';
import 'package:cine_app/presentation/view/view.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    StatefulShellRoute.indexedStack(
      branches: [
        // Rama para la pestaña "Inicio"
        StatefulShellBranch(
          routes: [
            GoRoute(
                path: '/',
                name: 'HomeScreen',
                builder: (context, state) => const HomeView(),
                routes: [
                  GoRoute(
                    path: 'movie/:id',
                    builder: (context, state) {
                      final String movieId =
                          state.pathParameters['id'] ?? 'no-id';
                      return MovieScreen(
                        movieId: movieId,
                      );
                    },
                  ),
                ]),
          ],
        ),
        // Rama para la pestaña "Categorías"
        StatefulShellBranch(
          routes: [
            GoRoute(
                path: '/categories',
                name: 'Categories',
                builder: (context, state) => const CategoriesView()),
          ],
        ),
        // Rama para la pestaña "Favoritos"
        StatefulShellBranch(
          routes: [
            GoRoute(
                path: '/favorites',
                name: 'Favorites',
                builder: (context, state) => const FavoriteView()),
          ],
        ),
      ],
      // Builder del shell para gestionar las pestañas
      builder: (context, state, navigationShell) {
        return HomeScreen(
          selectedView: navigationShell,
          currentIndex: navigationShell.currentIndex,
          onTabSelected: (index) => navigationShell.goBranch(index),
        );
      },
    ),
  ],
);












  /*
  ShellRoute(
      builder: (context, state, child) {
        return HomeScreen(selectedView: child);
      },
      routes: [
        GoRoute(
            path: '/',
            builder: (context, state) => const HomeView(),
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
            ]),
        GoRoute(
          path: '/favorite',
          builder: (context, state) => const FavoriteView(),
        ),
      ])
]);
  





























final appRouter = GoRouter(initialLocation: '/', routes: [
  GoRoute(
    path: '/',
    name: HomeScreen.name,
    builder: (context, state) => const HomeScreen(selectedView: HomeView()),
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
  )
]);
*/