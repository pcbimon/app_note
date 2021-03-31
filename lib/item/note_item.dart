import 'package:flutter/material.dart';

import '../model/list_note.dart';

class NoteItem extends StatelessWidget {
  Note note;
  Function edit;
  NoteItem({@required note, @required edit}) {
    this.note = note;
    this.edit = edit;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue,
      child: ListTile(
        title: Text(
          note.noted,
          style: TextStyle(color: Colors.white),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  print('edit');
                  edit(note);
                }),
            IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  print('delete');
                }),
          ],
        ),
      ),
    );
  }
}
