import 'package:appcrudflutter/src/crud_one/models/note_insert.dart';
import 'package:appcrudflutter/src/crud_one/models/note_read.dart';
import 'package:appcrudflutter/src/crud_one/services/note_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../models/api_response.dart';

class NoteModify extends StatefulWidget {

  final String? noteId; 
  // ignore: use_key_in_widget_constructors
  const NoteModify({this.noteId});

  @override
  State<NoteModify> createState() => _NoteModifyState();
}

class _NoteModifyState extends State<NoteModify> {
  late APIResponse _apiResponse; 
  late NoteService _service;
  late NoteReade _noteReade;
  bool _isLoading = false;
  
  bool get isEditing => widget.noteId != null;
 // bool _isLoading(); 

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  void getService() async {
     setState(() {
       _isLoading = true;
     });
    _apiResponse = await _service.getNote(widget.noteId as String);
    if(!_apiResponse.error){
      _noteReade = _apiResponse.data as NoteReade;
      _titleController.text = _noteReade.noteTitle;
      _contentController.text = _noteReade.noteContent;
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    _service = GetIt.instance<NoteService>();
    
    if(isEditing){
      getService();
    }
    
    super.initState();
  }
  
  @override
  void dispose() {
    _contentController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Note' : 'Create Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: (_isLoading)
        ? const Center(child:CircularProgressIndicator())
        :Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                hintText: 'Note Tile'
              ),
            ),
            Container(height: 8),
            TextField(
              controller: _contentController,
              decoration:const InputDecoration(
                hintText: 'Note Content'
              ),
            ),
            Container(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  if(isEditing){
                    final _noteIsert = NoteInsert(
                      noteTitle: _titleController.text, 
                      noteContent: _contentController.text
                    );
                    setState(() {
                      _isLoading = true;
                    }); 
                    final result = await _service.updateNote(widget.noteId as String,_noteIsert);
                    const _title = 'Done';
                    final _textMessage = result.error ? (result.errorMensaje): 'Your note was update ?';
                    setState(() {
                      _isLoading = false;
                    }); 
                    showDialog(
                      context: context, 
                      builder: (_)=> AlertDialog(
                        title: const Text(_title),
                        content: Text(_textMessage),
                        actions: [
                          TextButton(
                            onPressed:(){
                              Navigator.of(context).pop();
                            }, 
                            child: const Text('OK')
                            ),
                        ],
                      )
                    ).then((value){
                      if(result.data ?? false){
                        Navigator.of(context).pop(true);
                      }
                    });
                     
                  }else{

                    final _noteIsert = NoteInsert(
                      noteTitle: _titleController.text, 
                      noteContent: _contentController.text
                    );
                   setState(() {
                     _isLoading = true;
                   }); 
                   final result = await _service.createNote(_noteIsert);
                   const _title = 'Done';
                   final _textMessage = result.error ? (result.errorMensaje): 'Your note was created ?';
                   setState(() {
                     _isLoading = false;
                   }); 
                   showDialog(
                     context: context, 
                     builder: (_)=> AlertDialog(
                       title: const Text(_title),
                       content: Text(_textMessage),
                       actions: [
                         TextButton(
                           onPressed:(){
                             Navigator.of(context).pop();
                           }, 
                           child: const Text('OK')
                          ),
                       ],
                     )
                  ).then((value){
                    if(result.data ?? false){
                      Navigator.of(context).pop(true);
                    }
                  });
                     
                  }
                }, 
                child: const Text('Submit'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blueAccent,
                  shadowColor: Colors.black,
                  elevation: 5
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}