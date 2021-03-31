import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:note_app/model/list_note.dart';
import 'package:note_app/network/note_service.dart';

class NoteViewModel {
  Future<ListNote> getListNote(BuildContext context) async {
    ListNote listNote;
    Response response = await NoteService().getListNote();
    print("Status Code ${response.statusCode}");
    print("Data ${response.body}");
    if (response.statusCode == 200) {
      listNote = ListNote.fromJson(json.decode(response.body));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("error")));
    }
    return listNote;
  }

  void createNote(Note note, BuildContext context, Function update) {
    NoteService().createNote(note).then((value) {
      Response response = value;
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('create data success'),
            duration: Duration(seconds: 1),
          ),
        );
      } else {}
      update();
    });
  }

  void updateNote(Note note, BuildContext context, Function update) {
    NoteService().updateNote(note).then((value) {
      Response response = value;
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('update data success'),
            duration: Duration(seconds: 1),
          ),
        );
      } else {}
      update();
    });
  }
}
