import 'package:flutter/material.dart';

class CustomBotttomNavigation extends StatelessWidget {
  final int currentIndex; // Índice actual

  final void Function(int) onTabSelected; // Función para cambiar pestañas

  const CustomBotttomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex, // Marca la pestaña activa
      onTap: onTabSelected, // Cambia pestañas
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_max_outlined),
          label: 'Inicio',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.thumb_up_off_alt),
          label: 'Popular',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border_rounded),
          label: 'Favoritos',
        ),
      ],
    );
  }
}
