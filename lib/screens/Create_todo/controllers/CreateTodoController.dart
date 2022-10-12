import 'package:a_todo_app/constants/constants_and_imports.dart';
import '../../../database/database.dart';
import 'package:intl/intl.dart';

class CreateTodoController extends ChangeNotifier {
  String selectedTime = "Start Time";
  String selectedDate = "select Date";
  bool isDone = false;
  bool isUpDated = false;

  Future<void> createTodo(
      {required BuildContext context,
      required String todo_title,
      required String todo_description,
      required String todo_date,
      required String todo_time}) async {
    if (selectedDate == "select Date") {
      var dayplusOne = DateTime.now().add(Duration(days: 1));
      selectedDate =
          DateFormat("EEE,dd MMM, yyyy").format(dayplusOne).toString();
      notifyListeners();
    }
    if (selectedTime == "Start Time") {
      selectedTime = TimeOfDay.now().format(context).toString();
      notifyListeners();
    }
    Database.insertTodo(
            todo_title: todo_title,
            todo_description: todo_description,
            todo_date: selectedDate,
            todo_time: selectedTime)
        .whenComplete(() {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.greenAccent, content: Text("Todo created")));
      print("done inserting");
      isDone = true;
      notifyListeners();
    });
  }

  Future<void> upDateTodo(
      {required BuildContext context,
      required var ID,
      required String todo_title,
      required String? todo_description,
      required String? todo_date,
      required String? todo_time}) async {
    Database.updateTodoa(
      todo_title: todo_title,
      todo_description: todo_description!,
      todo_date: selectedDate,
      todo_time: selectedTime,
      ID: ID,
    ).whenComplete(() {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.greenAccent, content: Text("Todo created")));
      print("done inserting");
      isDone = true;
      notifyListeners();
    });
  }

  String showCalender(BuildContext context) {
    DateTime initialDate = DateTime.now();
    DateTime firstDate = DateTime(DateTime.now().year);
    DateTime lastDate = DateTime(2100);
    var dayplusOne = DateTime.now().add(Duration(days: 1));

    showDatePicker(
            context: context,
            confirmText: "Select Todo Date",
            cancelText: "Cancel",
            initialDate: initialDate,
            firstDate: firstDate,
            lastDate: lastDate)
        .then((value) {
      if (value != null) {
        selectedDate = DateFormat("EEE,dd MMM, yyyy").format(value).toString();
      } else {
        selectedDate =
            DateFormat("EEE,dd MMM, yyyy").format(dayplusOne).toString();
      }
      notifyListeners();
    });
    notifyListeners();
    return selectedDate;
  }

  String showTime(BuildContext context) {
    TimeOfDay initialTime = TimeOfDay.now();
    // TimeOfDay firstTime = DateTime(DateTime.now().year);
    // TimeOfDay lastDate = DateTime(2100);

    showTimePicker(
        context: context,
        confirmText: "Select Todo Time",
        cancelText: "Cancel",
        initialTime: initialTime,
        // builder: (context, childWidget) {
        //   return MediaQuery(
        //       data:
        //           MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
        //       child: childWidget!);
        // }
        builder: (context, child) {
          return MediaQuery(
              data:
                  MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
              child: child!);
        }).then((value) {
      if (value != null) {
        selectedTime = value.format(context);
        notifyListeners();
      } else {
        selectedTime = TimeOfDay.now().format(context).toString();
        notifyListeners();
      }
    });
    notifyListeners();
    return selectedTime;
  }
}
