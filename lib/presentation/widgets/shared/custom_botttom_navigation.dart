import 'package:flutter/material.dart';

class CustomBotttomNavigation extends StatelessWidget {
  const CustomBotttomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.home_max_outlined), label: 'Inicio'),
        BottomNavigationBarItem(
            icon: Icon(Icons.category_outlined), label: 'Categoria'),
        BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border_rounded), label: 'Fvoritas'),
      ],
    );
  }
}
