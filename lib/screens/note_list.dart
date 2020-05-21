import 'package:flutter/material.dart';
import 'package:notekeeper/screens/note_detail.dart';
import 'dart:async';
import 'package:notekeeper/models/note.dart';
import 'package:notekeeper/utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';
class NoteList extends StatefulWidget{


@override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return NoteListState();
  }
}
class NoteListState extends State<NoteList> {
  DatabaseHelper databaseHelper= DatabaseHelper();
  List<Note> noteList;
  int count=0;

  @override
  Widget build(BuildContext context) {
    if(noteList==null){
      noteList=List<Note>();
    }
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: getNoteListView(),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            debugPrint('FAB clicked');
            navigateToDetail('Add Note');
          },
        tooltip: 'Add Note',
        
        child: Icon(Icons.add),
      ),
    );
  }

  ListView getNoteListView() {
    TextStyle titleStyle = Theme.of(context).textTheme.subhead;

    return ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext, int position){
          return Card(
            elevation: 2.0,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.yellow,
                child: Icon(Icons.keyboard_arrow_right),
              ),
              title: Text('Dummy Title', style: titleStyle,),

              subtitle: Text('Dummy Date'),

              trailing: Icon(Icons.delete, color: Colors.grey,),
              onTap: (){
                debugPrint('ListTile Tapped');
                navigateToDetail('Edit Note');
              },
            ),

          );
      },

    );
  }

  //HELPER CLASS
  //PRIORITY COLOR
  Color getPriorityColor(int priority){
    switch (priority){
      case 1:
        return Colors.red;
      case 2:
        return Colors.yellow;
      default:
        return Colors.yellow;
    }
  }
  //PRIORITY ICON
  Icon getPriorityIcon(int priority){
    switch (priority){
      case 1:
        return Icon(Icons.play_arrow);
        break;
      case 2:
        return Icon(Icons.keyboard_arrow_right);
        break;
      default:
        return Icon(Icons.keyboard_arrow_right);
        break;
    }
  }

  void _delete(BuildContext context, Note note)async{
    int result=await databaseHelper.deleteNote(note.id);
    if(result!=0){
      _showSnackBar(context, 'Note Deleted Successfully');
    }
  }

  void _showSnackBar(BuildContext context, String message)

  void navigateToDetail(String title){
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return NoteDetail(title);
    }));
  }
}

