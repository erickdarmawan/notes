import 'package:flutter/material.dart';

import 'package:notes/screens/add_note_screen.dart';
import 'package:notes/widgets/notes_grid.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
      ),
      body: NotesGrid(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (builder) => const AddNoteScreen()));
        },
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}
