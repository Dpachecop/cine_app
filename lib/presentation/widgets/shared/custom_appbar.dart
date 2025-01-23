import 'package:animate_do/animate_do.dart';
import 'package:cine_app/presentation/delegates/movie_search_delegate.dart';
import 'package:cine_app/presentation/providers/movies/movie_repository_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/Functions/theme_provider.dart';

class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme.bodyLarge;

    final movierepository = ref.read(movieRepositoryProvider);
    final themeMode = ref.watch(themeProvider);
    final themeNotifier = ref.read(themeProvider.notifier);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Icon(
                Icons.movie,
                color: colors.primary,
              ),
              Text(
                'Cinemapedia',
                style: text,
              ),
              const Spacer(),
              // Botón para alternar el tema
              IconButton(
                onPressed: () => themeNotifier.toggleTheme(),
                icon: FadeIn(
                  child: Icon(
                    themeMode == ThemeMode.dark
                        ? Icons.wb_sunny_outlined
                        : Icons
                            .nightlight_round_outlined, // Luna para modo claro
                  ),
                ),
              ),
              // Botón de búsqueda
              IconButton(
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate: MovieSearchDelegate(
                      searchMovies: movierepository.searchMovies,
                    ),
                  );
                },
                icon: const Icon(Icons.search),
              )
            ],
          ),
        ),
      ),
    );
  }
}
