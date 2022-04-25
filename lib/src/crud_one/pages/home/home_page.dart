import 'package:appcrudflutter/src/crud_one/pages/note_page/note_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
 const  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children:[
              ElevatedButton(
                onPressed: (){
                  Navigator.push(context, 
                    MaterialPageRoute( builder:(context) =>const NotePage() )
                  );
                },
                child:const Text('Button')
              )
            ]
          ),
        ),
      ),
    );
  }
}