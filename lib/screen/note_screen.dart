import 'package:flutter/material.dart';
import 'package:note_app/item/note_item.dart';
import 'package:note_app/model/list_note.dart';
import 'package:note_app/viewModel/note_view_model.dart';

class NoteScreen extends StatefulWidget {
  @override
  _NoteScreenState createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('note'),
      ),
      body: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            ListNote listNote = snapshot.data;
            return listNote.notes.isEmpty
                ? Center(
                    child: Text('no data'),
                  )
                : ListView.builder(
                    itemBuilder: (context, position) {
                      return NoteItem(
                        edit: showEditDialog,
                        note: listNote.notes[position],
                      );
                    },
                    itemCount: listNote.notes.length,
                  );
          } else {
            return CircularProgressIndicator();
          }
        },
        future: NoteViewModel().getListNote(context),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddDialog();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  TextEditingController textNote = TextEditingController();

  void showAddDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: Container(
          width: double.maxFinite,
          child: TextField(
            controller: textNote,
            decoration: InputDecoration(labelText: 'Enter Note'),
          ),
        ),
        actions: [
          TextButton(
              onPressed: () {
                print('add');
                Note noteCreate = Note(noted: textNote.text);
                NoteViewModel().createNote(noteCreate, context, updateUI);
                Navigator.pop(context);
              },
              child: Text('ADD')),
          TextButton(
              onPressed: () {
                print('cancel');
                Navigator.pop(context);
                textNote.clear();
              },
              child: Text('CANCEL'))
        ],
      ),
    );
  }

  void showEditDialog(Note note) {
    textNote.text = note.noted;
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: Container(
          width: double.maxFinite,
          child: TextField(
            controller: textNote,
            decoration: InputDecoration(labelText: 'Enter Note'),
          ),
        ),
        actions: [
          TextButton(
              onPressed: () {



                NoteViewModel().updateNote(
                    Note(id: note.id, noted: textNote.text), context, updateUI);
                Navigator.pop(context);
              },
              child: Text('EDIT')),
          TextButton(
              onPressed: () {
                print('cancel');
                Navigator.pop(context);
                textNote.clear();
              },
              child: Text('CANCEL'))
        ],
      ),
    );
  }

  void updateUI() {
    setState(() {
      textNote.clear();
    });
  }
}
