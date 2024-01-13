import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:notesapp/models/myNotes.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

List<MyNotes> sample =[];
_HomePageState() {
  sample = MyNotes.sampleNotes;
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body:
      Container(
        margin: EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
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
                    onPressed: () {},
                    icon: Icon(Icons.sort),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              height: 50,
              margin:
              EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 14),
              child: TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Search...',
                  hintStyle: TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: Colors.transparent,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Colors.green),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: sample.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.only(
                        top: 4, left: 8, right: 8, bottom: 4),
                    child: ListTile(
                      title: RichText(
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                          text: '${sample[index].title}\n',
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            height: 1.5,
                          ),
                          children: [
                            TextSpan(
                              text: '${sample[index].content}',
                              style: const TextStyle(
                                color: Colors.black,

                                fontSize: 14,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      subtitle: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Edited: 20/20/2024 ',
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 12,
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                      trailing: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.delete),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                onPressed: () {},
                child: Icon(Icons.add),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

