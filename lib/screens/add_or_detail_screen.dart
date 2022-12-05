import 'package:flutter/material.dart';
import 'package:notes/models/note.dart';
import 'package:provider/provider.dart';
import 'package:notes/providers/notes.dart';
import 'package:intl/intl.dart';

class AddOrDetailScreen extends StatefulWidget {
  static const routeName = '/addOrDetailScreen';
  @override
  State<AddOrDetailScreen> createState() => _AddOrDetailScreenState();
}

class _AddOrDetailScreenState extends State<AddOrDetailScreen> {
  Note _note =
      Note(id: '', title: '', note: '', updatedAt: null, createdAt: null);

  final _formKey = GlobalKey<FormState>();

  bool init = true;

  void submitNote() {
    _formKey.currentState?.save();
    final now = DateTime.now();
    _note = _note.copyWith(updatedAt: now, createdAt: now);
    final notesProvider = Provider.of<Notes>(context, listen: false);
    if (_note.id == null) {
      notesProvider.addNote(_note);
    } else {
      notesProvider.updateNote(_note);
    }

    Navigator.of(context).pop();
  }

  @override
  void didChangeDependencies() {
    if (init) {
      String id = ModalRoute.of(context)?.settings.arguments as String;
      if (id != null) {
        _note = Provider.of<Notes>(context).getNote(id);
      }
      _note = Provider.of<Notes>(context).getNote(id);
      init = false;
    }
    super.didChangeDependencies();
  }

  String _convertDate(DateTime? dateTime) {
    int diff = DateTime.now().difference(dateTime!).inDays;
    if (diff < 0) return DateFormat('dd-MM-yyyy').format(dateTime);
    return DateFormat('hh:mm').format(dateTime);
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
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            padding: EdgeInsets.all(12),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: _note.title,
                      decoration: InputDecoration(
                        hintText: 'Judul',
                        border: InputBorder.none,
                      ),
                      onSaved: (value) {
                        _note = _note.copyWith(title: value);
                      },
                    ),
                    TextFormField(
                      initialValue: _note.note,
                      decoration: InputDecoration(
                          hintText: 'Tulis catatan disini...',
                          border: InputBorder.none),
                      maxLines: null,
                      onSaved: (value) {
                        _note = _note.copyWith(note: value);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (_note.updatedAt != null)
            Positioned(
                right: 10,
                bottom: 10,
                child:
                    Text('Terakhir dirubah ${_convertDate(_note.updatedAt)}')),
        ],
      ),
    );
  }
}
