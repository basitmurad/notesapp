import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:notesapp/constants/colors.dart';
import 'package:notesapp/models/myNotes.dart';
import 'package:intl/intl.dart';
import 'package:notesapp/notesAdd.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<MyNotes> filter = [];
  List<MyNotes> sample = MyNotes.sampleNotes;
  bool sorted = false;
  FocusNode _searchFocusNode = FocusNode();

  @override
  void dispose() {
    // Dispose of the FocusNode when it's no longer needed
    _searchFocusNode.dispose();
    super.dispose();
  }

  _HomePageState() {
    sample = MyNotes.sampleNotes;
  }

  @override
  void initState() {
    super.initState();
    filter = sample;
  }

  void deleteNode(int index) {
    setState(() {
      MyNotes myNotes = filter[index];
      sample.remove(myNotes);
      filter.removeAt(index);
    });
  }

  List<MyNotes> sortNotesByModifiedTime(List<MyNotes> notes) {
    if (sorted) {
      notes.sort((a, b) => a.modifiedTime.compareTo(b.modifiedTime));
    } else {
      notes.sort((b, a) => a.modifiedTime.compareTo(b.modifiedTime));
    }

    sorted = !sorted;

    return notes;
  }

  void onSortButtonPress() {
    setState(() {
      filter = sortNotesByModifiedTime(filter);
    });
  }

  gerRandomColor() {
    Random random = Random();
    return backgroundColors[random.nextInt(backgroundColors.length)];
  }

  void onSearchTextChange(String textSearch) {
    setState(() {
      filter = sample
          .where((note) =>
              note.content!.toLowerCase().contains(textSearch.toLowerCase()) ||
              note.title!.toLowerCase().contains(textSearch.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Container(
        margin: EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Notes',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                    color: Colors.white,
                  ),
                ),
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: IconButton(
                    padding: EdgeInsets.all(0),
                    onPressed: () {
                      onSortButtonPress();
                    },
                    icon: Icon(Icons.sort),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Container(
              height: 50,
              margin: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 14),
              child: TextField(
                focusNode: _searchFocusNode,
                // Assign the FocusNode
                onTap: () {
                  _searchFocusNode.requestFocus();
                },
                onChanged: onSearchTextChange,
                maxLines: 1,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Search notes...',
                  hintStyle: TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: Colors.transparent,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: sample.length,
                itemBuilder: (context, index) {
                  if (index < filter.length) {
                    return Card(
                      color: gerRandomColor(),
                      margin: const EdgeInsets.only(
                          top: 4, left: 8, right: 8, bottom: 4),
                      child: ListTile(
                        onTap: () async {
                          final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      AddNotes()));
                        },

                        title: RichText(
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                            text: '${filter[index].title}\n',
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              height: 1.5,
                            ),
                            children: [
                              TextSpan(
                                text: '${filter[index].content}',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Edited: ${DateFormat('yyyy-MM-dd HH:mm:ss').format(filter[index].modifiedTime)}',
                            style: const TextStyle(
                              color: Colors.green,
                              fontSize: 12,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),

                        // subtitle: const Padding(
                        //   padding: EdgeInsets.all(8.0),
                        //   child:
                        //   Text(
                        //     'Edited: ${DateFormat('yyyy-MM-dd HH:mm:ss').format(filter[index].modifiedTime)}',
                        //     style: TextStyle(
                        //       color: Colors.green,
                        //       fontSize: 12,
                        //       fontStyle: FontStyle.italic,
                        //     ),
                        //   ),
                        // ),
                        trailing: IconButton(
                          onPressed: () async {
                            final result = await confirmDialog(context);
                            if (result != null && result) {
                              deleteNode(index);
                            }
                          },
                          icon: Icon(Icons.delete),
                        ),
                      ),
                    );
                  } else {
                    Container(
                      height: 100,
                      width: 100,
                      color: Colors.red,
                      child: const Text('Searching is empty'),
                    );
                  }
                },
              ),
            ),
            Container(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                onPressed: () async {
                  final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => AddNotes()));

                  if (result != null) {
                    setState(() {
                      // Use the correct list (sampleNotes) to store all notes
                      sample.add(MyNotes(
                        id: sample.length,
                        title: result[0],
                        content: result[1],
                        modifiedTime: DateTime.now(),
                      ));
                      filter = sample;
                    });
                  }
                },
                child: Icon(Icons.add),
                shape: CircleBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> confirmDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.grey.shade900,
            icon: const Icon(
              Icons.info,
              color: Colors.grey,
            ),
            title: const Text(
              'Are you sure you want to delete?',
              style: TextStyle(color: Colors.white),
            ),
            content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, true);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green),
                      child: const SizedBox(
                        width: 60,
                        child: Text(
                          'Yes',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      child: const SizedBox(
                        width: 60,
                        child: Text(
                          'No',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                ]),
          );
        });
  }
}
