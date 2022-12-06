import 'package:flutter/material.dart';
import 'package:notes/models/note.dart';
import 'package:notes/presentation/customicon_icons.dart';
import 'package:provider/provider.dart';
import 'package:notes/providers/notes.dart';
import '../screens/add_or_detail_screen.dart';

class NoteItem extends StatefulWidget {
  final String id;

  NoteItem({
    required this.id,
  });

  @override
  State<NoteItem> createState() => _NoteItemState();
}

class _NoteItemState extends State<NoteItem> {
  late bool _isPinned;

  @override
  Widget build(BuildContext context) {
    final notesProvider = Provider.of<Notes>(context, listen: false);
    Note note = notesProvider.getNote(widget.id);

    return Dismissible(
      key: Key(note.id),
      onDismissed: (direction) {
        notesProvider.deleteNote(note.id);
      },
      child: GestureDetector(
        onTap: () => Navigator.of(context)
            .pushNamed(AddOrDetailScreen.routeName, arguments: note.id),
        child: GridTile(
          header: Align(
              alignment: Alignment.topRight,
              child: IconButton(
                  onPressed: () {
                    notesProvider.toggleIsPinned(note.id);
                  },
                  icon: Icon(note.isPinned
                      ? Customicon.pin
                      : Customicon.pin_outline))),
          footer: ClipRRect(
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12)),
            child: GridTileBar(
              backgroundColor: Colors.black87,
              title: Text(note.title.toString()),
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey[800]),
            child: Text(note.notes),
            padding: const EdgeInsets.all(12),
          ),
        ),
      ),
    );
  }
}
