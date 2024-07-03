import 'package:calculadora_imc/colors/app_colors.dart';
import 'package:calculadora_imc/imc_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const HomePage());
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          appBarTheme: const AppBarTheme(backgroundColor: AppColors.pretoP)),
      home: Scaffold(
          backgroundColor: AppColors.pretoP,
          appBar: AppBar(
            title: const Text(
              'Calculadora IMC',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          body: const ImcPage()),
    );
  }
}
