import 'package:animate_do/animate_do.dart';
import 'package:cine_app/config/Helpers/human_formats.dart';
import 'package:cine_app/domain/entities/movie.dart';
import 'package:flutter/material.dart';

class HorizontalMovieSlideview extends StatefulWidget {
  final List<Movie> movies;
  final String? label;
  final String? subLabel;
  final VoidCallback? loadNextpage;

  const HorizontalMovieSlideview(
      {super.key,
      required this.movies,
      this.label,
      this.subLabel,
      this.loadNextpage});

  @override
  State<HorizontalMovieSlideview> createState() =>
      _HorizontalMovieSlideviewState();
}

class _HorizontalMovieSlideviewState extends State<HorizontalMovieSlideview> {
  final scrolllController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrolllController.addListener(
      () {
        if (widget.loadNextpage == null) return;

        //   print(scrolllController.position.maxScrollExtent);

        if ((scrolllController.position.pixels + 500) >=
            scrolllController.position.maxScrollExtent) {
          // print("LLAMADO DEL LOADNEXTPAGE");
          widget.loadNextpage!();
        }
      },
    );
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
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              controller: scrolllController,
              itemCount: widget.movies.length,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return _Slide(movie: widget.movies[index]);
              },
            ),
          )
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Movie movie;
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

                  return FadeIn(child: child);
                },
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),

          //* TITULO
          SizedBox(
            width: 150,
            child: Text(
              movie.title,
              maxLines: 2,
              style: textstyle.titleSmall,
            ),
          ),
          // RATING
          Row(
            children: [
              const Icon(
                Icons.star_half_outlined,
                color: Colors.amber,
              ),
              Text(
                HumanFormats.Humanformats(movie.voteAverage),
                style: textstyle.bodyMedium?.copyWith(color: Colors.amber),
              )
            ],
          )
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final String? label;
  final String? subLabel;

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
