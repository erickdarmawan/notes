import 'package:flutter/material.dart';
import 'package:notes/models/note.dart';

class AddNoteScreen extends StatefulWidget {
  final Function(Note note) addNoteFn;
  AddNoteScreen(this.addNoteFn);

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  Note _note =
      Note(id: '', title: '', note: '', updatedAt: null!, createdAt: null!);

  final _formKey = GlobalKey<FormState>();

  void submitNote() {
    _formKey.currentState?.save();
    final now = DateTime.now();
    _note = _note.copyWith(updatedAt: now, createdAt: now);
    widget.addNoteFn(_note);
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
                  _note = _note.copyWith(value.toString());
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                    hintText: 'Tulis catatan disini...',
                    border: InputBorder.none),
                onSaved: (value) {
                  _note.copyWith(value.toString());
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
