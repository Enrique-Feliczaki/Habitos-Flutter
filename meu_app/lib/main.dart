import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/habitos_provider.dart';
import 'pages/home_page.dart';

// Mude estas cores para personalizar o app inteiro
const Color corPrincipal = Color(0xFF3F51B5); // índigo
const Color corDestaque = Color(0xFFFF9800); // laranja
const Color corFundo = Color(0xFFF3F4FB);

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => HabitosProvider(),
      child: const MeuApp(),
    ),
  );
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rastreador de Hábitos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: corPrincipal,
          secondary: corDestaque,
        ),
        scaffoldBackgroundColor: corFundo,
        appBarTheme: const AppBarTheme(
          backgroundColor: corPrincipal,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: corDestaque,
          foregroundColor: Colors.white,
        ),
        checkboxTheme: CheckboxThemeData(
          fillColor: WidgetStateProperty.resolveWith(
            (states) => states.contains(WidgetState.selected)
                ? corDestaque
                : null,
          ),
        ),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: corDestaque,
          circularTrackColor: Color(0xFFD9DCF2),
        ),
        cardTheme: const CardThemeData(
          color: Colors.white,
          elevation: 1,
        ),
      ),
      home: const HomePage(),
    );
  }
}