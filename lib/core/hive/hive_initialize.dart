import 'package:flutter_notes_and_api_test/data/model/note_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> initHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(NoteModelAdapter());
}
