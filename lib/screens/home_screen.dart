import 'package:flutter/material.dart';
import 'package:notes/screens/add_or_detail_screen.dart';
import 'package:notes/widgets/notes_grid.dart';
import 'package:provider/provider.dart';
import '../providers/notes.dart';

class HomeScreen extends StatefulWidget {
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
      body: FutureBuilder(
        future: Provider.of<Notes>(context, listen: false).getAndSetNotes(),
        builder: (context, notesSnapshot) {
          if (notesSnapshot.connectionState == ConnectionState.waiting)
            return const Center(
              child: const CircularProgressIndicator(),
            );
          if (notesSnapshot.hasError) {
            return Center(
              child: Text(notesSnapshot.error.toString()),
            );
          }
          return NotesGrid();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AddOrDetailScreen.routeName);
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
