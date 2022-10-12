// import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'dart:convert';

import 'package:sqflite/sqflite.dart';
import '../constants/src/database_constant.dart';
import '../screens/todoScreen/models/todo_model.dart';



class Database {
  static var DB;

  ///a variable for storing our open db instance

//
//   // creating a db connector function below
//   static Future<void> DbConnector() async {
//     var dbffi;
//     String DbPath;
//     try{
//       sqfliteFfiInit(); // instantiating our sqlite db engine
//
//       dbffi= databaseFactoryFfi; //thi instantiates databaseFactoryFfi for core sqlite function and binding
//
//       // to get the db path in alignment to the platform and store it in dbpath
//       DbPath = await databaseFactoryFfi.getDatabasesPath().toString()+"/todolist.db";
//
//       // to open up or create the bd if not existing in that bd path
//       DB = databaseFactoryFfi.openDatabase(DbPath);
//       if (DB.toString().isNotEmpty){
//         print("db connect $DbPath");}
//       else{
//         print("db error $DbPath");
//       }
//       return DB;
//     } on Exception catch (e){
//       print("db error $e");}
//   }

  static Future<void> DBconnector() async {
    String dbName = "/todo1.db";

    // get the mobile default DB path
    // store the path as a variable
    String mobileDBpath = await getDatabasesPath();

    /// because this is a future method we need to await it to get the a string value else storing future value in string = error

    String dbPath = mobileDBpath + dbName;
    print('db path $dbPath');

    /// to align our path we join the name of the db path to the db name

    DB = await openDatabase(dbPath, version: 1, onCreate: (DB, version) {
      ///to open our db with this db instance
      print("(yes we created it)");
    }, onOpen: (db) {
      DB = db;
      createTables();
    });
  }//DBconnector

  static Future<void> createTables() async {
    /// lets create a todo table

    try {
      DB.execute('''
  create table ${Db_c.todoTable} (${Db_c.todo_id} integer primary key autoincrement, ${Db_c.todo_title} text, ${Db_c.todo_description} text, ${Db_c.todo_date} text, ${Db_c.todo_time} text )''');
      print("todoTable is created");
    } on Exception catch (e) {
      print("todoTable is not created");
    }
  }//createTables

  ///-------------------------------------------

  static Future<void> insertTodo({required String todo_title,
    required String todo_description,
    required String todo_date,
    required String todo_time}) async {
    /// statement method  insert values right inside the sql statement
    ///    insert into tablename (col1,col2,col3)  values(val1,val2,val3);
    print("my title $todo_title");
    try {
      DB?.execute(
          '''INSERT INTO ${Db_c.todoTable} (${Db_c.todo_title}, ${Db_c.todo_description}, ${Db_c.todo_date}, ${Db_c.todo_time}) values(?,?,?,?)''',
          [todo_title, todo_description, todo_date, todo_time]).whenComplete(() {
        print("Inserted Todo Successfully ");
        selctToDo();
      });
    } on Exception catch (e) {
      print("Insert Todo Error $e");
    }
  }//insertTodo

  static Future<bool> updateTodoa
    ({
    required var ID,
    required String todo_title,
      required String todo_description,
      required String todo_date,
      required String todo_time})async{
    try {
      await DB?.execute(
          "UPDATE ${Db_c.todoTable} Set ${Db_c.todo_title} = ?, ${Db_c.todo_description} = ?,${Db_c.todo_time} = ?, ${Db_c.todo_date} = ? WHERE ${Db_c.todo_id}= ? ",
          [todo_title,todo_description,todo_time,todo_date,ID]);
      print("updated successfully");
      selctToDo();
      return true;
    } on Exception catch (e) {
      print("not updated");
      return false;
    }
  }//updateTodoa

  static Future<List/*<TodoModel>*/> selctToDo() async {
    List<Map<String,dynamic>> Result = await DB!.rawQuery("SELECT * FROM ${Db_c.todoTable}");
    // var Result = await DB!.rawQuery("SELECT * FROM ${Db_c.todoTable} WHERE ${Db_c.todo_description} = ? ",["a good place"]);
    // var Result = await DB!.rawQuery("SELECT * FROM ${Db_c.todoTable} WHERE ${Db_c.todo_description} LIKE ? ",["%good%"]);
    // var Result = await DB!.rawQuery("SELECT * FROM ${Db_c.todoTable} WHERE ${Db_c.todo_description} LIKE ? OR ${Db_c.todo_title} LIKE ?",["%good%","%london%"]);
    if (Result.length != 0) {
      print(" ${Result}");
      // List<TodoModel> todoList= Result.map((json) => TodoModel.fromjson(json)).toList(); /// this is the shortcut method
      List</*TodoModel*/void> todoList=[];

      for (int i = 0; i < Result.length; i++){
        Map mapresult = Result[i];
        /// the code below creates an ability to serially store the mapResult in our
        /// todoList; each one as an instance
        todoList.add(TodoModel.fromjson(mapresult));

      }//for Loop

      return todoList;

    } else {
      print("Result is  empty");
      return [];
    }
  }// insertTodo

  static Future<void> deleteTodo({var ID}) async{

    try {
      await DB?.execute(" DELETE FROM ${Db_c.todoTable} WHERE ${Db_c.todo_id} = ? ", [ID]);
      print("file deleted ");
    } on Exception catch (e) {
      print("delete failed $e");
    }
  }//deleteTodo

  static Future<List>/*TodoModel*/searchTodo(String search)async {
    /// this would be used to perform search querying
    /// of any appearance of such values

    var Result = await DB!.rawQuery("SELECT * FROM ${Db_c.todoTable} WHERE ${Db_c.todo_title} LIKE ? ",["%$search%"]);
//     var Result = await DB!.rawQuery("SELECT * FROM ${Db_c.todoTable} WHERE ${Db_c.todo_description} LIKE ? OR ${Db_c.todo_title} LIKE ? ",["%good%","%london%"]);

    if (Result.length != 0) {
      /// since our result is a list of map then we need to loop through it and store its ind
      /// individual element as an instance of  our todomodel and store it as a list
      ///
      // List<TodoModel> todoList=Result.map((json) => TodoModel.fromjson(json)).toList();
      List</*TodoModel*/void> todoList = [];

      ///or
      for (int i = 0; i < Result.length; i++) {
        Map mapresult = Result[i];

        /// let serialize the  mapresult and store it in an instance and store it in  our todoList
        todoList.add(TodoModel.fromjson(mapresult));
      }

      print("Result is not udtate empty  ${Result}");
      return todoList;
    } else {
      print("Result is  empty");
      return [];
    }
  }
  } //Database

