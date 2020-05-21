import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:notekeeper/models/note.dart';

class DatabaseHelper{

  static DatabaseHelper _databaseHelper;
  static Database _database;

  String noteTable='note_table';
  String colId='id';
  String colTitle='title';
  String colPriority='priority';
  String colDate='date';
  String colDescription='description';


  DatabaseHelper._createInstance();//named consrtuctor

  factory DatabaseHelper(){

    if(_databaseHelper==null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }
  Future<Database> get database async{
    if(_database==null){
      _database=await initializeDatabase();
    }
    return _database;

  }

  Future<Database>initializeDatabase()async{
    //get the path of both andriod and ios store
    Directory directory= await getApplicationDocumentsDirectory();
    String path= directory.path +'notes.db';
    //datbase at the given path
    var notesDatabase=await openDatabase(path, version:1, onCreate: _createDb);
    return notesDatabase;
  }

  void _createDb(Database db, int newVersion) async{
    await db.execute('CREATE TABLE $noteTable($colId INTERGER PRIMARY KEY AUTOINCREMENT,$colTitle TEXT,''$colDescription TEXT, $colPriority INTEGER, $colDate TEXT');
  }

  //for performing the CRUD operations
//FETCH
  Future<List<Map<String, dynamic>>>getNoteMapList()async{
    Database db=await this.database;
//USING RAW QUERY
//    var result=await db.rawQuery('SELECT*FROM $noteTable order by $colPriority ASC');
    //USING HELPER
    var result=await db.query('$noteTable order by $colPriority ASC');
    return result;
  }

  //INSERT
  Future<int> insertNote(Note note)async{
    Database db=await this.database;
    var result= await db.insert(noteTable, note.toMap());
    return result;
  }
  //UPDATE
  Future<int>updateNote(Note note)async{
    var db= await this.database;
    var result= await db.update(noteTable, note.toMap(),where: '$colId=?',whereArgs: [note.id]);
    return result;
  }
  //DELETE
  Future<int>deleteNote(int id)async{
    var db=await this.database;
    int result= await db.rawDelete('DELETE FROM $noteTable WHERE $colId=$id');
    return result;
  }
  //no. of data
Future<int>getCount() async{
    Database db=await this.database;
    List<Map<String, dynamic>> x=await db.rawQuery('SELECT COUNT (*) from$noteTable');
    int result= Sqflite.firstIntValue(x);
    return result;
}

}