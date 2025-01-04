import 'package:flutter/material.dart';

class FullLoaderScreen extends StatelessWidget {
  const FullLoaderScreen({super.key});

  Stream<String> getLoadingMessages() {
    List<String> movieMessages = [
      "El rugido de Godzilla se hizo con un contrabajo.",
      "El tiburón de 'Jaws' se llamaba Bruce.",
      "'The Lion King' casi se llamó 'King of the Jungle'.",
      "Tom Hanks no cobró por 'Forrest Gump', ganó por porcentaje.",
      "La máscara de Michael Myers es de 'Star Trek'.",
      "James Cameron esperó 10 años para hacer 'Avatar'.",
      "'Gandhi' usó 300,000 extras en el funeral.",
      "Will Smith rechazó 'The Matrix'.",
      "La sangre en 'Psycho' era jarabe de chocolate.",
      "Hugh Jackman fue Wolverine por 17 años.",
      "Heath Ledger improvisó en 'The Dark Knight'.",
      "Esto tardo mas de lo esperado, un momento..."
    ];

    return Stream.periodic(const Duration(milliseconds: 1500), (step) {
      return movieMessages[step];
    }).take(movieMessages.length);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Su peli anda cargando...'),
            const SizedBox(
              height: 20,
            ),
            const CircularProgressIndicator(
              strokeWidth: 2,
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: SizedBox(
                width: 300,
                child: StreamBuilder(
                  stream: getLoadingMessages(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    return !snapshot.hasData
                        ? const Text('cargando')
                        : Text(snapshot.data);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
