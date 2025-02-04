import 'package:cine_app/presentation/view/movie/home_view.dart';
import 'package:cine_app/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final int pageIndex;

  List<Widget> views = [
    HomeView(),
  ];
  static const name = 'Home_screen';
  HomeScreen({super.key, required this.pageIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: pageIndex, children: views),
      bottomNavigationBar: const CustomBotttomNavigation(),
    );
  }
}
