
import 'package:appcrudflutter/src/crud_one/models/api_response.dart';
import 'package:appcrudflutter/src/crud_one/models/note.dart';
import 'package:appcrudflutter/src/crud_one/pages/note_page/note_delete.dart';
import 'package:appcrudflutter/src/crud_one/pages/note_page/note_modify.dart';
import 'package:appcrudflutter/src/crud_one/services/note_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class NotePage extends StatefulWidget {
 const NotePage({Key? key}) : super(key: key);

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
 
 late APIResponse _apiResponse; 
 late NoteService _service;

 bool loadNotes = true;
 List<Note> noteList = [];
 
  String formatDateTime(DateTime dateTime){
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

 @override
  void initState(){
    _service =  GetIt.instance<NoteService>();
    getService();
    super.initState();
  }

  void getService() async {
    setState(() {
      loadNotes = true;
    });

    _apiResponse = await _service.getListNotes();

    if(!_apiResponse.error){
  
      noteList = _apiResponse.data as List<Note>;
    }

    setState(() {
      loadNotes = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List of Notes'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context)
            .push(MaterialPageRoute(builder:(_) => NoteModify()))
            .then((value) => {
              if(value != null){
                getService()
              }
            });
        },
        child: const Icon(Icons.add),
      ),
      body: Builder(
        builder: (_){

          if (loadNotes){
           return Center(
              child:Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:const[
                    CircularProgressIndicator(
                      strokeWidth: 10,
                      backgroundColor: Colors.blueAccent,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.orangeAccent),
                    ),
                    SizedBox(height:40),
                    LinearProgressIndicator(),
                  ],
                ),
              )
            );
          }
      
          if(_apiResponse.error){
            return Center(
              child: Text(_apiResponse.errorMensaje)
            );
          }

          return ListView.separated(
            itemCount: noteList.length,
            separatorBuilder: ( _, __) =>const Divider(height: 1,color: Colors.green), 
            itemBuilder:(_,index){
              return Dismissible(
                key: UniqueKey(),
                direction: DismissDirection.startToEnd,
                onDismissed: (direction){},
                confirmDismiss: (direction) async {
                  final result = await  showDialog(
                    context: context, 
                    builder: (_)=>const NoteDelete());
                  
                  if(result){
                      setState(() {
                        loadNotes = true;
                      });
                      final deleteResult = await _service.deleteNote(noteList[index].noteId);
                      
                      String message;
                      if(deleteResult.error == true){
                        message = 'The note was delated succesafully';
                      }else{
                        message = deleteResult.errorMensaje;
                      }
                      setState(() {
                        loadNotes = false;
                      });
/*
                      showDialog(
                        context: context, 
                        builder: (_) => AlertDialog(
                          title: Text('Done'),
                          content: Text(message),
                          actions: [
                            TextButton(
                              onPressed: (){
                                Navigator.of(context).pop();
                              }, 
                              child: Text('OK')
                            )
                          ],    
                        )
                      );
              */        
                      // REVISAR 
                      ScaffoldMessenger.of(context).showSnackBar(
                         SnackBar(content:Text(message,style: TextStyle(color: Colors.white),),duration: const Duration(milliseconds: 1000))
                      );
                      
                       
                    return deleteResult.data;
                  }
                  return result;  
                },
                background: Container(
                  color: Colors.red,
                  padding:const EdgeInsets.only(left: 16),
                  child: const Align(
                    child: Icon(Icons.delete, color:Colors.white),
                    alignment: Alignment.centerLeft,
                  ),
                ),
                child: ListTile(
                  title:Text(noteList[index].noteTitle, style:TextStyle(color:Theme.of(context).primaryColor) ),
                  subtitle:Text('Last edited ${formatDateTime(noteList[index].latestEditDateTime)} '),
                  onTap: (){
                    Navigator.of(context)
                      .push(MaterialPageRoute(builder:(_) => NoteModify(noteId:noteList[index].noteId)))
                      .then((value) => {
                        if(value != null){
                          getService()
                        }
                      });
                  },
                ),
              );
            } 
          );
        },
      )      
    );
  }
}