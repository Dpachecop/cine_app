import 'package:cine_app/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'Home_screen';

  final Widget selectedView; // Vista actual
  final int currentIndex; // Índice actual
  final void Function(int) onTabSelected; // Función para cambiar pestañas

  void onItemTapped(BuildContext context, int index) {
    // context.go('');
    switch (index) {
      case 0:
        context.go('/');
        break;

      case 1:
        context.go('/categories');
        break;

      case 2:
        context.go('/favorites');
        break;
    }
  }

  const HomeScreen({
    super.key,
    required this.selectedView,
    required this.currentIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: selectedView, // Vista seleccionada
      bottomNavigationBar: CustomBotttomNavigation(
        currentIndex: currentIndex,
        onTabSelected: onTabSelected,
      ),
    );
  }
}
