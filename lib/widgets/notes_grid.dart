import 'package:flutter/material.dart';
import 'package:notes/providers/notes.dart';
import 'package:notes/widgets/note_item.dart';
import 'package:provider/provider.dart';
import '../models/note.dart';

class NotesGrid extends StatefulWidget {
  @override
  State<NotesGrid> createState() => _NotesGridState();
}

class _NotesGridState extends State<NotesGrid> {
  @override
  Widget build(BuildContext context) {
    final notesProvider = Provider.of<Notes>(context);
    List<Note> listNote = notesProvider.notes;
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GridView.builder(
        itemCount: listNote.length,
        itemBuilder: (ctx, index) => NoteItem(
          id: listNote[index].id,
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 1 / 2),
      ),
    );
  }
}
