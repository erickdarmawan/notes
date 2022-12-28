import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:notes/models/note.dart';

class NoteApi {
  Future<List<Note>> getAllNote() async {
    final uri = Uri.parse(
        'https://notes-a14a2-default-rtdb.asia-southeast1.firebasedatabase.app/note.json');
    List<Note> note = [];
    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final results = json.decode(response.body) as Map<String, dynamic>;
        results.forEach((key, value) {
          note.add(Note(
              id: key,
              title: value['title'],
              note: value['note'],
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
    return note;
  }

  Future<String?> postNote(Note note) async {
    final uri = Uri.parse(
        'https://notes-a14a2-default-rtdb.asia-southeast1.firebasedatabase.app/note.json');
    Map<String, dynamic> map = {
      'title': note.title,
      'note': note.note,
      'isPinned': note.isPinned,
      'updated_at':
          note.updatedAt == null ? null : note.updatedAt!.toIso8601String(),
      'created_at':
          note.createdAt == null ? null : note.createdAt!.toIso8601String(),
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
      throw const SocketException('Tidak dapat tersambung ke internet');
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
        'note': note.note,
        'updated_at': note.updatedAt?.toIso8601String(),
      };
      try {
        final body = json.encode(map);
        final response = await http.patch(uri, body: body);
        if (response.statusCode != 200) throw Exception();
      } on SocketException {
        throw const SocketException('Tidak dapat tersambung ke internet');
      } catch (e) {
        throw Exception('Error, terjadi kesalahan');
      }
    }
  }

  Future<void> toggleIsPinned(
      String id, bool isPinned, DateTime? updatedAt) async {
    final uri = Uri.parse(
        'https://notes-a14a2-default-rtdb.asia-southeast1.firebasedatabase.app/note/$id.json');
    Map<String, dynamic> map = {
      'isPinned': isPinned,
      'updated_at': updatedAt?.toIso8601String(),
    };
    final body = json.encode(map);
    final response = await http.patch(uri, body: body);
  }

  Future<void> deleteNote(String id) async {
    final uri = Uri.parse(
        'https://notes-a14a2-default-rtdb.asia-southeast1.firebasedatabase.app/note/$id.json');
    try {
      final response = await http.delete(uri);
      if (response.statusCode != 200) {
        throw Exception();
      }
    } on SocketException {
      throw const SocketException('Tidak dapat tersambung ke internet');
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
