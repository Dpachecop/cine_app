import 'package:cine_app/presentation/screens/movies/home_screen.dart';
import 'package:cine_app/presentation/screens/movies/movie_screen.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: HomeScreen.name,
      builder: (context, state) => const HomeScreen(),
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
    GoRoute(
      path: '/:id',
      builder: (context, state) {
        final String movieId = state.pathParameters['id'] ?? 'no-id';

        // Verifica si el ID es un número válido
        if (int.tryParse(movieId) != null) {
          return MovieScreen(movieId: movieId);
        }

        // Si no es un número, redirige a HomeScreen u otra pantalla de error
        return const HomeScreen();
      },
    ),
  ],
  redirect: (context, state) {
    final uri = Uri.parse(state.uri.toString());

    // Redirigir si el ID es un número y no incluye el prefijo "/movie/"
    if (uri.pathSegments.length == 1) {
      final id = uri.pathSegments.first;
      if (int.tryParse(id) != null) {
        return '/movie/$id';
      }
    }

    return null; // No redirigir si no es necesario
  },
);
