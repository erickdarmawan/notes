import 'package:flutter/material.dart';
import 'package:notes/models/note.dart';
import 'package:provider/provider.dart';
import 'package:notes/providers/notes.dart';

class AddNoteScreen extends StatefulWidget {
  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  Note _note =
      Note(id: '', title: '', note: '', updatedAt: null, createdAt: null);

  final _formKey = GlobalKey<FormState>();

  void submitNote() {
    _formKey.currentState?.save();
    final now = DateTime.now();
    _note = _note.copyWith(updatedAt: now, createdAt: now);
    final notesProvider = Provider.of<Notes>(context, listen: false);
    notesProvider.addNote(_note);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        TextButton(
          onPressed: submitNote,
          child: Text('Simpan'),
        )
      ]),
      body: Container(
        padding: EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Judul',
                  border: InputBorder.none,
                ),
                onSaved: (value) {
                  _note = _note.copyWith(title: value);
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                    hintText: 'Tulis catatan disini...',
                    border: InputBorder.none),
                onSaved: (value) {
                  _note = _note.copyWith(note: value);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
