import 'package:flutter/material.dart';
import 'package:notes/models/note.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  Note _note =
      Note(id: '', title: '', note: '', updatedAt: null, createdAt: null);

  void submitNote() {
    print('title: ' + _note.title);
    print(_note.note);
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
                  _note.copyWith(note: value);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
