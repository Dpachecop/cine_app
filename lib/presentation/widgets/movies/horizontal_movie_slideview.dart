/// [HorizontalMovieSlideview] muestra un carrusel horizontal de películas.
///
/// Este widget es ideal para mostrar listas de películas con desplazamiento horizontal
/// en la pantalla principal de la aplicación. También puede incluir un título opcional
/// ([label]) y un subtítulo ([subLabel]).
///
/// - **Desplazamiento horizontal:** Se utiliza un [ScrollController] para detectar
///   cuando el usuario alcanza el final y llamar a [loadNextpage].
/// - **Carga dinámica:** Ideal para implementar la carga progresiva de datos.
///
/// ## Uso:
/// ```dart
/// HorizontalMovieSlideview(
///   movies: movieList,
///   label: "Películas populares",
///   subLabel: "Ver más",
///   loadNextpage: fetchMoreMovies,
/// )
/// ```
import 'package:animate_do/animate_do.dart';
import 'package:cine_app/config/Helpers/human_formats.dart';
import 'package:cine_app/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HorizontalMovieSlideview extends StatefulWidget {
  /// Lista de películas a mostrar en el carrusel.
  final List<Movie> movies;

  /// Título opcional del carrusel.
  final String? label;

  /// Subtítulo opcional que aparece junto al título.
  final String? subLabel;

  /// Función que se ejecuta al llegar al final del desplazamiento.
  final VoidCallback? loadNextpage;

  /// Constructor de [HorizontalMovieSlideview].
  ///
  /// - [movies] es obligatorio y representa la lista de películas a mostrar.
  /// - [label] y [subLabel] son opcionales y se usan para personalizar el encabezado.
  /// - [loadNextpage] es opcional y se ejecuta al alcanzar el final del scroll.
  /// - [key] es opcional y se utiliza para identificar el widget.
  /// ## Uso:
  /// ```dart
  /// HorizontalMovieSlideview(
  ///   movies: movieList,
  ///   label: "Películas populares",
  ///   subLabel: "Ver más",
  ///   loadNextpage: fetchMoreMovies,
  /// )
  /// ```
  const HorizontalMovieSlideview({
    super.key,
    required this.movies,
    this.label,
    this.subLabel,
    this.loadNextpage,
  });

  @override
  State<HorizontalMovieSlideview> createState() =>
      _HorizontalMovieSlideviewState();
}

/// Estado interno de [HorizontalMovieSlideview].
///
/// Este estado controla el desplazamiento horizontal y llama a la función
/// [loadNextpage] cuando se alcanza el final del carrusel.
class _HorizontalMovieSlideviewState extends State<HorizontalMovieSlideview> {
  /// Controlador de desplazamiento para manejar el scroll horizontal.
  final scrolllController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrolllController.addListener(() {
      if (widget.loadNextpage == null) return;

      if ((scrolllController.position.pixels + 500) >=
          scrolllController.position.maxScrollExtent) {
        widget.loadNextpage!();
      }
    });
  }

  @override
  void dispose() {
    scrolllController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 370,
      child: Column(
        children: [
          if (widget.label != null || widget.subLabel != null)
            _Title(
              label: widget.label,
              subLabel: widget.subLabel,
            ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              controller: scrolllController,
              itemCount: widget.movies.length,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return FadeInRight(
                  child: _Slide(movie: widget.movies[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// Representa una película individual dentro del carrusel horizontal.
///
/// Este widget incluye una imagen, el título de la película y su calificación.
///
/// ## Parámetros:
/// - [movie]: La película que se mostrará en este widget.
class _Slide extends StatelessWidget {
  final Movie movie;

  /// Constructor de [_Slide].
  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {
    final textstyle = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                fit: BoxFit.cover,
                movie.posterPath,
                width: 150,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return GestureDetector(
                    onTap: () => context.push('/movie/${movie.id}'),
                    child: FadeIn(child: child),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 5),
          SizedBox(
            width: 150,
            child: Text(
              movie.title,
              maxLines: 2,
              style: textstyle.titleSmall,
            ),
          ),
          Row(
            children: [
              const Icon(
                Icons.star_half_outlined,
                color: Colors.amber,
              ),
              Text(
                HumanFormats.Humanformats(movie.voteAverage),
                style: textstyle.bodyMedium?.copyWith(color: Colors.amber),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Muestra un encabezado con un título y un subtítulo opcional.
///
/// ## Parámetros:
/// - [label]: El título principal.
/// - [subLabel]: El subtítulo opcional.
class _Title extends StatelessWidget {
  final String? label;
  final String? subLabel;

  /// Constructor de [_Title].
  const _Title({this.label, this.subLabel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          if (label != null)
            Text(
              label!,
              style: const TextStyle(fontSize: 20),
            ),
          const Spacer(),
          if (subLabel != null)
            FilledButton.tonal(
              onPressed: () {},
              child: Text(subLabel!),
            ),
        ],
      ),
    );
  }
}
