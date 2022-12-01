import 'package:flutter/material.dart';
import 'package:notes/presentation/customicon_icons.dart';

class NoteItem extends StatefulWidget {
  final String id;
  final String title;
  final String note;
  final bool isPinned;
  final Function(String id) toggleIsPinnedFn;
  NoteItem(
      {required this.id,
      required this.title,
      required this.note,
      required this.isPinned,
      required this.toggleIsPinnedFn});

  @override
  State<NoteItem> createState() => _NoteItemState();
}

class _NoteItemState extends State<NoteItem> {
  late bool _isPinned;

  @override
  Widget build(BuildContext context) {
    _isPinned = widget.isPinned;
    return GridTile(
      header: Align(
          alignment: Alignment.topRight,
          child: IconButton(
              onPressed: () {
                setState(() {
                  widget.toggleIsPinnedFn(widget.id);
                });
              },
              icon: Icon(_isPinned ? Customicon.pin : Customicon.pin_outline))),
      footer: ClipRRect(
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12)),
        child: GridTileBar(
          backgroundColor: Colors.black87,
          title: Text(widget.title),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey[800]),
        child: Text(widget.note),
        padding: const EdgeInsets.all(12),
      ),
    );
  }
}
