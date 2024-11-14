import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme.bodyLarge;

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
                  IconButton(onPressed: () {}, icon: const Icon(Icons.search))
                ],
              ),
            )));
  }
}
