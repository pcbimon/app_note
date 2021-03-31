import 'dart:io';

import 'package:http/http.dart';
import 'package:note_app/model/list_note.dart';
import 'dart:convert';

class NoteService {
  static String baseUrl() {
    if (Platform.isAndroid) {
      return "http://10.0.2.2:8080";
    } else {
      return "http://localhost:8080";
    }
  }

  Future<Response> getListNote() async {
    Response response = await post(Uri.parse("${baseUrl()}/list"));
    return response;
  }

  Future<Response> createNote(Note note) async {
    Response response = await post(Uri.parse("${baseUrl()}/create"),
        headers: {"Content-Type": "application/json"},
        body: json.encode(note.toJson()));
    return response;
  }

  Future<Response> updateNote(Note note) async {
    Response response = await post(Uri.parse("${baseUrl()}/update"),
        headers: {"Content-Type": "application/json"},
        body: json.encode(note.toJson()));
    return response;
  }

  Future<Response> deleteNote(Note note) async {
    Response response = await post(Uri.parse("${baseUrl()}/delete"),
        headers: {"Content-Type": "application/json"},
        body: json.encode(note.toJson()));
    return response;
  }
}
