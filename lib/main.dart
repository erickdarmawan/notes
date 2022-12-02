import 'package:flutter/material.dart';
import 'package:notes/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:notes/providers/notes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Notes(),
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData.dark(),
          home: const HomeScreen()),
    );
  }
}
