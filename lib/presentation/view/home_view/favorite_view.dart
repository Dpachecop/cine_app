import 'package:flutter/material.dart';

class FavoriteView extends StatelessWidget {
  static const name = 'Favorite_screen';
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoritos'),
      ),
      body: Center(
        child: Text('Favoritos'),
      ),
    );
  }
}
