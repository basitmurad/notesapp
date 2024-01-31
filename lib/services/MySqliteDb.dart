import 'package:notesapp/models/Note.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {
  static const int VERSION = 1;
  static const String DBNAME = "Notes.Db";

  static Future<Database> getDate() async {
    return openDatabase(join(await getDatabasesPath(), DBNAME),
        onCreate: (db, version) async => await db.execute(
            "CREATE TABLE NOTE (id INTEGER PRIMARY KEY, title  TEXT NOT NULL ,  description NOT NULL);"),
        version: VERSION);
  }

  static Future<int> addNote(Note note ) async
  {
    final db = await getDate();
    return await db.insert("Note", note.toJson(),conflictAlgorithm: ConflictAlgorithm.replace);
  }


  static Future<int> updateNote(Note note ) async
  {
    final db = await getDate();
    return await db.update("Note", note.toJson(),
        where: 'id=?' ,
        whereArgs: [note.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> deleteNote(Note note) async {
    try {
      final db = await getDate();
      return await db.delete(
        "Note",
        where: 'id = ?',
        whereArgs: [note.id],
      );
    } catch (e) {
      print("Error deleting note: $e");
      return -1; // Return a negative value to indicate an error
    }
  }


  static Future<List<Note>?> getAllNotes() async {
    final Database db = await getDate();
    final List<Map<String, dynamic>> maps = await db.query('Note');

    if(maps.isEmpty)
      {
        return null;
      }



    return List.generate(maps.length, (index) => Note.fromJson(maps[index]));

  }

}
