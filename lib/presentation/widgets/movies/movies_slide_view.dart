import 'package:animate_do/animate_do.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:cine_app/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MoviesSlideView extends StatelessWidget {
  final List<Movie> movies;
  const MoviesSlideView({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return GestureDetector(
      child: SizedBox(
        height: 210,
        width: double.infinity,
        child: Swiper(
          autoplay: true,
          curve: Curves.decelerate,
          scale: 0.9,
          pagination: SwiperPagination(
            builder: DotSwiperPaginationBuilder(
                activeColor: colors.primary, color: colors.secondary),
            margin: const EdgeInsets.only(top: 0),
          ),
          viewportFraction: 0.8,
          itemCount: movies.length,
          itemBuilder: (context, index) => _Slide(movie: movies[index]),
        ),
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Movie movie;
  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {
    final decoration = BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
              color: Colors.black45, blurRadius: 10, offset: Offset(0, 10))
        ]);

    return GestureDetector(
      onTap: () {
        context.push('/movie/${movie.id}');
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: DecoratedBox(
          decoration: decoration,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              movie.backdropPath,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress != null) {
                  return const DecoratedBox(
                      decoration: BoxDecoration(color: Colors.black45));
                }
                return FadeIn(child: child);
              },
            ),
          ),
        ),
      ),
    );
  }
}
