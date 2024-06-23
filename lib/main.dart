import 'package:flutter/material.dart';
import 'package:scheduler_app/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Scheduler App',
        theme:
            ThemeData(brightness: Brightness.dark, primaryColor: Colors.black),
        home: const HomePage());
  }
}
