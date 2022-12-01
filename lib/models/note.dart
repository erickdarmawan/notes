class Note {
  final String id;
  final String title;
  final String note;
  final DateTime updatedAt;
  final DateTime createdAt;
  bool isPinned;

  Note(
      {required this.id,
      required this.title,
      required this.note,
      required this.updatedAt,
      required this.createdAt,
      this.isPinned = false});

  Note copyWith({
    required String id,
    required String title,
    required String note,
    required DateTime updatedAt,
    required DateTime createdAt,
    required bool isPinned,
  }) {
    return Note(
      id: id == null ? this.id : id,
      title: title == null ? this.title : title,
      note: note == null ? this.note : note,
      updatedAt: updatedAt == null ? this.updatedAt : updatedAt,
      createdAt: createdAt == null ? this.createdAt : createdAt,
      isPinned: isPinned == null ? this.isPinned : isPinned,
    );
  }
}
