import 'package:color_converter/components/theme.dart';
import 'package:color_converter/screens/initial_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: tema,
      home: const InitialScreen()
    );
  }
}