import 'package:cine_app/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'Home_screen';

  final Widget selectedView; // Vista actual
  final int currentIndex; // Índice actual
  final void Function(int) onTabSelected; // Función para cambiar pestañas

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
