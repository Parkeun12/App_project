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
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              // Delete memo functionality
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              final note = notes[index];
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
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
                        Expanded(child: Text(note.content)),
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
              );
            },
          ),
          Positioned(
            bottom: 16.0,
            right: 16.0,
            child: FloatingActionButton(
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
          title: Text('Add Note'),
          content: TextField(
            onChanged: (value) {
              newNote = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  notes.add(Note(newNote));
                });
                Navigator.pop(context);
              },
              child: Text('Save'),
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