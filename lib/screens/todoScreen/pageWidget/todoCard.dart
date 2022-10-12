import 'package:a_todo_app/screens/Create_todo/controllers/CreateTodoController.dart';
import 'package:a_todo_app/screens/Create_todo/createTodo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:substring_highlight/substring_highlight.dart';

import '../../todoScreen/controllers/todoController.dart';

class TodoCard extends StatelessWidget {
  TodoCard({
    Key? key,
    required this.snapshot,
    this.searchTerm,
  }) : super(key: key);
  final snapshot;
  final String? searchTerm;
  GlobalKey mykey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    var providerListenTrue = Provider.of<TodoController>(context, listen: true);
    var providerListenFalse =
        Provider.of<TodoController>(context, listen: false);
    return Dismissible(
      key: mykey,
      direction: DismissDirection.horizontal,
      onDismissed: (dismissdirection) {
        print("snapshot");
        providerListenFalse.deleteTodo(ID: snapshot.ID, context: context);
      },
      background: Container(
        color: Colors.purple,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            Icon(
              Icons.delete,
              color: Colors.white,
              size: 50,
            ),
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
            height: 100,
            width: MediaQuery.of(context).size.width,
            child: Material(
              elevation: 2,
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              shadowColor: Colors.purple,
              child: SizedBox(
                height: 100,
                child: ListTile(
                  leading: const Icon(
                    Icons.notes,
                    color: Colors.purple,
                  ),
                  title: SubstringHighlight(
                    text: snapshot.title.toString(), //each string needs highlighting
                    term: searchTerm, // what the user typed
                    textStyle:
                        const TextStyle(// non-highlighting style
                            fontSize: 26, fontWeight: FontWeight.w400, color: Colors.black),
                    textStyleHighlight: const TextStyle(// highlight style
                      color:  Colors.green, fontSize: 30,
                    ),
                  ),
                  subtitle: Row(children: [
                    const Icon(
                      Icons.date_range_outlined,
                      color: Colors.purple,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(snapshot.date.toString(),
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400)),
                    )
                  ]),
                  trailing: SizedBox(
                    width: 200,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const SizedBox(
                            height: 25,
                          ),
                          FittedBox(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const Icon(
                                    Icons.alarm_add_sharp,
                                    color: Colors.purple,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(snapshot.time.toString(),
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400))
                                ]),
                          )
                        ]),
                  ),
                  onTap: () {
                    print("clicked");
                    Provider.of<CreateTodoController>(context,listen: false).selectedTime=snapshot.time;
                    Provider.of<CreateTodoController>(context,listen: false).selectedDate=snapshot.date;
                    Provider.of<TodoController>(context,listen: false).openCreateTodo(context: context, snapshot: snapshot);
                  },
                ),
              ),
            )),
      ),
    );
  }
}