import 'package:cine_app/config/router/app_router.dart';
import 'package:cine_app/config/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'presentation/providers/Functions/theme_provider.dart';

Future<void> main() async {
  await dotenv.load(fileName: '.env');
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final themeMode = ref.watch(themeProvider);
        return MaterialApp.router(
          routerConfig: appRouter,
          theme: AppTheme().lightTheme, // Tema claro
          darkTheme: AppTheme().darkTheme, // Tema oscuro
          themeMode: themeMode, // Determina cuál tema usar
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
