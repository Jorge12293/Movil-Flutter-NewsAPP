import 'package:appcrudflutter/src/crud_two/controllers/todo_controller.dart';
import 'package:appcrudflutter/src/crud_two/models/todo.dart';
import 'package:appcrudflutter/src/crud_two/repositories/todo_repository.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var todoContorller = TodoController(TodoRepository());
    todoContorller.fetchTodoList();


    return Scaffold(
      appBar: AppBar(
        title: const Text('Rest Api '),
      ),
      body: FutureBuilder<List<Todo>>(
        future: todoContorller.fetchTodoList(),
        builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator());
          }

          if(snapshot.hasError){
            return const Center(
              child: Text('Has error'),
            );
          }

          return SafeArea(
            child: ListView.separated(
              itemBuilder: (context,index){
                var todo = snapshot.data?[index];
                return Container(
                  height: 100.0,
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Expanded(flex: 1,child: Text('${todo?.id}')),
                      Expanded(flex: 3,child: Text('${todo?.title}')),
                      Expanded(
                        flex: 3,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap:(){
                                todoContorller.updatePatchCompted(todo!)
                                .then((value){
                                  ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                    duration: const Duration(milliseconds: 500),
                                    content: Text(value)
                                  ));
                                });
                              },
                              child: builCallController('Patch',Colors.blueGrey)
                            ),
                            InkWell(
                              onTap:(){
                                todoContorller.updatePutCompleted(todo!);
                              },
                              child: builCallController('Put',Colors.orangeAccent)
                            ),
                            InkWell(
                              onTap:(){
                                todoContorller.deleteTodoCompleted(todo!)
                                .then((value){
                                  ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                    duration: const Duration(milliseconds: 500),
                                    content: Text(value)
                                  ));
                                });
                              },
                              child: builCallController('Del',Colors.blueAccent)
                            )
                          ],
                        )
                      )
                    ],
                  ),
                );
              
              }, 
              separatorBuilder: (context,index){
                return const Divider(
                  thickness: 0.5,
                  height: 0.5,
                );
              },
              itemCount: snapshot.data?.length ?? 0
            ),
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Todo _todo = Todo(
            userId:3, 
            title:'Sample post', 
            completed:false
          );
          todoContorller.postTodoCompleted(_todo);
        },
        child:const Icon(Icons.add),
      ),
    );
  }
 

  Container builCallController(String title,Color color){
    return Container(
      width: 40.0,
      height: 40.0,
      decoration: BoxDecoration(
        color: color,
        borderRadius:BorderRadius.circular(10.0) 
      ),
      child:Center(child: Text(title)),
    );
  }




}