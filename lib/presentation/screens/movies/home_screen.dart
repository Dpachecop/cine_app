import 'package:cine_app/config/constants/themoviedbkey.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'Home_screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TEXTO GENERICO'),
      ),
      body: Center(
        child: Text(Enviroment.theMovieDbKey),
      ),
    );
  }
}
