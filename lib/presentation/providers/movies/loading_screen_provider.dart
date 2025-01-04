import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers.dart';

final loadingScreenProvider = Provider<bool>(
  (ref) {
    final s1 = ref.watch(nowPlayingMoviesProvider).isEmpty;
    final s2 = ref.watch(popularMoviesProvider).isEmpty;
    final s3 = ref.watch(upComingMoviesProvider).isEmpty;
    final s4 = ref.watch(topRatedMoviesProvider).isEmpty;

    return (s1 || s2 || s3 || s4) ? true : false;
  },
);
