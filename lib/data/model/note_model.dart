import 'package:hive/hive.dart';

part 'note_model.g.dart';

@HiveType(typeId: 0)
class NoteModel extends HiveObject {
  NoteModel({
    required this.id,
    required this.noteName,
    required this.noteDescription,
    this.category,
    this.isFinished = false,
  });

  @HiveField(0)
  int id;

  @HiveField(1)
  String noteName;

  @HiveField(2)
  String noteDescription;

  @HiveField(3)
  String? category;

  @HiveField(4)
  bool isFinished;

  void saveChanges() {
    save();
  }
}
