import 'dart:convert';
import 'package:appcrudflutter/src/crud_one/models/api_response.dart';
import 'package:appcrudflutter/src/crud_one/models/note.dart';
import 'package:appcrudflutter/src/crud_one/models/note_insert.dart';
import 'package:appcrudflutter/src/crud_one/models/note_read.dart';
import 'package:http/http.dart' as http;

class NoteService{

  String url = 'https://tq-notes-api-jkrgrdggbq-el.a.run.app';
  static const header ={
    'apiKey':'77999aa3-9912-4ffe-b6d6-fddf476013a2',
    'Content-Type':'application/json'
  };
  final List<Note> noteList = [];

  Future<APIResponse> getListNotes() async{
    var uri =Uri.parse(url+'/notes');
    final resp = await http.get(uri,headers:header);
  
    if(resp.statusCode == 200){
      final jsonResponse = jsonDecode(resp.body);
      
      for(var item in jsonResponse){
        noteList.add(Note.fromJson(item));
      }
      return APIResponse(
        data:noteList,
        error:false,
        errorMensaje:'',
      );
    }
    return APIResponse(
      data:noteList,
      error:true,
      errorMensaje:'Ocurred an Error',
    );
  }
  

  
  Future<APIResponse> getNote(String noteID) async{
    
    var uri =Uri.parse(url+'/notes/'+noteID);
    final resp = await http.get(uri,headers:header);
  
    if(resp.statusCode == 200){
      final jsonResponse = jsonDecode(resp.body);
      return APIResponse(
        data:NoteReade.fromJson(jsonResponse),
        error:false,
        errorMensaje:'',
      );
    }

    return APIResponse(
      data:null,
      error:true,
      errorMensaje:'Ocurred an Error',
    );
  }

  Future<APIResponse<bool>> createNote(NoteInsert noteInsert) async{

    var uri =Uri.parse(url+'/notes');
    final resp = await http.post(uri,
      headers:header,
      body: jsonEncode(noteInsert.toJson()),
    );
  
    if(resp.statusCode == 201){
      return APIResponse<bool>(
        data:true,
        error:false,
        errorMensaje:'',
      );
    }

    return APIResponse<bool>(
      data:false,
      error:true,
      errorMensaje:'Ocurred an Error',
    );
  }

  
  Future<APIResponse<bool>> updateNote(String noteId, NoteInsert noteInsert) async{
     
    var uri =Uri.parse(url+'/notes/'+noteId);
    final resp = await http.put(uri,
      headers:header,
      body: jsonEncode(noteInsert.toJson()),
    );
  
    if(resp.statusCode == 204){
      return APIResponse<bool>(
        data:true,
        error:false,
        errorMensaje:'Update sussful',
      );
    }

    return APIResponse<bool>(
      data:false,
      error:true,
      errorMensaje:'Ocurred an Error',
    );
  }

    Future<APIResponse<bool>> deleteNote(String noteId) async{
     
    var uri =Uri.parse(url+'/notes/'+noteId);
    final resp = await http.delete(uri,
      headers:header,
    );
  
    if(resp.statusCode == 204){
      return APIResponse<bool>(
        data:true,
        error:false,
        errorMensaje:'Delate susseful',
      );
    }

    return APIResponse<bool>(
      data:false,
      error:true,
      errorMensaje:'Ocurred an Error',
    );
  }

}