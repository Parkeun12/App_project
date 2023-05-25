import 'package:app_project/const/colors.dart';
import 'package:flutter/material.dart';

class Note {
  final String content;

  Note(this.content);
}

class MemoScreen extends StatefulWidget {
  final int number;

  const MemoScreen({required this.number, Key? key}) : super(key: key);

  @override
  _MemoScreenState createState() => _MemoScreenState();
}

class _MemoScreenState extends State<MemoScreen> {
  List<Note> notes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Image.asset(
          'lib/asset/logo2.png',
          width: 100,
          height: 100,
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              final note = notes[index];
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
                child: GestureDetector(
                  onTap: () {
                    _showNoteContent(note.content);
                  },
                  child: Card(
                    color: Colors.white,
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: Colors.grey.shade300, width: 1.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              note.content,
                              maxLines: 2, // Set max lines to show
                              overflow: TextOverflow.ellipsis, // Show ellipsis when text overflows
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              _deleteNoteAtIndex(index);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          Positioned(
            bottom: 16.0,
            right: 16.0,
            child: FloatingActionButton(
              backgroundColor: MAIN_COLOR,
              onPressed: () {
                _showAddNoteDialog();
              },
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddNoteDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newNote = '';
        return AlertDialog(
          content: TextField(
            onChanged: (value) {
              newNote = value;
            },
            maxLines: 5, // Allow multiple lines
            decoration: InputDecoration(
              border: InputBorder.none, // Remove underline
            ),
          ),
          actions: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8, // 80% of the screen width
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: MAIN_COLOR, // Change button color to yellow
                      ),
                      onPressed: () {
                        setState(() {
                          notes.add(Note(newNote));
                        });
                        Navigator.pop(context);
                      },
                      child: Text('Save'),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _showNoteContent(String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Note Content'),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _deleteNoteAtIndex(int index) {
    setState(() {
      notes.removeAt(index);
    });
  }
}