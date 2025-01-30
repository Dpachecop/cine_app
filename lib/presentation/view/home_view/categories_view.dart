import 'package:flutter/material.dart';

class CategoriesView extends StatelessWidget {
  static const name = 'Categories_screen';
  const CategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoritos'),
      ),
      body: Center(
        child: Text('Categorias'),
      ),
    );
  }
}
