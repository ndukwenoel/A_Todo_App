import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:a_todo_app/database/database.dart';
import 'package:a_todo_app/screens/todoScreen/pageWidget/todoCard.dart';

import 'controllers/CreateTodoController.dart';

class CreateTodo extends StatefulWidget {
  const CreateTodo({Key? key, this.snapshot}) : super(key: key);
  final snapshot;

  @override
  State<CreateTodo> createState() => _CreateTodoState();
}

class _CreateTodoState extends State<CreateTodo> {
  var _future;
  TextEditingController? title;
  TextEditingController? description;

  @override
  initState() {
    title = TextEditingController(
        text: widget.snapshot == null ? "" : widget.snapshot.title);
    description = TextEditingController(
        text: widget.snapshot == null ? " " : widget.snapshot.description);

    super.initState();
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var providerListenTrue =
        Provider.of<CreateTodoController>(context, listen: true);
    var providerListenFalse =
        Provider.of<CreateTodoController>(context, listen: false);
    return WillPopScope(
      onWillPop: () async {
        print("willPopScope");

        /// using this to return values back to the previous page
        /// so applying the use of Navigator.pop(context, 'something');
        if (widget.snapshot != null) {
          bool update = await Database.updateTodoa(
              ID: widget.snapshot.ID,
              todo_title: title!.text,
              todo_description: description!.text,
              todo_date: providerListenTrue.selectedDate,
              todo_time: providerListenTrue.selectedTime);
          if (update) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.green,
              content: Text("Updated Successfully"),
            ));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.red, content: Text("Updating Failed")));
          }
          Navigator.pop(context, "Update");
        }
        return true;
      },
      child: Scaffold(
        backgroundColor: const Color(0xffF0F0F0),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: widget.snapshot != null
            ? const SizedBox()
            : FloatingActionButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    providerListenFalse.createTodo(
                        context: context,
                        todo_title: title!.text,
                        todo_description: description!.text,
                        todo_date: providerListenTrue.selectedDate,
                        todo_time: providerListenTrue.selectedTime);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        backgroundColor: Colors.red,
                        content: Text('Fill up all input fields')));
                  }
                },
                elevation: 10,
                hoverElevation: 20,
                child: const Icon(Icons.done_all_rounded)),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomCenter,
                    colors: [
                  Colors.purple.withOpacity(0.3),
                  Colors.white70,
                  Colors.white,
                ])),
            child: AppBar(
              backgroundColor: Colors.transparent,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(flex: 2),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Spacer(flex: 7,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Create Todo",
                              style: TextStyle(
                                  color: providerListenTrue.isDone
                                      ? Colors.green
                                      : Colors.purple,
                                  fontSize: 40)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Form(
          key: formKey,
          child: ListView(children: [
            Padding(
                padding: const EdgeInsets.only(top: 13.0, left: 10, right: 10),
                child: SizedBox(
                  height: 80,
                  width: 300,
                  child: TextFormField(
                    controller: title,
                    validator: (validate) {
                      if (validate!.isEmpty) {
                        return "Title Required";
                      }
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.notes),
                      labelText: "Title",
                      labelStyle: TextStyle(fontSize: 30),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(
                            style: BorderStyle.solid,
                            width: 2,
                            color: Colors.purple),
                      ),
                    ),
                  ),
                )),
            Padding(
                padding: const EdgeInsets.only(top: 13.0, left: 10, right: 10),
                child: SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: description,
                    maxLines: 10,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.notes),
                      labelText: "Description",
                      labelStyle: TextStyle(fontSize: 30),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(
                            style: BorderStyle.solid,
                            width: 2,
                            color: Colors.purple),
                      ),
                    ),
                  ),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      providerListenFalse.showCalender(context);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.date_range_outlined),
                        Text(providerListenTrue.selectedDate)
                      ],
                    )),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                    onPressed: () {
                      providerListenFalse.showTime(context);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.timer),
                        Text(providerListenTrue.selectedTime)
                      ],
                    ))
              ],
            )
          ]),
        ),
      ),
    );
  }
}
