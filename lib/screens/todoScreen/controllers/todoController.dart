import 'package:a_todo_app/constants/constants_and_imports.dart';

import '../../../database/database.dart';
import '../../Create_todo/createTodo.dart';

import '../models/todo_model.dart';

class TodoController extends ChangeNotifier {
  String searchTerm="";

  set searchTerms(search){
    searchTerm = search;
    notifyListeners();
  }

  TodoController(){futureawait;}
  var future;
  Future<Future<List>> get futureawait async {

    /// using this method to store everything from our selectTodo
    /// in a future variable as opposed to using just a get method
    future= Database.selctToDo();
    notifyListeners();
    return future;
  }

  Future<void> deleteTodo(
      {required var ID, required BuildContext context}) async {
       Database.deleteTodo(ID: ID).whenComplete(() async {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Deleted"),
        backgroundColor: Colors.redAccent));
      await future;
      notifyListeners();
    });
  }

  Future<void> search({required String searchTerm})async{
    future = Database.searchTodo(searchTerm);
    notifyListeners();
  }

  Future<void> openCreateTodo({required BuildContext context, required snapshot})async{
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return CreateTodo(snapshot: snapshot,);
    },)).then((value) async {
      await future;
      notifyListeners();
      print(value);
    });
  }

  void navigatetocreate(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const CreateTodo(),
        )).whenComplete(() async {
      await future;
      notifyListeners();
    });
  }
}
