import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:notes/models/note.dart';

class NoteApi {
  Future<List<Note>> getAllNote() async {
    print('pertama dijalanin');
    final uri = Uri.parse(
        'https://notes-a14a2-default-rtdb.asia-southeast1.firebasedatabase.app/note.json');
    List<Note> notes = [];
    try {
      final response = await http.get(uri);

      print(response.statusCode);
      if (response.statusCode == 200) {
        final results = json.decode(response.body) as Map<String, dynamic>;
        results.forEach((key, value) {
          notes.add(Note(
              id: key,
              title: value['title'],
              notes: value['notes'],
              isPinned: value['isPinned'],
              updatedAt: DateTime.parse(value['updated_at']),
              createdAt: DateTime.parse(value['created_at'])));
        });
      } else {
        throw Exception();
      }
    } on SocketDirection {
      throw SocketException('Tidak dapat tersambung ke internet');
    } catch (e) {
      throw Exception('Error, terjadi kesalahan');
    }
    return notes;
  }

  Future<String?> postNote(Note note) async {
    final uri = Uri.parse(
        'https://notes-a14a2-default-rtdb.asia-southeast1.firebasedatabase.app/note.json');
    Map<String, dynamic> map = {
      'title': note.title,
      'note': note.notes,
      'isPinned': note.isPinned,
      'updated_at': note.updatedAt?.toIso8601String(),
      'created_at': note.createdAt?.toIso8601String(),
    };
    try {
      final body = json.encode(map);
      final response = await http.post(uri, body: body);
      print(response.body);
      if (response.statusCode == 200) {
        return json.decode(response.body)['name'];
      } else {
        throw Exception();
      }
    } on SocketException {
      throw SocketException('Tidak dapat tersambung ke internet');
    } catch (e) {
      throw Exception('Error, terjadi kesalahan');
    }
  }

  Future<void> updateNote(Note note) async {
    Future<String?> postNote(Note note) async {
      final uri = Uri.parse(
          'https://notes-a14a2-default-rtdb.asia-southeast1.firebasedatabase.app/note/${note.id}.json');
      Map<String, dynamic> map = {
        'title': note.title,
        'note': note.notes,
        'updated_at': note.updatedAt?.toIso8601String(),
      };
      try {
        final body = json.encode(map);
        final response = await http.patch(uri, body: body);
        if (response.statusCode != 200) throw Exception();
      } on SocketException {
        throw SocketException('Tidak dapat tersambung ke internet');
      } catch (e) {
        throw Exception('Error, terjadi kesalahan');
      }
    }
  }

  Future<void> toggleIsPinned(
      String id, bool isPinned, DateTime? updatedAt) async {
    final uri = Uri.parse(
        'https://notes-a14a2-default-rtdb.asia-southeast1.firebasedatabase.app/note/id.json');
    Map<String, dynamic> map = {
      'isPinned': isPinned,
      'updated_at': updatedAt?.toIso8601String(),
    };
    final body = json.encode(map);
    final response = await http.patch(uri, body: body);
  }

  Future<void> deleteNote(String id) async {
    final uri = Uri.parse(
        'https://notes-a14a2-default-rtdb.asia-southeast1.firebasedatabase.app/note/id.json');
    try {
      final response = await http.delete(uri);
      if (response.statusCode != 200) {
        throw Exception();
      }
    } on SocketException {
      throw SocketException('Tidak dapat tersambung ke internet');
    } catch (e) {
      throw Exception('Error, terjadi kesalahan');
    }
  }

  Future<void> toogleIsPinned(
      String id, bool isPinned, DateTime updatedAt) async {
    final uri = Uri.parse(
        'https://notes-a14a2-default-rtdb.asia-southeast1.firebasedatabase.app/note/$id.json');
    Map<String, dynamic> map = {
      'isPinned': isPinned,
      'updated_at': updatedAt.toIso8601String(),
    };
    try {
      final body = json.encode(map);
      final response = await http.patch(uri, body: body);
    } catch (e) {
      throw Exception('Error, terjadi kesalahan');
    }
  }
}
