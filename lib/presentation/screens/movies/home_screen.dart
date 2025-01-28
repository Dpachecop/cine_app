import 'package:cine_app/presentation/providers/providers.dart';
import 'package:cine_app/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'Home_screen';

  final Widget selectedView;
  const HomeScreen({super.key, required this.selectedView});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: selectedView,
      bottomNavigationBar: const CustomBotttomNavigation(),
    );
  }
}
