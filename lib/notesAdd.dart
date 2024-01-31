
import 'package:flutter/material.dart';
import 'package:notesapp/models/Note.dart';
import 'package:notesapp/services/MySqliteDb.dart';

class AddNotes extends StatefulWidget {
  final Note? note;
  const AddNotes({super.key, this.note});

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    if (widget.note != null) {
      _titleController = TextEditingController(text: widget.note!.title);
      _contentController = TextEditingController(text: widget.note!.description);
    }

    super.initState();
  }
  @override
  Widget build(BuildContext context) {






    return Scaffold(
      backgroundColor: Colors.grey,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
        child:

        Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  padding: const EdgeInsets.all(0),
                  icon: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade800.withOpacity(.8),
                        borderRadius: BorderRadius.circular(10)),
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                    ),
                  ))
            ],
          ),
          Expanded(
              child: ListView(
                children: [
                  TextField(
                    controller: _titleController,
                    style: const TextStyle(color: Colors.white, fontSize: 30),
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Title',
                        hintStyle: TextStyle(color: Colors.white, fontSize: 30)),
                  ),
                  TextField(
                    controller: _contentController,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    maxLines: null,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Type something here',
                        hintStyle: TextStyle(
                          color: Colors.white,
                        )),
                  ),
                ],
              ))
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
       if(_contentController.text.isEmpty || _titleController.text.isEmpty)
         {
           print('Enter title ');
         }
       else{
         Navigator.pop(context, [_titleController.text, _contentController.text]);

         Note updatedNote = Note(
           id: widget.note?.id, // Use the existing ID if it's an update
           title: _titleController.text,
           description: _contentController.text,
         );

         if (widget.note != null) {
           // If it's an existing note, update it
           DbHelper.updateNote(updatedNote);
         } else {
           // If it's a new note, add it
           DbHelper.addNote(updatedNote);
         }
       }

          print('Note is saved');
          // print(updatedNote.title);
          // print(updatedNote.description);
        },
        elevation: 10,
        backgroundColor: Colors.grey.shade800,
        child: const Icon(Icons.save),
      ),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.pop(
      //         context, [_titleController.text, _contentController.text]);
      //     Note note = Note(id: 1, title:_titleController.text, description: _contentController.text);
      //
      //     DbHelper.addNote(note);
      //
      //
      //     print('Note is saved');
      //     print(note.title);
      //     print(note.description);
      //   },
      //   elevation: 10,
      //   backgroundColor: Colors.grey.shade800,
      //   child: const Icon(Icons.save),
      // ),
    );  }
}
