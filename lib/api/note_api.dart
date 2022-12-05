import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:notes/models/note.dart';

class NoteApi {
  Future<List<Note>> getAllNote() async {
    print('pertama dijalanin');
    final uri = Uri.parse(
        'https://notes-a14a2-default-rtdb.asia-southeast1.firebasedatabase.app/note.json');
    final response = await http.get(uri);
    final results = json.decode(response.body) as Map<String, dynamic>;
    print(response.body);
    List<Note> note = [];
    print(results['notes']);
    results.forEach(
      (key, value) {
        note.add(Note(
          id: key,
          title: value['title'],
          note: value['notes'],
          isPinned: value['isPinned'],
          updatedAt: DateTime.parse(value['updated_at']),
          createdAt: DateTime.parse(value['created_at']),
        ));
      },
    );
    return note;
  }

  Future<String?> postNote(Note note) async {
    final uri = Uri.parse(
        'https://notes-a14a2-default-rtdb.asia-southeast1.firebasedatabase.app/note.json');
    Map<String, dynamic> map = {
      'title': note.title,
      'note': note.note,
      'isPinned': note.isPinned,
      'updated_at': note.updatedAt?.toIso8601String(),
      'created_at': note.createdAt?.toIso8601String(),
    };
    final body = json.encode(map);
    final response = await http.post(uri, body: body);
    print(response.body);
    return json.decode(response.body)['name'];
  }

  Future<void> updateNote(Note note) async {
    Future<String?> postNote(Note note) async {
      final uri = Uri.parse(
          'https://notes-a14a2-default-rtdb.asia-southeast1.firebasedatabase.app/note/${note.id}.json');
      Map<String, dynamic> map = {
        'title': note.title,
        'note': note.note,
        'updated_at': note.updatedAt?.toIso8601String(),
      };
      final body = json.encode(map);
      final response = await http.patch(uri, body: body);
    }
  }

  Future<void> toggleIsPinned(
      String id, bool isPinned, DateTime updatedAt) async {
    final uri = Uri.parse(
        'https://notes-a14a2-default-rtdb.asia-southeast1.firebasedatabase.app/note/id.json');
    Map<String, dynamic> map = {
      'isPinned': isPinned,
      'updated_at': updatedAt.toIso8601String(),
    };
    final body = json.encode(map);
    final response = await http.patch(uri, body: body);
  }

  Future<void> deleteNote(String id) async {
    final uri = Uri.parse(
        'https://notes-a14a2-default-rtdb.asia-southeast1.firebasedatabase.app/note/id.json');

    final response = await http.delete(uri);
  }
}
