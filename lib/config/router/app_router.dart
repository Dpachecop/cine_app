import 'package:cine_app/presentation/screens/movies/home_screen.dart';
import 'package:cine_app/presentation/screens/movies/movie_screen.dart';
import 'package:cine_app/presentation/view/home_view/categories_view.dart';
import 'package:cine_app/presentation/view/view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    StatefulShellRoute.indexedStack(
      // 1.1. Definimos las ramas
      branches: [
        // -----------------------------
        // Rama 0: Home
        // -----------------------------
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/',
              name: 'HomeScreen',
              builder: (context, state) => const HomeView(),
              routes: [
                // Subruta para el detalle de la película con transición
                GoRoute(
                  path: 'movie/:id',
                  builder: (context, state) {
                    final String movieId =
                        state.pathParameters['id'] ?? 'no-id';
                    return MovieScreen(movieId: movieId);
                  },
                  pageBuilder: (context, state) {
                    // Esta transición se aplica al navegar a "movie/:id"
                    return CustomTransitionPage(
                      child: MovieScreen(
                        movieId: state.pathParameters['id'] ?? 'no-id',
                      ),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        const begin = Offset(1.0, 0.0);
                        const end = Offset.zero;
                        const curve = Curves.easeInOut;

                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));
                        var offsetAnimation = animation.drive(tween);

                        return SlideTransition(
                          position: offsetAnimation,
                          child: child,
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ],
        ),

        // -----------------------------
        // Rama 1: Categories
        // -----------------------------
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/categories',
              name: 'Categories',
              pageBuilder: (context, state) => CustomTransitionPage(
                child: const CategoriesView(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
              ),
            ),
          ],
        ),

        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/favorites',
              name: 'Favorites',
              builder: (context, state) => const FavoriteView(),
            ),
          ],
        ),
      ],
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
